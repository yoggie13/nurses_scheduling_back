const dotenv = require("dotenv");
dotenv.config();
const { query } = require("express");
const express = require("express");
const mysql = require("mysql2/promise");
var cors = require("cors");
var corsOptions = {
  origin: "http://example.com",
  optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
};
const open = require("open");

const connection = async () => {
  return await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });
};

const e = require("express");

const PORT = process.env.PORT || 3001;

const app = express();

app.options("nurses/", cors());
app.use(cors());

const checkIfRequestEmpty = (req) => {
  return (
    req === undefined || req === null || Object.keys(req).length === 0
    // Object.getPrototypeOf(req) === Object.prototype
  );
};
const startTransaction = async (db_connection) => {
  await db_connection.query("START TRANSACTION");
};
const commitTransaction = async (db_connection) => {
  await db_connection.query("COMMIT");
};
const rollBackTransaction = async (db_connection) => {
  await db_connection.query("ROLLBACK");
};

const addNonWorkingDays = async (request, schid, res, month, db_connection) => {
  try {
    var rows = [request];
    if (request.DayType === 2) {
      rows = [];
      for (let i = request.DateFrom; i <= request.DateUntil; i++) {
        var row = {
          NurseID: request.NurseID,
          IsMandatory: request.IsMandatory,
        };
        var day = new Date(new Date().getFullYear(), month - 1, i).getDay();
        if (day === 0 || day === 6) {
          row.DateFrom = i;
          row.DayType = 1;
          if (day === 6 && i + 1 <= request.DateUntil) row.DateUntil = i + 1;
          else row.DateUntil = i;
        } else {
          row.DateFrom = i;
          row.DayType = 2;
          row.DateUntil = Math.min(request.DateUntil, i + 5 - day);
        }
        rows.push(row);
        i = row.DateUntil;
      }
    }
    await rows.forEach(async (r) => {
      await db_connection.query(
        "insert into nonworkingdays values " +
          `(${schid},${r.NurseID},${r.DateFrom},${r.DateUntil},${r.DayType},${r.IsMandatory})`
      );
    });
  } catch (err) {
    throw err;
  }
};
const addNonWorkingShifts = async (request, schid, res, db_connection) => {
  try {
    await request.Shifts.forEach(async (shift, index) => {
      if (shift) {
        await db_connection.query(
          `INSERT INTO nonworkingshifts values(${schid},${request.NurseID},${
            request.DateFrom
          },${request.DateUntil},${index + 1},${request.IsMandatory})`
        );
      }
    });
  } catch (err) {
    throw err;
  }
};
const addMustWorkShifts = async (request, schid, res, db_connection) => {
  try {
    await db_connection.query(
      `INSERT INTO mustworkshifts values(${schid}, ${request.NurseID}, ${request.ShiftID}, ${request.DateFrom}, ${request.DateUntil})`
    );
  } catch (err) {
    throw err;
  }
};
const addSpecialNeeds = async (request, schid, res, db_connection) => {
  try {
    await db_connection.query(
      `INSERT INTO specialneedsshifts values(${schid}, ${request.Day}, ${request.ShiftID}, ${request.NumberOfNurses})`
    );
  } catch (err) {
    throw err;
  }
};
const getAssignementsForSchedule = async (id, db_connection) => {
  try {
    const [result] = await db_connection.query(
      `SELECT a.NurseID, n.Name, n.Surname, a.Day, p.Symbol, p.Duration FROM assignements a ` +
        `JOIN nurses n on (a.NurseID = n.NurseID) JOIN Patterns p on (a.PatternID = p.PatternID) WHERE a.ScheduleID = ${id} order by a.NurseID, a.Day;`
    );
    return Object.values(JSON.parse(JSON.stringify(result)));
  } catch (err) {
    throw err;
  }
};
const getNWDForSchedule = async (id, db_connection) => {
  try {
    const [result] = await db_connection.query(
      `SELECT nwd.NurseID,  n.Name, n.Surname, nwd.DateFrom, nwd.DateUntil, nwdt.Symbol, nwdt.NumberOfHours FROM nonworkingdays nwd` +
        ` JOIN nonworkingdaytypes nwdt ON (nwd.NonWorkingDayTypeID = nwdt.NonWorkingDayTypeID) JOIN nurses n ON (nwd.NurseID = n.NurseID)` +
        ` WHERE ScheduleID = ${id} order by n.NurseID, nwd.DateFrom;`
    );

    return Object.values(JSON.parse(JSON.stringify(result)));
  } catch (err) {
    throw err;
  }
};
const formatAssAndNwd = (assignedDays, nonWorkingDays) => {
  assignedDays.forEach((a) => {
    a.Working = true;
  });

  var nonWorkingDaysFormatted = [];
  nonWorkingDays.forEach((nwd) => {
    for (let p = nwd.DateFrom; p <= nwd.DateUntil; p++) {
      nonWorkingDaysFormatted.push({
        NurseID: nwd.NurseID,
        Name: nwd.Name,
        Surname: nwd.Surname,
        Day: p,
        Symbol: nwd.Symbol,
        Duration: nwd.NumberOfHours,
        Working: false,
      });
    }
  });

  var toFormat = [];

  for (let p = 0; p < assignedDays.length; p++) {
    var ad_nid = assignedDays[p].NurseID;
    for (let q = 0; q < nonWorkingDaysFormatted.length; q++) {
      if (assignedDays[p].NurseID === nonWorkingDaysFormatted[q].NurseID) {
        if (nonWorkingDaysFormatted[q].Day < assignedDays[p].Day) {
          toFormat.push(nonWorkingDaysFormatted[q]);
          nonWorkingDaysFormatted.splice(q, 1);
          q--;
        } else if (nonWorkingDaysFormatted[q].Day > assignedDays[p].Day) {
          toFormat.push(assignedDays[p]);
          assignedDays.splice(p, 1);
          q--;
        } else if (nonWorkingDaysFormatted[q].Day === assignedDays[p].Day) {
          toFormat.push(assignedDays[p]);
          assignedDays.splice(p, 1);
          nonWorkingDaysFormatted.splice(q, 1);
          q--;
        }
      } else {
        break;
      }
    }
    while (assignedDays.length > 0 && assignedDays[p].NurseID === ad_nid) {
      toFormat.push(assignedDays[p]);
      assignedDays.splice(p, 1);
    }
    var v = 0;
    while (
      nonWorkingDaysFormatted.length > 0 &&
      nonWorkingDaysFormatted[v].NurseID === ad_nid
    ) {
      toFormat.push(nonWorkingDaysFormatted[v]);
      nonWorkingDaysFormatted.splice(v, 1);
    }
    p--;
  }

  for (let q = 0; q < nonWorkingDaysFormatted.length; q++) {
    toFormat.push(nonWorkingDaysFormatted[q]);
    nonWorkingDaysFormatted.splice(q, 1);
  }

  var nid = toFormat[0].NurseID;
  var final = [];
  var j = 0;

  for (let i = 0; i < toFormat.length; i++) {
    if (i === 0 || nid !== toFormat[i].NurseID) {
      nid = toFormat[i].NurseID;

      final.push({
        NurseID: nid,
        NurseName: toFormat[i].Name + " " + toFormat[i].Surname,
        Days: [
          {
            Day: toFormat[i].Day,
            Symbol: toFormat[i].Symbol,
            Duration: toFormat[i].Duration,
            Working: toFormat[i].Working,
          },
        ],
      });
      j++;
    } else {
      final[j - 1].Days.push({
        Day: toFormat[i].Day,
        Symbol: toFormat[i].Symbol,
        Duration: toFormat[i].Duration,
        Working: toFormat[i].Working,
      });
    }
  }
  return final;
};
const addMainNursesAssignements = async (
  db_connection,
  schid,
  WorkingDays,
  nonWorkingDays
) => {
  const [result] = await db_connection.query(
    "SELECT NurseID from nurses where Active = 1 and Main = 1 and InDepartment = 1"
  );

  for (let k = 0; k < result.length; k++) {
    for (let i = 0; i < WorkingDays.length; i++) {
      var broke = false;
      for (let j = 0; j < nonWorkingDays.length; j++) {
        if (
          nonWorkingDays[j].NurseID === result[k].NurseID &&
          WorkingDays[i] >= nonWorkingDays[j].DateFrom &&
          WorkingDays[i] <= nonWorkingDays[j].DateUntil
        ) {
          if (WorkingDays.includes(nonWorkingDays[j].DateUntil))
            i = WorkingDays.indexOf(nonWorkingDays[j].DateUntil);
          else if (WorkingDays.includes(nonWorkingDays[j].DateUntil - 1))
            i = WorkingDays.indexOf(nonWorkingDays[j].DateUntil - 1);
          else i = WorkingDays.indexOf(nonWorkingDays[j].DateUntil - 2);
          broke = true;
          break;
        }
      }

      if (!broke) {
        // console.log(`${k} - ${result[k].NurseID}`);
        // console.log(`${i} - ${WorkingDays[i]}`);
        await db_connection.query(
          `insert into assignements values (${schid}, ${result[k].NurseID}, ${WorkingDays[i]}, 1)`
        );
      }
    }
  }
};
const getNonDepartmentNurses = async (db_connection) => {
  try {
    const [result] = await db_connection.query(
      "SELECT * from nurses where Active = 1 and InDepartment = 0"
    );

    var ret = [];
    result.forEach((n) => {
      ret.push({
        NurseID: n.NurseID,
        NurseName: n.Name + " " + n.Surname,
        Days: [],
      });
    });

    return ret;
  } catch (err) {
    throw err;
  }
};
app.use(
  express.urlencoded({
    extended: true,
  })
);

