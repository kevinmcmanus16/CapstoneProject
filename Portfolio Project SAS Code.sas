/* Create Library named SASUSER */
LIBNAME SASUSER "/home/u47475970/sasuser.v94/";

/* Modify variable names to appropriate naming conventions if needed */
OPTIONS VALIDVARNAME=v7;

/* Import dataset */
PROC IMPORT OUT = SASUSER.ChicagoCrimeWeather
	DATAFILE = "/home/u47475970/sasuser.v94/ChicagoCrimeWeather.csv"
	DBMS = CSV;
	GETNAMES = YES;
	DATAROW = 2;
RUN;

/* RQ1 - relationship between type of crime and weather variables */
PROC CORR DATA=SASUSER.ChicagoCrimeWeather PLOTS = MATRIX(HISTOGRAM NVAR = ALL) NOSIMPLE;
	VAR PRIMARY_TYPE AWND PGTM PRCP	SNWD TMAX TMIN WDF2	WDF5 WSF2 WSF5 WT01	WT02 WT03 WT04 WT06	WT08 WT09 WT10;
RUN;

/* RQ2 - relationshiop between type of crime and max temperature */
PROC CORR DATA=SASUSER.ChicagoCrimeWeather PLOTS = MATRIX(HISTOGRAM NVAR = ALL) NOSIMPLE;
	VAR PRIMARY_TYPE TMAX;
RUN;

/* RQ3 -  determine if weather variables can help predict type of crime */
PROC LOGISTIC DATA = SASUSER.ChicagoCrimeWeather;
	MODEL PRIMARY_TYPE = AWND PGTM PRCP	SNWD TMAX TMIN WDF2	WDF5 WSF2 WSF5 WT01	WT02 WT03 WT04 WT06	WT08 WT09 WT10;
RUN;

