-- DROP TABLE spenos.capturedata;

CREATE TABLE spenos.capturedata
(
  speno character varying,
  spectype character varying,
  projectid character varying,
  species character varying,
  age character varying,
  sex character varying,
  capture_dt timestamp with time zone,
  latitude numeric,
  longitude numeric,
  permitno character varying,
  geom geometry(Point,4326),
  objectid serial NOT NULL,
  CONSTRAINT capturedata_pkey PRIMARY KEY (objectid),
  CONSTRAINT enforce_srid_shape CHECK (st_srid(geom) = 4326)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE spenos.capturedata
  OWNER TO londonj;
GRANT ALL ON TABLE spenos.capturedata TO londonj;
GRANT ALL ON TABLE spenos.capturedata TO richmonde;
GRANT SELECT ON TABLE spenos.capturedata TO arcgis_server;

CREATE INDEX capturedata_geom_idx
  ON spenos.capturedata
  USING gist
  (geom);
  
SELECT INTO spenos.capturedata (
	select speno,
	spectype,
	projectid,
	species,
	age,
	sex,
	capture_dt,
	latitude,
	longitude,
	permitno 
	from peptel_capturedata
	);
	
UPDATE spenos.capturedata SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);