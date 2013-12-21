DROP FOREIGN TABLE pepsurveys.fmclogs;

CREATE FOREIGN TABLE pepsurveys_fmclogs (
        dt_utc timestamptz, 
	flightid varchar, 
	gpslat numeric, 
	gpslong numeric, 
	gpsalt numeric, 
	gpsspd numeric, 
	gpshead numeric, 
	roll numeric, 
	pitch numeric, 
	heading numeric, 
	baroalt numeric, 
	effort varchar
       ) SERVER raja OPTIONS (schema 'PEPSURVEYS', table 'FMCLOGS');
