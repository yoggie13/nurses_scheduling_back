set N; #sestre

table nurses IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'SELECT NurseID FROM nurses WHERE Active = 1 AND Main = 0 AND InDepartment = 1':
	N <- [NurseID];

set NE, within N; #iskusne sestre

table experienced_nurses IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'SELECT NurseID FROM nurses WHERE Experienced = 1 AND Active = 1 AND Main = 0 AND InDepartment = 1':
	NE <- [NurseID];

set SCH;
param SCHID{SCH}; #id
param dpm{SCH}, integer, >0; # broj dana u mesecu
param wdpm{SCH}, integer, >0;  # broj radnih dana u mesecu
param month{SCH}, integer, >0; #mesec
param year{SCH}, integer, > 0;

table days IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	('SELECT ROW_NUMBER() OVER (ORDER BY ScheduleID DESC)'
	& ' row_num, ScheduleID, NumberOfDays, WorkingDays, Month, Year FROM schedules'
	& ' LIMIT 1;'):
	SCH <- [row_num], SCHID ~ ScheduleID, dpm ~ NumberOfDays, wdpm ~ WorkingDays, month ~ Month, year ~ Year;

# termini
set D := 1..dpm[1];                # skup dana u mesecu
set SH;                         # skup smena u danu

table shifts IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'SELECT ShiftID FROM shifts':
	SH <- [ShiftID];

set SSH, within SH;             # smene jakog intenziteta

table strong_shifts IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'SELECT ShiftID FROM shifts WHERE StrongIntensity = 1':
	SSH <- [ShiftID];

set WSH, within SH;             # smene slabog intenziteta

table weak_shifts IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'SELECT ShiftID FROM shifts WHERE StrongIntensity = 0':
	WSH <- [ShiftID];

set T := {D, SH};               # skup mesecnih termina

#paterni
set PAT;                        # skup paterna
set PAT_tuples within {PAT, SH, 0..1}; #pomocna
param patlen := card(SH);       # duzina paterna, tj. broj smena u danu
param pattern{p in PAT, j in 1..patlen} := sum{(p,j,k) in PAT_tuples} k; # paterni PROVERITI
param tsh{PAT} default 0;                # trajanje smene

table patterns IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'SELECT PatternID, Duration FROM patterns':
	PAT <- [PatternID], tsh ~ Duration;

table patterns_tuples IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'SELECT PatternID, ShiftID, Includes FROM pattern_shift':
	PAT_tuples <- [PatternID, ShiftID, Includes];

# PRAVILA:
# pravila sekvenci
set RS;	# skup pravila nedozvoljenih sekvenci
param ts{RS};                   # interval sekvence

table sequence_rules IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	('SELECT srm.SequenceRuleID, count(1) as ts FROM sequencerules sr '
	& 'JOIN sequencerulesmembers srm on (sr.SequenceRuleID = srm.SequenceRuleMemberID) '
	& 'WHERE Active = 1 ' 
	& 'group by srm.SequenceRuleID'):
	RS <- [SequenceRuleID], ts;

set NS_tuples within {RS, N}; #pomocna

table nurses_sr IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	('SELECT ns.SequenceRuleID, ns.NurseID FROM nurses_sequencerules ns'
	& ' JOIN nurses n ON (ns.NurseID = n.NurseID)'
	& ' JOIN sequencerules s ON (ns.SequenceRuleID = s.SequenceRuleID)'
	& ' WHERE n.Active = 1 AND n.Main = 0 AND n.InDepartment = 1 AND s.Active = 1'):
	NS_tuples <- [SequenceRuleID, NurseID];

set NS{i in RS} := {j in N : (i,j) in NS_tuples}; #pravilo sekvenci za koje sestre va�i
set prs_tuples within {RS, D, PAT}; #pomocna            

table sequence_rule_members IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	('SELECT srm.SequenceRuleID as SRID, srm.SequenceRuleMemberID as SRMID, srm.PatternID as PID'
	& ' FROM sequencerules sr'
	& ' JOIN sequencerulesmembers srm on (sr.SequenceRuleID = srm.SequenceRuleMemberID)'
	& ' order by srm.SequenceRuleID, srm.SequenceRuleMemberID'):
	prs_tuples <- [SRID, SRMID, PID];
	
param prs{r in RS, j in 1..ts[r]} := sum{(r,j,k) in prs_tuples} k;   # patern za svaki dan sekvence #PROVERITI

#pravila grupisanja
set RG;
param prg{RG};
param tg{RG} default dpm[1];
param nug{RG};

