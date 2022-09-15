set N; #sestre
set NE, within N; #iskusne sestre

set SCH ordered;
param dpm{SCH}; # broj dana u mesecu
param wdpm{SCH}, integer, >0;  # broj radnih dana u mesecu
param month{SCH}, integer, >0; #mesec
param year{SCH}, integer, > 0;

# termini
set D := 1..dpm[member(1,SCH)];                # skup dana u mesecu
set SH;                         # skup smena u danu
set SSH, within SH;             # smene jakog intenziteta
set WSH, within SH;             # smene slabog intenziteta
set T := {D, SH};               # skup mesecnih termina

#paterni
set PAT;                        # skup paterna
set PAT_tuples within {PAT, SH, 0..1}; #pomocna
param patlen := card(SH);       # duzina paterna, tj. broj smena u danu
param pattern{p in PAT, j in 1..patlen} := sum{(p,j,k) in PAT_tuples} k; # paterni PROVERITI
param tsh{PAT} default 0;                # trajanje smene

# PRAVILA:
# pravila sekvenci
set RS;	# skup pravila nedozvoljenih sekvenci
set NS_tuples within {RS, N}; #pomocna
set NS{i in RS} := {j in N : (i,j) in NS_tuples}; #pravilo sekvenci za koje sestre važi
param ts{RS};                   # interval sekvence
set prs_tuples within {RS, D, PAT}; #pomocna               
param prs{r in RS, j in 1..ts[r]} := sum{(r,j,k) in prs_tuples} k;   # patern za svaki dan sekvence #PROVERITI

#pravila grupisanja
set RG;
set NR_tuples within {RG,N}; #pomocna 
set NR{i in RG} := {j in N : (i,j) in NR_tuples};
param prg{RG};
param tg{RG} default dpm[member(1,SCH)];
param nug{RG};

var maxDurRG := max {i in RG : tg[i] != dpm[member(1,SCH)]} tg[i];
var maxDurRS := max {i in RS} ts[i];

# termini / sestre
set DN; #pomocna
set VD_tuples within {N, D, D, DN}; #pomocna 
set VD_tuples_pos within {N, D, D, DN}; #pomocna 
set VD{i in N}, within D := setof{(i,j,k,w) in VD_tuples, l in {j..k}} l; # podskup dana u kojima je sestra n na god. odmoru, tj.
set VD_pos{i in N}, within D := setof{(i,j,k,w) in VD_tuples_pos, l in {j..k}} l;               # podskup dana u kojima je sestra n na god. odmoru, tj.
set WD{n in N} := D diff VD[n];                     # podskup dana u kojima sestra n nije na odmoru (tj. raspoloziva je za posao)
set NA{d in D} := setof{n in N : d not in VD[n]} n; # podskup MS raspolozivih za dan d (nisu na god. odmoru)
param PH{i in N} := sum{(i,j,k,w) in VD_tuples} w*(k-j+1); #placeni sati odmora i placenih slobodnih dana
param PH_pos{N,D} default 0; #placeni sati slobodnih dana ukoliko budu odobreni
#param PH_pos{i in N, l in setof{(i,j,k,w) in VD_tuples_pos, y in {j..k} y}} := w;

set TF_tuples within {N,D,D,SH}; #pomocna 
set TP_tuples within {N,D,D,SH}; #pomocna 
set TW_tuples within {N,D,D,SH};
set TF{i in N}, within T := setof{(i,j,k,l) in TF_tuples, p in {j..k}} (p,l); # podskup termina u kojima sestra n ne sme da radi
set TW{i in N}, within T := setof{(i,j,k,l) in TW_tuples, p in {j..k}} (p,l);   # podskup termina u kojima sestra n mora da radi
set TP{i in N}, within T := setof{(i,j,k,l) in TP_tuples, p in {j..k}} (p,l);   # podskup termina u kojima sestra n preferira da ne radi neku smenu

