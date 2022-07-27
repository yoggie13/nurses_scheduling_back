const dotenv = require("dotenv")
dotenv.config();
const { query } = require("express");
const express = require("express");
var mysql = require("mysql");
var cors = require('cors');
var corsOptions = {
    origin: 'http://example.com',
    optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
}

var db_connection = require('./db_connection');

const PORT = process.env.PORT || 3001;

const app = express();

app.options("nurses/", cors());
app.use(cors())

const checkIfRequestEmpty = (req) => {
    return req === undefined
        || req === null
        || Object.keys(req).length === 0
        || Object.getPrototypeOf(req) === Object.prototype
}
const beginTransaction = () => {
    db_connection.query("START TRANSACTION", (err) => {
        if (err) throw err;
    });
}
const commitTransaction = () => {
    db_connection.query("COMMIT", (err) => {
        if (err) throw err;
    });
}
const rollBackTransaction = () => {
    db_connection.query("ROLLBACK TRANSACTION", (err) => {
        if (err) throw err;
    });
}
const addNonWorkingDays = (request, schid) => {
    db_connection.query(`INSERT INTO nonworkingdays values(${schid},${request.NurseID},'${request.Date_From.slice(0, 10)}','${request.Date_Until.slice(0, 10)}',${request.Day_Type},${request.IsMandatory})`,
        (err) => {
            if (err) {
                rollBackTransaction;
                res.status(500).send("Greška pri čuvanju izmena u bazi");
            }
        });
}
const addNonWorkingShifts = (request, schid) => {
    request.Shifts.forEach((shift, index) => {
        if (shift) {
            db_connection.query(`INSERT INTO nonworkingshifts values(${schid},${request.NurseID},'${request.Date_From.slice(0, 10)}','${request.Date_Until.slice(0, 10)}',${index + 1},${request.IsMandatory})`,
                (err) => {
                    if (err) {
                        rollBackTransaction;
                        res.status(500).send("Greška pri čuvanju izmena u bazi");
                    }
                });
        }
    })

}

app.use(
    express.urlencoded({
        extended: true,
    })
);

app.use(express.json());

app.listen(PORT, () => {
    console.log(`Server listening on ${PORT}`);
});