table groupingrules IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'SELECT * FROM groupingrules WHERE Active = 1':
	RG <- [GroupingRuleID], prg ~ PatternID, tg ~ Duration, nug ~ MaxOccurences;

set NR_tuples within {RG,N}; #pomocna 

table groupingrulesnurses IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	('SELECT ng.GroupingRuleID, ng.NurseID FROM nurses_groupingrules ng'
	& ' JOIN nurses n ON (ng.NurseID = n.NurseID)'
	& ' JOIN groupingrules g ON (ng.GroupingRuleID = g.GroupingRuleID)'
	& ' WHERE n.Active = 1 AND n.Main = 0 AND n.InDepartment = 1 AND g.Active = 1'):
	NR_tuples <- [GroupingRuleID, NurseID];


set NR{i in RG} := {j in N : (i,j) in NR_tuples};
var maxDurRG = max {i in RG : tg[i] != dpm[1]} tg[i];
var maxDurRS = max {i in RS} ts[i];

# termini / sestre
set DN; #pomocna
param NWD_duration{DN}; #sati trajanja neradnih dana

table dntable IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	'SELECT NonWorkingDayTypeID, NumberOfHours FROM nonworkingdaytypes WHERE Active = 1':
	DN <- [NonWorkingDayTypeID], NWD_duration ~ NumberOfHours;
	
set DN_Durations := setof{dn in DN} NWD_duration[dn];

set VD_tuples within {N, D, D, DN_Durations}; #pomocna 

table nurse_vac IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'SELECT * FROM nurses_nwd':
	VD_tuples <- [NurseID, DateFrom, DateUntil, NumberOfHours];

set VD_tuples_pos within {N, D, D, {setof{dn in DN} NWD_duration[dn]}}; #pomocna 

table nurse_vac_pos IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	'SELECT * FROM nurses_nwd_pos':
	VD_tuples_pos <- [NurseID, DateFrom, DateUntil, NumberOfHours];

set VD{i in N}, within D := setof{(i,j,k,w) in VD_tuples, l in {j..k}} l; # podskup dana u kojima je sestra n na god. odmoru, tj.
set VD_pos{i in N}, within D := setof{(i,j,k,w) in VD_tuples_pos, l in {j..k}} l;               # podskup dana u kojima je sestra n na god. odmoru, tj.
set WD{n in N} := D diff VD[n];                     # podskup dana u kojima sestra n nije na odmoru (tj. raspoloziva je za posao)
set NA{d in D} := setof{n in N : d not in VD[n]} n; # podskup MS raspolozivih za dan d (nisu na god. odmoru)
param PH{i in N} := sum{(i,j,k,w) in VD_tuples} w*(k-j+1); #placeni sati odmora i placenih slobodnih dana
param PH_pos{N,D} default 0; #placeni sati slobodnih dana ukoliko budu odobreni
#param PH_pos{i in N, l in setof{(i,j,k,w) in VD_tuples_pos, y in {j..k} y}} := w;
#param PH_pos{i in N, l in  := w
forall{(i,j,k,w) in VD_tuples_pos, l in j..k}:
	PH_pos[i, l] = w;

set TF_tuples within {N,D,D,SH}; #pomocna 

table nurse_shift_must IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	('SELECT nws.NurseID, nws.DateFrom,  nws.DateUntil, nws.ShiftID FROM nonworkingshifts nws'
	& ' JOIN nurses n ON (nws.NurseID = n.NurseID)'
	& ' WHERE nws.ScheduleID=' & SCHID[1]
	& ' AND n.Active = 1 AND n.InDepartment = 1 AND n.Main = 0'
	& ' AND nws.Must=1'):	
	TF_tuples <- [NurseID, DateFrom,DateUntil,ShiftID];

set TP_tuples within {N,D,D,SH}; #pomocna 

table nurse_shift_would IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	('SELECT nws.NurseID, nws.DateFrom,  nws.DateUntil, nws.ShiftID FROM nonworkingshifts nws'
	& ' JOIN nurses n ON (nws.NurseID = n.NurseID)'
	& ' WHERE nws.ScheduleID=' & SCHID[1]
	& ' AND n.Active = 1 AND n.InDepartment = 1 AND n.Main = 0'
	& ' AND nws.Must=0;'):
	TP_tuples <- [NurseID, DateFrom, DateUntil, ShiftID];

set TW_tuples within {N,D,D,SH};

