-- DROP TABLE telemetry.locations;

CREATE TABLE telemetry.locations
(
  deployid character varying,
  speno character varying,
  projectid character varying,
  species character varying,
  deploydate timestamp with time zone,
  tagtype character varying,
  age character varying,
  sex character varying,
  datadatetime timestamp with time zone,
  quality character varying,
  latitude numeric,
  longitude numeric,
  error_radius numeric,
  error_semi_major_axis numeric,
  error_semi_minor_axis numeric,
  error_ellipse_orientation numeric,
  geom geometry(Point,4326),
  objectid serial NOT NULL,
  CONSTRAINT locations_pkey PRIMARY KEY (objectid),
  CONSTRAINT enforce_srid_shape CHECK (st_srid(geom) = 4326)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE telemetry.locations
  OWNER TO londonj;
GRANT ALL ON TABLE telemetry.locations TO londonj;
GRANT ALL ON TABLE telemetry.locations TO richmonde;
GRANT SELECT ON TABLE telemetry.locations TO pep_user;
GRANT SELECT ON TABLE telemetry.locations TO arcgis_server;

CREATE INDEX locations_geom_idx
  ON telemetry.locations
  USING gist
  (geom);

SELECT INTO telemetry.locations
(SELECT 
	deployid, speno, projectid, species, deploydate, tagtype, age, sex, datadatetime,
	quality, latitude, longitude, error_radius, error_semi_major_axis, error_semi_minor_axis,
	error_ellipse_orientation FROM telemetry.peptel_locations);
	
UPDATE telemetry.locations SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);