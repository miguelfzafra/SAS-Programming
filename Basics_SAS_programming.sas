/*****************************/
/* BASICS OF SAS PROGRAMMING */
/*****************************/

/* Create a library: library PRUEBA */
libname NOMBRE_LIB '...' 
	Options compress= yes, /* Compress the datasets */
	access= readonly; /* Read-only acces to the datasets */


/* Macro variables definition */

%let var =1; /* %let is always used */
%let var2 ='A';

/* With %put we write the output of the sentence in the log */

%put Los valores de var y var2 son &var y &var2;

/* Creating datasets */

data TABLA_1;
	NOMBRE= 'John';
	EDAD= 42;
	OUTPUT;
	NOMBRE= 'Lisa';
	EDAD= 38;
	OUTPUT;
run;

/* SQL queries */

/* Create a variable which counts the number of rows */

proc sql;
create table TABLA_2 as
select *, count (EDAD) as CUENTA
from TABLA_1;
quit;

/* Create a variable which count the number of rows and summarize by NOMBRE */

proc sql;
create table TABLA_3 as
select *, count (EDAD) as CUENTA
from TABLA_1
group by NOMBRE;
quit;

/* The DISTINCT statement: deletes duplicate rows */

proc sql;
create table TABLA_4 as
select distinct *, count (EDAD) as CUENTA
from TABLA_1
group by NOMBRE;
quit;

/* Depending on where I put the DISTINCT, I get different results */

proc sql;
create table TABLA_4 as
select *, count (distinct(EDAD)) as CUENTA
from TABLA_1
group by NOMBRE;
quit;

/* Joins */

proc sql;
	create table TABLA_SALIDA as
	select a.*, b.EDAD as EDAD_2
	from TABLA_1 as a left join TABLA2 as b
	on a.NOMBRE=B.nombre;
quit;

/* Create a computed variable */

data TABLA_5;
set TABLA_1;
if NOMBRE='John' then VARIABLE='OK '; /* The variable is created with this length */
else VARIABLE='NOK';
run;

/* Sort datasets */

proc sort data=TABLA_1
	out = TABlA_6(RENAME=(NOMBRE=CAMPO1 EDAD=CAMPO2) keep=NOMBRE EDAD);
	by descending VALOR;
run;

/* Delete duplicates */

proc sort data=TABLA_1 out=TABLA_7 NODUPKEY;
	BY UNO;
run;

/* Delete datasets */

proc delete data=TABLA_1;
run;

/* Rename variables */

proc datasets lib=WORK;
		modify TABLA_2;
		rename EDAD=EDAD_2;
	run;
quit;

/* Merge datasets (caution: datasets must be sorted) */

data AUX1;
	merge TAB1 (in=p) tab2(in=q);
	by CAMPO;
	if p;
run;