app.get('/nursesForSelect', (req, res) => {
    db_connection.query("SELECT * FROM nurses", (err, result, fields) => {
        if (err) {
            res.status(400).send("Greška pri čitanju podataka iz baze");
        }
        var ret = [];
        result.forEach((nurse) => {
            ret.push({
                id: nurse.NurseID,
                label: `${nurse.Name} ${nurse.Surname}`
            })
        })
        res.json(ret);
    });
})
app.get('/daysForSelect', (req, res) => {
    db_connection.query("SELECT * FROM nonworkingdaytypes", (err, result, fields) => {
        if (err) {
            res.status(400).send("Greška pri učitavanju podataka iz baze")
        }
        var ret = [];
        result.forEach((day) => {
            ret.push({
                id: day.NonWorkingDayTypeID,
                label: day.Name
            })
        })
        res.json(ret)
    })
})
app.put('/nurses/delete', (req, res) => {
    var nurses = req.body;

    if (checkIfRequestEmpty(nurses) || nurses.length <= 0) {
        res.status(400).send("Neispravno uneti podaci");
    }

    beginTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };
    nurses.forEach((nurse) => {
        db_connection.query(`DELETE FROM nurses WHERE NurseID = ${nurse}`, (err) => {
            if (err) {
                rollBackTransaction;
                res.status(500).send("Greška pri unosu podataka u bazu");
            }
        });
    })
    commitTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };
    res.status(200).send("Uspešno sačuvano :)")
})
app.get('/nurses', (req, res) => {
    db_connection.query("SELECT * FROM nurses", (err, result, fields) => {
        if (err) {
            res.status(500).send("Greška pri čitanju iz baze");
        }
        res.json(result)
    })
})
app.put('/nurses', (req, res) => {
    var edit = req.body;

    if (checkIfRequestEmpty(edit) || edit.length <= 0) {
        res.status(400).send("Neispravno uneti podaci");
    }

    beginTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };

    edit.forEach((nurse) => {
        db_connection.query(`UPDATE nurses SET Name = '${nurse.Name}', Surname = '${nurse.Surname}', Experienced = ${nurse.Experienced} WHERE NurseID = ${nurse.NurseID}`,
            (err) => {
                if (err) {
                    rollBackTransaction;
                    res.status(500).send("Greška pri čuvanju izmena u bazi");
                }
            });
    });

    commitTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri čuvanju izmena u bazi");
    };

    res.status(200).send("Uspešno sačuvano :)");
})
app.post('/nurses', (req, res) => {
    var nurses = req.body;

    if (checkIfRequestEmpty(nurses) || nurses.length <= 0) {
        res.status(400).send("Neispravno uneti podaci");
    }

    beginTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };
    nurses.forEach((nurse) => {
        db_connection.query(`INSERT INTO nurses (name, surname, experienced) value("${nurse.Name}", "${nurse.Surname}", ${nurse.Experienced})`,
            (err) => {
                if (err) {
                    rollBackTransaction;
                    res.status(500).send("Greška pri unosu podataka u bazu");
                }
            });
    })
    commitTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };
    res.status(200).send("Uspešno sačuvano :)")
})
app.get('/parameters', (req, res) => {
    db_connection.query("SELECT * FROM parameters", (err, result, fields) => {
        if (err) {
            res.status(500).send("Greška pri čitanju iz baze");
        }
        res.json(result);
    });
})
app.put('/parameters', (req, res) => {
    var edit = req.body;

    if (checkIfRequestEmpty(edit) || edit.length <= 0) {
        res.status(400).send("Neispravno uneti podaci");
    }

    beginTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };

    edit.forEach((param) => {
        db_connection.query(`UPDATE parameters SET Name = '${param.Name}', Number = ${param.Number} WHERE ParameterID = ${param.ParameterID}`,
            (err) => {
                if (err) {
                    rollBackTransaction;
                    res.status(500).send("Greška pri čuvanju izmena u bazi");
                }
            });
    });

    commitTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri čuvanju izmena u bazi");
    };

    res.status(200).send("Uspešno sačuvano :)");
})
app.get('/shifts', (req, res) => {
    db_connection.query("SELECT * FROM shifts", (err, result, fields) => {
        if (err) {
            res.status(500).send("Greška pri čitanju iz baze");
        }
        res.json(result);
    });
})
app.put('/shifts', (req, res) => {
    var edit = req.body;

    if (checkIfRequestEmpty(edit) || edit.length <= 0) {
        res.status(400).send("Neispravno uneti podaci");
    }

    beginTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };

    edit.forEach((shift) => {
        db_connection.query(`UPDATE shifts SET Name = '${shift.Name}', Duration = ${shift.Duration}, StrongIntensity = ${shift.StrongIntensity}, Symbol = '${shift.Symbol}' WHERE ShiftID = ${shift.ShiftID}`,
            (err) => {
                if (err) {
                    console.log(err);
                    rollBackTransaction;
                    res.status(500).send("Greška pri čuvanju izmena u bazi");
                }
            });
    });

    commitTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri čuvanju izmena u bazi");
    };

    res.status(200).send("Uspešno sačuvano :)");
})
app.delete('/sequencerules/:id', (req, res) => {
    db_connection.query(`DELETE FROM sequencerules WHERE SequenceRuleID = ${req.params.id}`, (err, result, fields) => {
        if (err) {
            res.status(500).send("Greška pri brisanju")
            return;
        }
        else {
            res.send("Uspešno izbrisano");
        }
    })
})
app.get('/sequencerules', (req, res) => {
    db_connection.query("SELECT * FROM sequencerules", (err, result, fields) => {
        if (err) {
            res.status(500).send("Greška pri čitanju podatak iz baze")
            return;
        }
        else {
            res.json(result);
        }
        // else {
        //     var ret = [];
        //     result.forEach((item) => {
        //         for (let i = 0; i < ret.length; i++) {
        //             var added = false;
        //             if (item.SequenceRuleID === ret[i].SequenceRuleID) {
        //                 ret[i].Members.push({
        //                     SequenceRuleMemberID: item.SequenceRuleMemberID,
        //                     ShiftID: item.ShiftID
        //                 })
        //                 added = true;
        //                 break;
        //             }
        //         }
        //         if (!added) {
        //             ret.push({
        //                 SequenceRuleID: item.SequenceRuleID,
        //                 Name: item.Name,
        //                 Members: [{
        //                     SequenceRuleMemberID: item.SequenceRuleMemberID,
        //                     ShiftID: item.ShiftID
        //                 }]
        //             });
        //         }
        //     })
        //     res.json(ret);
        // }
    })
})
app.put('/groupingrules', (req, res) => {
    var edit = req.body;

    if (checkIfRequestEmpty(edit) || edit.length <= 0) {
        res.status(400).send("Neispravno uneti podaci");
    }

    beginTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };

    edit.forEach((param) => {
        db_connection.query(`UPDATE sequencerules SET Name = '${param.Name}' WHERE SequenceRuleID = ${param.SequenceRuleID}`,
            (err) => {
                if (err) {
                    rollBackTransaction;
                    res.status(500).send("Greška pri čuvanju izmena u bazi");
                }
            });
    });

    commitTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri čuvanju izmena u bazi");
    };

    res.status(200).send("Uspešno sačuvano :)");
})
app.post('/groupingrules/:grid/nurses/:nid', (req, res) => {
    db_connection.query(`INSERT INTO nurses_groupingrules values(${req.params.grid},${req.params.nid})`, (err, result, fields) => {
        if (err) {
            res.status(500).send("Greška pri čitanju podataka iz baze")
            return;
        }
        else {
            res.json(result);
        }
    })
})
app.delete('/groupingrules/:grid/nurses/:nid', (req, res) => {
    db_connection.query(`DELETE from nurses_groupingrules WHERE GroupingRuleID = ${req.params.grid} AND NurseID =  ${req.params.nid}`, (err, result, fields) => {
        if (err) {
            res.status(500).send("Greška pri čitanju podataka iz baze")
            return;
        }
        else {
            res.json(result);
        }
    })
})
app.get('/groupingrules/:id/nurses', (req, res) => {
    db_connection.query(`SELECT n.NurseID, n.Name, n.Surname from nurses_groupingrules ng JOIN nurses n on (ng.NurseID = n.NurseID) WHERE ng.GroupingRuleID = ${req.params.id}`, (err, result, fields) => {
        if (err) {
            res.status(500).send("Greška pri čitanju podataka iz baze")
            return;
        }
        else {
            res.json(result);
        }
    })
})
app.delete('/groupingrules/:id', (req, res) => {
    db_connection.query(`DELETE FROM groupingrules WHERE GroupingRuleID = ${req.params.id}`, (err, result, fields) => {
        if (err) {
            res.status(500).send("Greška pri brisanju")
            return;
        }
        else {
            res.send("Uspešno izbrisano");
        }
    })
})
app.get('/groupingrules', (req, res) => {
    db_connection.query("SELECT * FROM groupingrules",
        (err, result, fields) => {
            if (err) {
                res.status(500).send("Greška pri čitanju podatak iz baze")
                return;
            }
            else {
                res.json(result);
            }
        })
})
app.put('/groupingrules', (req, res) => {
    var edit = req.body;

    if (checkIfRequestEmpty(edit) || edit.length <= 0) {
        res.status(400).send("Neispravno uneti podaci");
    }

    beginTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };

    edit.forEach((param) => {
        if (param.Duration === "")
            param.Duration = null
        db_connection.query(`UPDATE groupingrules SET Name = '${param.Name}', Duration = ${param.Duration}, Max = ${param.Max} WHERE GroupingRuleID = ${param.GroupingRuleID}`,
            (err) => {
                if (err) {
                    rollBackTransaction;
                    res.status(500).send("Greška pri čuvanju izmena u bazi");
                }
            });
    });

    commitTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri čuvanju izmena u bazi");
    };

    res.status(200).send("Uspešno sačuvano :)");
})

app.post('/requests/:name', async (req, res) => {
    var requests = req.body;

    beginTransaction(), (err) => {
        if (err)
            res.status(500).send("Greška pri unosu podataka u bazu");
    };

    var schid = 0;

    db_connection.query(`INSERT INTO schedules (GeneratedOn, Name) VALUES ('${new Date(Date.now()).toJSON().slice(0, 10)}', '${req.params.name}')`,
        (err) => {
            if (err) {
                rollBackTransaction();
                res.status(500).send("Greška pri unosu podataka u bazu");
            }
            else {
                db_connection.query("SELECT last_insert_id() AS id",
                    (err, result, fields) => {
                        if (err) {
                            rollBackTransaction();
                            res.status(500).send("Greška pri unosu podataka u bazu");
                        }
                        else {
                            schid = result[0].id;
                            console.log(schid);

                            requests.forEach((request) => {
                                if (request.Shifts === "all")
                                    addNonWorkingDays(request, schid);
                                else
                                    addNonWorkingShifts(request, schid);
                            });

                            commitTransaction(), (err) => {
                                if (err)
                                    res.status(500).send("Greška pri unosu podataka u bazu");
                            };
                            res.status(200).send("Uspešno sačuvano");
                        }
                    });
            }
        })

});