app.use(express.json());

app.listen(PORT, () => {
  console.log(`Server listening on ${PORT}`);
});

app.get("/nursesForSelect", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      "SELECT * FROM nurses  where Active = 1"
    );

    var ret = [];
    await result.forEach((nurse) => {
      ret.push({
        id: nurse.NurseID,
        label: `${nurse.Name} ${nurse.Surname}`,
      });
    });
    res.json(ret);
  } catch (err) {
    res.status(400).send("Greška pri čitanju podataka iz baze");
  } finally {
    await db_connection.end();
  }
});
app.get("/daysForSelect", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.execute(
      "SELECT * FROM nonworkingdaytypes where Active = 1"
    );
    var ret = [];
    await result.forEach((day) => {
      ret.push({
        id: day.NonWorkingDayTypeID,
        label: day.Name,
      });
    });
    res.json(ret);
  } catch (err) {
    res.status(400).send("Greška pri učitavanju podataka iz baze");
  } finally {
    await db_connection.end();
  }
});
app.put("/nurses/:id/delete", async (req, res) => {
  const db_connection = await connection();
  try {
    await db_connection.query(
      `UPDATE nurses SET Active=0 WHERE NurseID = ${req.params.id}`
    );
    res.status(200).send("Uspešno sačuvano :)");
  } catch (err) {
    await rollBackTransaction(db_connection);
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/nurses", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      "SELECT * FROM nurses where Active = 1"
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  }
});
app.put("/nurses", async (req, res) => {
  var edit = req.body;

  if (checkIfRequestEmpty(edit) || edit.length <= 0) {
    res.status(400).send("Neispravno uneti podaci");
  }
  const db_connection = await connection();
  try {
    await startTransaction(db_connection);

    await edit.forEach(async (nurse) => {
      await db_connection.query(
        `UPDATE nurses SET Name = '${nurse.Name}', Surname = '${nurse.Surname}', Experienced = ${nurse.Experienced}, Main = ${nurse.Main}, InDepartment = ${nurse.InDepartment}
         WHERE NurseID = ${nurse.NurseID}`
      );
    });

    await commitTransaction(db_connection);
    res.status(200).send("Uspešno sačuvano :)");
  } catch {
    rollBackTransaction;
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.post("/nurses", async (req, res) => {
  var nurses = req.body;

  if (checkIfRequestEmpty(nurses) || nurses.length <= 0) {
    res.status(400).send("Neispravno uneti podaci");
  }

  const db_connection = await connection();
  try {
    await startTransaction(db_connection);
    await nurses.forEach(async (nurse) => {
      await db_connection.query(
        `INSERT INTO nurses (Name, Surname, Experienced) value("${nurse.Name}", "${nurse.Surname}", ${nurse.Experienced})`
      );
    });
    await commitTransaction(db_connection);
    res.status(200).send("Uspešno sačuvano :)");
  } catch (err) {
    rollBackTransaction;
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/parameters", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query("SELECT * FROM parameters");
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.put("/parameters", async (req, res) => {
  var edit = req.body;

  if (checkIfRequestEmpty(edit) || edit.length <= 0) {
    res.status(400).send("Neispravno uneti podaci");
  }
  const db_connection = await connection();
  try {
    await edit.forEach((param) => {
      db_connection.query(
        `UPDATE parameters SET Name = '${param.Name}', Number = ${param.Number} WHERE ParameterID = '${param.ParameterID}'`
      );
    });

    await commitTransaction(db_connection);

    res.status(200).send("Uspešno sačuvano :)");
  } catch (err) {
    rollBackTransaction;
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/shifts", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query("SELECT * FROM shifts");
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.put("/shifts", async (req, res) => {
  var edit = req.body;

  if (checkIfRequestEmpty(edit) || edit.length <= 0) {
    res.status(400).send("Neispravno uneti podaci");
  }
  const db_connection = await connection();
  try {
    await startTransaction(db_connection);
    await edit.forEach((shift) => {
      db_connection.query(
        `UPDATE shifts SET StrongIntensity = ${shift.StrongIntensity} WHERE ShiftID = ${shift.ShiftID}`
      );
    });

    await commitTransaction(db_connection);

    res.status(200).send("Uspešno sačuvano :)");
  } catch (err) {
    rollBackTransaction;
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/patterns", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query("SELECT * FROM patterns");
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.put("/patterns", async (req, res) => {
  var edit = req.body;

  if (checkIfRequestEmpty(edit) || edit.length <= 0) {
    res.status(400).send("Neispravno uneti podaci");
  }
  const db_connection = await connection();
  try {
    await startTransaction(db_connection);

    await edit.forEach((pattern) => {
      db_connection.query(
        `UPDATE patterns SET Name = '${pattern.Name}', Duration = ${pattern.Duration}, Symbol = '${pattern.Symbol}' WHERE PatternID = ${pattern.PatternID}`
      );
    });

    await commitTransaction(db_connection);
    res.status(200).send("Uspešno sačuvano :)");
  } catch (err) {
    rollBackTransaction;
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/nonworkingdaytypes", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      "select * from nonworkingdaytypes where Active = 1"
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.put("/nonworkingdaytypes", async (req, res) => {
  var insert = req.body;
  if (checkIfRequestEmpty(insert)) {
    res.status(400).send("Neispravno uneti podaci");
    return;
  }
  const db_connection = await connection();
  try {
    await db_connection.query(
      "insert into nonworkingdaytypes (Name, Symbol, NumberOfHours) values (" +
        `'${insert.Name}','${insert.Symbol}',${parseFloat(
          insert.NumberOfHours
        )})`
    );
    res.send("Uspešno čuvanje");
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.post("/nonworkingdaytypes/:id", async (req, res) => {
  const db_connection = await connection();
  try {
    await db_connection.query(
      `UPDATE nonworkingdaytypes SET Active = 0 WHERE NonWorkingDayTypeID = ${req.params.id}`
    );
    res.send("Uspesno izbrisano");
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.post("/nonworkingdaytypes", async (req, res) => {
  var edit = req.body;

  if (checkIfRequestEmpty(edit) || edit.length <= 0) {
    res.status(400).send("Neispravno uneti podaci");
  }
  const db_connection = await connection();
  try {
    await startTransaction(db_connection);
    await edit.forEach((param) => {
      db_connection.query(
        `UPDATE nonworkingdaytypes SET Name = '${param.Name}', Symbol = '${param.Symbol}', NumberOfHours = ${param.NumberOfHours} WHERE NonWorkingDayTypeID = ${param.NonWorkingDayTypeID}`
      );
    });

    await commitTransaction(db_connection);
    res.status(200).send("Uspešno sačuvano :)");
  } catch (err) {
    rollBackTransaction;
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.put("/sequencerules/:id", async (req, res) => {
  const db_connection = await connection();
  try {
    await db_connection.query(
      `UPDATE sequencerules SET Active = 0 WHERE SequenceRuleID = ${req.params.id}`
    );
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/sequencerules", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      "SELECT * FROM sequencerules  where Active = 1"
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/sequencerules/:id/nurses/", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      `SELECT n.NurseID, n.Name, n.Surname from nurses_sequencerules ns JOIN nurses n on (ns.NurseID = n.NurseID) WHERE ns.SequenceRuleID = ${req.params.id}`
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.post("/sequencerules/:srid/nurses/:nid", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      `INSERT INTO nurses_sequencerules values(${req.params.srid},${req.params.nid})`
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.delete("/sequencerules/:grid/nurses/:nid", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      `DELETE from nurses_sequencerules WHERE SequenceRuleID = ${req.params.grid} AND NurseID =  ${req.params.nid}`
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.put("/groupingrules", async (req, res) => {
  var edit = req.body;

  if (checkIfRequestEmpty(edit) || edit.length <= 0) {
    res.status(400).send("Neispravno uneti podaci");
  }
  const db_connection = await connection();
  try {
    await startTransaction(db_connection);

    await edit.forEach((param) => {
      db_connection.query(
        `UPDATE groupingrules SET Name = '${param.Name}', MaxOccurences = ${param.MaxOccurences}, Duration = ${param.Duration} WHERE GroupingRuleID = ${param.GroupingRuleID}`
      );
    });

    await commitTransaction(db_connection);
    res.status(200).send("Uspešno sačuvano :)");
  } catch (err) {
    rollBackTransaction;
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.post("/groupingrules/:grid/nurses/:nid", async (req, res) => {
  const db_connection = await connection();
  try {
    await db_connection.query(
      `INSERT INTO nurses_groupingrules values(${req.params.grid},${req.params.nid})`
    );
    res.send("Uspesno dodato");
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.delete("/groupingrules/:grid/nurses/:nid", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      `DELETE from nurses_groupingrules WHERE GroupingRuleID = ${req.params.grid} AND NurseID =  ${req.params.nid}`
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/groupingrules/:id/nurses", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      `SELECT n.NurseID, n.Name, n.Surname from nurses_groupingrules ng JOIN nurses n on (ng.NurseID = n.NurseID) WHERE ng.GroupingRuleID = ${req.params.id}`
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.put("/groupingrules/:id", async (req, res) => {
  const db_connection = await connection();
  try {
    await db_connection.query(
      `UPDATE groupingrules SET Active = 0 WHERE GroupingRuleID = ${req.params.id}`
    );
    res.send("Uspešno izbrisano");
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/groupingrules", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      "SELECT * FROM groupingrules where Active = 1"
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.put("/groupingrules", async (req, res) => {
  var edit = req.body;

  if (checkIfRequestEmpty(edit) || edit.length <= 0) {
    res.status(400).send("Neispravno uneti podaci");
  }
  const db_connection = await connection();
  try {
    await startTransaction(db_connection);

    await edit.forEach((param) => {
      if (param.Duration === "") param.Duration = null;
      db_connection.query(
        `UPDATE groupingrules SET Name = '${param.Name}', Duration = ${param.Duration}, MaxOccurences = ${param.MaxOccurences} WHERE GroupingRuleID = ${param.GroupingRuleID}`
      );
    });

    await commitTransaction(db_connection);
    res.status(200).send("Uspešno sačuvano :)");
  } catch (err) {
    rollBackTransaction;
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.post("/requests/", async (req, res) => {
  var requests = req.body;

  var schid = 0;

  var NumberOfDays = new Date(
    requests.schedule.Year,
    requests.schedule.Month,
    0
  ).getDate();
  var WorkingDays = [];

  for (let i = 1; i <= NumberOfDays; i++) {
    var day = new Date(
      requests.schedule.Year,
      requests.schedule.Month - 1,
      i
    ).getDay();
    if (day > 0 && day < 6) {
      WorkingDays.push(i);
    }
  }
  const db_connection = await connection();
  try {
    await startTransaction(db_connection);

    await db_connection.query(
      `INSERT INTO schedules (GeneratedOn, Name, Month, Year, NumberOfDays, WorkingDays) VALUES` +
        `('${new Date(Date.now()).toJSON().slice(0, 10)}', '${
          requests.schedule.Name
        }', ${requests.schedule.Month}, ${
          requests.schedule.Year
        }, ${NumberOfDays}, ${WorkingDays.length})`
    );

    const [result] = await db_connection.query(
      "SELECT ScheduleID as id from schedules order by ScheduleID DESC LIMIT 1"
    );

    schid = result[0].id;

    await requests.days.forEach(
      async (request) =>
        await addNonWorkingDays(
          request,
          schid,
          res,
          requests.schedule.Month,
          db_connection
        )
    );
    await requests.shifts.forEach(
      async (request) =>
        await addNonWorkingShifts(request, schid, res, db_connection)
    );
    await requests.mustWork.forEach(
      async (request) =>
        await addMustWorkShifts(request, schid, res, db_connection)
    );
    await requests.specialNeeds.forEach(
      async (request) =>
        await addSpecialNeeds(request, schid, res, db_connection)
    );

    await addMainNursesAssignements(
      db_connection,
      schid,
      WorkingDays,
      requests.days
    );
    await commitTransaction(db_connection);

    // var p = await open(process.env.AMPL_LOC);
    res.status(200).send("Uspešno sačuvano");
  } catch (err) {
    console.log(err);
    await rollBackTransaction(db_connection);
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.get("/schedules", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      "SELECT * FROM scheduleswithgenerated"
    );
    res.json(result);
  } catch (err) {
    res.status(500).send(err);
  } // finally {// await db_connection.end();
  //}
});
app.get("/schedules/:id", async (req, res) => {
  const db_connection = await connection();
  try {
    const [result] = await db_connection.query(
      `SELECT * FROM schedules WHERE ScheduleID = ${req.params.id}`
    );
    var data = Object.values(JSON.parse(JSON.stringify(result)))[0];

    var assignedDays = await getAssignementsForSchedule(
      data.ScheduleID,
      db_connection
    );
    var nwdays = await getNWDForSchedule(data.ScheduleID, db_connection);

    data.NursesAndDays = await formatAssAndNwd(assignedDays, nwdays);

    data.NursesAndDays = data.NursesAndDays.concat(
      await getNonDepartmentNurses(db_connection)
    );
    res.json(data);
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
app.post("/schedules/:id", async (req, res) => {
  const db_connection = await connection();
  try {
    await startTransaction(db_connection);

    await db_connection.query("SET SQL_SAFE_UPDATES = 0;");
    await db_connection.query(
      "update schedules set Chosen = 0 where Month in" +
        "(select Month from " +
        `        (select Month from schedules where ScheduleID = ${req.params.id}) as m` +
        "   );"
    );
    await db_connection.query(
      `update schedules set Chosen = 1 where ScheduleID = ${req.params.id}`
    );
    await commitTransaction(db_connection);
    res.status(200).send("Uspešno sačuvano");
  } catch (err) {
    res.status(500).send(err);
  } finally {
    await db_connection.end();
  }
});
// app.post("/fill", async (req, res) => {
//   try {
//     const db_connection = await connection();
//     var schid = 96;
//     var WorkingDays = [
//       3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 17, 18, 19, 20, 21, 24, 25, 26, 27, 28,
//       31,
//     ];
//     var requests = [
//       {
//         NurseID: 1,
//         DateFrom: 5,
//         DateUntil: 6,
//         DayType: 1,
//       },
//       {
//         NurseID: 1,
//         DateFrom: 12,
//         DateUntil: 13,
//         DayType: 1,
//       },
//     ];

//     await startTransaction(db_connection);
//     await addMainNursesAssignements(
//       db_connection,
//       schid,
//       WorkingDays,
//       requests
//     );
//     await commitTransaction(db_connection);
//     res.send();
//   } catch (err) {
//     res.statusCode(500).send(err);
//   }
// });
