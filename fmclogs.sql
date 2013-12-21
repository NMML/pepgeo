CREATE TABLE surveys.fmclogs
(
  dt_utc timestamp with time zone,
  flightid character varying,
  gpslat numeric,
  gpslong numeric,
  gpsalt numeric,
  gpsspd numeric,
  gpshead numeric,
  roll numeric,
  pitch numeric,
  heading numeric,
  baroalt numeric,
  effort character varying,
  geom geometry(Point,4326),
  objectid serial NOT NULL,
  CONSTRAINT fmclogs_pkey PRIMARY KEY (objectid),
  CONSTRAINT enforce_srid_shape CHECK (st_srid(geom) = 4326)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE surveys.fmclogs
  OWNER TO londonj;
GRANT ALL ON TABLE surveys.fmclogs TO londonj;
GRANT ALL ON TABLE surveys.fmclogs TO richmonde;
GRANT SELECT ON TABLE surveys.fmclogs TO pep_user;
GRANT SELECT ON TABLE surveys.fmclogs TO arcgis_server;

CREATE INDEX fmclogs_geom_idx
  ON surveys.fmclogs
  USING gist
  (geom);

TRUNCATE TABLE surveys.fmclogs;      

SELECT INTO surveys.fmclogs (SELECT * FROM pepsurveys_fmclogs);

UPDATE surveys.fmclogs SET geom = ST_SetSRID(ST_MakePoint(gpslong, gpslat), 4326);

