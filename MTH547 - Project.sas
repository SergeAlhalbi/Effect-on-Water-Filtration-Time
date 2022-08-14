Data FFD1; /*Unreplicated 2^7-4 FFD with resolution 3 (max)*/
Input y     A B C D E F G;
/*AB= A*B; AC=A*C; BC=B*C; ABC= A*B*C;*/
Lines;
68.4   -1  -1  -1  +1  +1  +1  -1
77.7   +1  -1  -1  -1  -1  +1  +1
66.4   -1  +1  -1  -1  +1  -1  +1
81.0   +1  +1  -1  +1  -1  -1  -1
78.6   -1  -1  +1  +1  -1  -1  +1
41.2   +1  -1  +1  -1  +1  -1  -1
68.7   -1  +1  +1  -1  -1  +1  -1
38.7   +1  +1  +1  +1  +1  +1  +1
;

proc glm data = FFD1; /*Half normal plot*/
model y = A|B|C /solution;
ods output ParameterEstimates=PE1;
run;
quit;
data PE2;
set PE1;
estimate = abs(estimate);
if _n_>1;
drop StdErr tValue Probt Biased;
run;
quit;
proc rank data = PE2 out = PE3;
var estimate;
ranks u; run;
data PE4;
set PE3;
zscore = probit (.5+.5*((u-0.5)/7));
run;
proc sgplot data = PE4;
scatter y = zscore x = estimate/datalabel = Parameter;
yaxis label ='Half Normal Scores';
title 'Half normal Probability Plot';
run;
quit;

proc glm data = FFD1 plots = all diagnostics(unpack); /*Testing the significance of the parameters*/
class A /*B*/ C E;
model y = A C E /*B*C*/;
run;

/*proc reg data = FFD1; /*Testing the significance of the parameters*/*/
/*model y = A C E /*B*C*/;*/
/*run;*/;

proc glm data = FFD1; /*Best setting*/
class A C;
model y = A|C;
lsmeans A|C / pdiff = all adjust = Tukey lines;
run;
quit;

/*proc glm data = FFD1; /*Comparing*/*/
/*class ;*/
/*model y =;*/
/*lsmeans  / pdiff = all adjust = Tukey lines;*/
/*run;*/
/*quit;*/;




Data FFD2; /*Unreplicated 2^7-3 FFD with resolution 4 (max)*/
Input y     A  B  C  D  E  F  G;
/*AE = A*E;*/
Lines;
68.4   -1  -1  -1  +1  +1  +1  -1
77.7   +1  -1  -1  -1  -1  +1  +1
66.4   -1  +1  -1  -1  +1  -1  +1
81.0   +1  +1  -1  +1  -1  -1  -1
78.6   -1  -1  +1  +1  -1  -1  +1
41.2   +1  -1  +1  -1  +1  -1  -1
68.7   -1  +1  +1  -1  -1  +1  -1
38.7   +1  +1  +1  +1  +1  +1  +1
66.7   +1  +1  +1  -1  -1  -1  +1
65.0   -1  +1  +1  +1  +1  -1  -1
86.4   +1  -1  +1  +1  -1  +1  -1
61.9   -1  -1  +1  -1  +1  +1  +1
47.8   +1  +1  -1  -1  +1  +1  -1
59.0   -1  +1  -1  +1  -1  +1  +1
42.6   +1  -1  -1  +1  +1  -1  +1
67.6   -1  -1  -1  -1  -1  -1  -1
;

proc glm data = FFD2; /*Half normal plot*/
model y = A|B|C|D /solution;
ods output ParameterEstimates = PE1;
run;
quit;
data PE2;
set PE1;
estimate = abs(estimate);
if _n_>1;
drop StdErr tValue Probt Biased;
run;
quit;
proc rank data = PE2 out = PE3;
var estimate;
ranks u; run;
data PE4;
set PE3;
zscore = probit (.5+.5*((u-0.5)/15));
run;
proc sgplot data = PE4;
scatter y = zscore x = estimate/datalabel = Parameter;
yaxis label = 'Half Normal Scores';
title 'Half normal Probability Plot';
run;
quit;

Proc glm data = FFD2 plots = all diagnostics(unpack); /*Testing the significance of the parameters*/
Class A B C D E F;
Model y =  A /*ABCD is */A*E /*BCD is */E / p;
Run;
quit;

/*proc reg data = FFD2; /*Testing the significance of the parameters*/*/
/*model y = A AE E /*B*C*/;*/
/*run;*/;

proc glm data = FFD2; /*Best setting*/
class A E;
model y = A|E;
lsmeans A|E / pdiff = all adjust = Tukey lines;
run;
quit;