table nurse_must_work IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	('SELECT mws.NurseID, mws.DateFrom, mws.DateUntil, mws.ShiftID FROM mustworkshifts mws'
	& ' JOIN nurses n on (mws.NurseID = n.NurseID)'
	& ' WHERE mws.ScheduleID=' & SCHID[1]
	& ' AND n.Active = 1 AND n.Main = 0 AND n.InDepartment = 1'):
	TW_tuples <- [NurseID, DateFrom, DateUntil, ShiftID];

set TF{i in N}, within T := setof{(i,j,k,l) in TF_tuples, p in {j..k}} (p,l); # podskup termina u kojima sestra n ne sme da radi
set TW{i in N}, within T := setof{(i,j,k,l) in TW_tuples, p in {j..k}} (p,l);   # podskup termina u kojima sestra n mora da radi
set TP{i in N}, within T := setof{(i,j,k,l) in TP_tuples, p in {j..k}} (p,l);   # podskup termina u kojima sestra n preferira da ne radi neku smenu

set PSCHA within {N,{-29..0},PAT};

table prev_sched IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	('SELECT * FROM prev_sched_days ORDER BY Days'):
	PSCHA <- [NurseID, Days, PatternID];

set NEGD := setof{(i,j,k) in PSCHA} j; #negativni dani iz prethodnog rasporeda
#parameters

set PAR; #pomocna
param nu{PAR};  #pomocna

table parameters IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	'SELECT ParameterID, Number FROM parameters':
	PAR <- [ParameterID], nu ~ Number;

param ne := nu['ne'], integer, >=0 ;         # min broj iskusnih MS koji mora biti prisutan u svakoj smeni
param ns := nu['ns'], integer, >=0;         # min broj MS koji mora biti prisutan u terminima jakog intenziteta
param nsi := nu['nsi'], integer, >=0;        # idealan broj MS u terminima jakog intenziteta
param nw := nu['nw'], integer, >=0;         # min broj MS koji mora biti prisutan u terminima slabog inteziteta
param nwi := nu['nwi'], integer, >=0;        # idealan broj MS u terminima slabog inteziteta
param wdir := nu['wdir'], integer, >=0;      #maksimalni broj radnih dana zaredom

set nis_tuples within {D, SH, 0..card(N)}; #pomocna

table special_needs_shifts IN 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;' 
	('SELECT Day, ShiftID, NumberOfNurses FROM specialneedsshifts'
	& ' WHERE ScheduleID=' & SCHID[1]):
	nis_tuples <- [Day, ShiftID, NumberOfNurses];

param nis{d in D,s in SH} := if sum{(d,s,k) in nis_tuples} k = 0 then if s in SSH then nsi else nwi else sum{(d,s,k) in nis_tuples} k;   # idealan broj MS u danima/smenama sa posebnim potrebama
param wtwd := nu['wtwd'], integer, >0;        # obracunsko radno vreme

param M1 := nu['M1'], integer, >=0;         # tezina odstupanja od kriterijuma 1. prioriteta
param M2 := nu['M2'], integer, >=0;         # tezina odstupanja od kriterijuma 2. prioriteta
param M3 := nu['M3'], integer, >=0;         # tezina odstupanja od kriterijuma 3. prioriteta
param M4 := nu['M4'], integer, >=0;         # tezina odstupanja od kriterijuma 4. prioriteta
param M5 := nu['M5'], integer, >= 0;		# tezina odstupanja od kriterijuma 5. prioriteta
param t{n in N} := wdpm[1] * wtwd * card(WD[n]) / dpm[1] - PH[n]; #norma u h

set Sequence_Constraint_Set {r in RS, n in NS[r]}:= NEGD union {1..dpm[1]-ts[r]+1 diff VD[n]} diff setof{(i,j) in TW[n]} i;
set Grouping_Constraint_Set {r in RG, n in NR[r]} := NEGD union {1..dpm[1]-tg[r]+1} diff setof{(i,j) in TW[n]} i;
set Max_Working_Set {n in N} := setof{(i,j) in TW[n]} i;
set Max_Working_Set_Upgraded {n in N} := setof{i in Max_Working_Set[n] : forall{wd in i..i+wdir} wd in Max_Working_Set[n]} i+wdir;
 
