DROP FOREIGN TABLE peptel_capturedata;
CREATE FOREIGN TABLE peptel_capturedata (
SPENO varchar NOT NULL 
, SPECTYPE varchar
, PROJECTID varchar 
, SECONDARYID varchar 
, RELATIVEID varchar
, SPECIES varchar 
, LOCATIONNAME varchar 
, SITEID varchar
, LATITUDE numeric 
, LONGITUDE numeric 
, CAPTURE_DT timestamptz 
, RELEASE_DT timestamptz 
, SEX varchar 
, AGE varchar 
, MOLT varchar 
, PREGNANT varchar 
, PVPELAGE varchar 
, TAGNUMBERLEFT varchar
, TAGNUMBERRIGHT varchar 
, TAGCOLOR varchar 
, NUMERICTAGTYPE varchar 
, PERMITNO varchar 
, COMMENTS varchar 
) SERVER raja OPTIONS (schema 'PEPTEL', table 'PEPCAPTUREDATA');