set PSCHA within {N,{-29..0},PAT};
set NEGD := setof{(i,j,k) in PSCHA} j; #negativni dani iz prethodnog rasporeda
#parameters
set PAR; #pomocna
param nu{PAR};  #pomocna
param ne := nu['ne'], integer, >=0 ;         # min broj iskusnih MS koji mora biti prisutan u svakoj smeni
param ns := nu['ns'], integer, >=0;         # min broj MS koji mora biti prisutan u terminima jakog intenziteta
param nsi := nu['nsi'], integer, >=0;        # idealan broj MS u terminima jakog intenziteta
param nw := nu['nw'], integer, >=0;         # min broj MS koji mora biti prisutan u terminima slabog inteziteta
param nwi := nu['nwi'], integer, >=0;        # idealan broj MS u terminima slabog inteziteta
set nis_tuples within {D, SH, 0..card{N}}; #pomocna
param nis{d in D,s in SH} := if sum{(d,s,k) in nis_tuples} k = 0 then if s in SSH then nsi else nwi else sum{(d,s,k) in nis_tuples} k;   # idealan broj MS u danima/smenama sa posebnim potrebama
param wtwd := nu['wtwd'], integer, >0;        # obracunsko radno vreme

param M1 := nu['M1'], integer, >=0;         # tezina odstupanja od kriterijuma 1. prioriteta
param M2 := nu['M2'], integer, >=0;         # tezina odstupanja od kriterijuma 2. prioriteta
param M3 := nu['M3'], integer, >=0;         # tezina odstupanja od kriterijuma 3. prioriteta
param M4 := nu['M4'], integer, >=0;         # tezina odstupanja od kriterijuma 4. prioriteta
param M5 := nu['M5'], integer, >= 0;		# tezina odstupanja od kriterijuma 5. prioriteta
param t{n in N} := wdpm[member(1,SCH)] * wtwd * card(WD[n]) / dpm[member(1,SCH)] - PH[n]; #norma u h
set ASSIGN{SCH,N,D}; #posle za ispis
param pat_assign{s in SCH, n in N, d in D};#posle za ispis

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
    sequence_r{r in RS, n in NS[r], d in {NEGD union {1..dpm[member(1,SCH)]-ts[r]+1 diff VD[n]} diff setof{(i,j) in TW[n]} i}}: sum{k in 1..ts[r]} x[n,d+k-1,prs[r,k]] <= ts[r] - 1;
    grouping_r{r in RG, n in NR[r], d in {NEGD union {1..dpm[member(1,SCH)]-tg[r]+1} diff setof{(i,j) in TW[n]} i}}: sum{k in d..d+tg[r]-1} x[n,k,prg[r]] <= nug[r];
    shift_exp{d in D, s in SH}:  sum{n in (NE inter NA[d]), p in PAT : pattern[p,s]} x[n,d,p] >= ne;
    strong_min{d in D, s in SSH}: sum{n in NA[d],  p in PAT : pattern[p,s]} x[n,d,p] >= ns;
    strong_idl{d in D, s in SSH}: sum{n in NA[d],  p in PAT : pattern[p,s]} x[n,d,p] - dsT[d,s] + dsL[d,s] = nis[d,s];
    weaksh_min{d in D, s in WSH}: sum{n in NA[d],  p in PAT : pattern[p,s]} x[n,d,p] >= nw;
    weaksh_idl{d in D, s in WSH}: sum{n in NA[d],  p in PAT : pattern[p,s]} x[n,d,p] - dwT[d,s] + dwL[d,s] = nis[d,s];
    yeswork{n in N : card(TW[n]) > 0}: sum{(d,s) in TW[n], p in PAT : pattern[p,s]} x[n,d,p] = 1;
    pref_aps_shifts{n in N : card(TP[n]) > 0}: sum {(d,s) in TP[n], p in PAT : pattern[p,s]} x[n,d,p] - shT[n] = 0;
    pref_aps_days{n in N, s in SH : card(VD_pos[n]) > 0}: sum {d in VD_pos[n], p in PAT : pattern[p,s]} x[n,d,p] - daT[n] = 0;
	time_norm{n in N}: sum{d in WD[n], p in PAT} (tsh[p] * x[n,d,p] - tnT[n] + tnL[n] + PH_pos[n,d]*(1 - if p == 0 then 0 else x[n,d,p])) = t[n];
    time_devL{n in N}: tn >= tnL[n];
    time_devT{n in N}: tn >= tnT[n];

end;
 