var x{n in N, d in NEGD union D, p in PAT}, binary, >= if (n,d,p) in PSCHA then 1 else 0; # da li sestra n dana d radi po paternu p
var dsL{D,SSH}, >=0;            # podbacaj broja MS u smenama jakog intenziteta
var dsT{D,SSH}, >=0;            # prebacaj broja MS u smenama jakog intenziteta
var dwL{D,WSH}, >=0;            # podbacaj broja MS u smenama slabog intenziteta
var dwT{D,WSH}, >=0;            # prebacaj broja MS u smenama slabog intenziteta
var shT{N}, >=0;                # podbacaj za preferirane izostanke smena
var daT{N}, >=0;				# podbacaj za preferirane izostanke dana
var tnL{N}, >=0;                # podbacaj norme u h
var tnT{N}, >=0;                # prebacaj norme u h
var tn, >=0;                    # maksimum svih odstupanja od radne norme

minimize f: M1 * sum{d in D, s in SSH} (dsL[d,s] + dsT[d,s]) +      # idealan broj MS u smenama jakog intenziteta
            M2 * sum{d in D, s in WSH} (dwL[d,s] + dwT[d,s]) +      # idealan broj MS u smenama slabog intenziteta
            M3 * sum {n in N} daT[n] +								# zadovoljenje trazenih dana  
            M4 * sum{n in N} shT[n] +                              # zadovoljenje trazenih smena
            M5 * tn;												#obracunsko radno vreme

s.t.
	#previous_sched {(n,d,p) in PSCHA} : x[n,d,p] = 1;
	vacation{n in N, d in VD[n] : card(VD[n]) > 0}: x[n,d,0] = 1;
    nowork{n in N : card(TF[n]) > 0}: sum{(d,s) in TF[n], p in PAT : pattern[p,s]} x[n,d,p] = 0;
    pattern_dan{n in N, d in D}: sum{p in PAT} x[n,d,p] = 1;
    sequence_r{r in RS, n in NS[r], d in Sequence_Constraint_Set[r,n]}: sum{k in 1..ts[r]} x[n,d+k-1,prs[r,k]] <= ts[r] - 1;
    grouping_r{r in RG, n in NR[r], d in Grouping_Constraint_Set[r,n]}: sum{k in d..d+tg[r]-1} x[n,k,prg[r]] <= nug[r];
    shift_exp{d in D, s in SH}:  sum{n in (NE inter NA[d]), p in PAT : pattern[p,s]} x[n,d,p] >= ne;
    strong_min{d in D, s in SSH}: sum{n in NA[d],  p in PAT : pattern[p,s]} x[n,d,p] >= ns;
    strong_idl{d in D, s in SSH}: sum{n in NA[d],  p in PAT : pattern[p,s]} x[n,d,p] - dsT[d,s] + dsL[d,s] = nis[d,s];
    weaksh_min{d in D, s in WSH}: sum{n in NA[d],  p in PAT : pattern[p,s]} x[n,d,p] >= nw;
    weaksh_idl{d in D, s in WSH}: sum{n in NA[d],  p in PAT : pattern[p,s]} x[n,d,p] - dwT[d,s] + dwL[d,s] = nis[d,s];
    yeswork{n in N : card(TW[n]) > 0}: sum{(d,s) in TW[n], p in PAT : pattern[p,s]} x[n,d,p] = 1;
    pref_aps_shifts{n in N : card(TP[n]) > 0}: sum {(d,s) in TP[n], p in PAT : pattern[p,s]} x[n,d,p] - shT[n] = 0;
    pref_aps_days{n in N, s in SH : card(VD_pos[n]) > 0}: sum {d in VD_pos[n], p in PAT : pattern[p,s]} x[n,d,p] - daT[n] = 0;
    max_days_in_a_row{n in N, d in D diff Max_Working_Set_Upgraded[n] diff VD[n]}: sum {wd in d-wdir..d, p in PAT diff {0}} x[n,wd,p] <= wdir;
    time_norm{n in N}: sum{d in WD[n], p in PAT} (tsh[p] * x[n,d,p] - tnT[n] + tnL[n] + PH_pos[n,d]*(1 - if p == 0 then 0 else x[n,d,p])) = t[n];
    time_devL{n in N}: tn >= tnL[n];
    time_devT{n in N}: tn >= tnT[n];
	
solve;

table assignements {s in SCH, n in N, d in D, p in PAT diff{0} : x[n,d,p] = 1} OUT 'ODBC' 'DSN=gmpl_odbc;SERVER=localhost;PORT=3306;DATABASE=nurses_scheduling;UID=root;PWD=mmjesuper.13;'
	'assignements':
	 SCHID[s] ~ ScheduleID, n ~ NurseID, d ~ Day, p ~ PatternID;

end;
