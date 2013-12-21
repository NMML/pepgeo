-- DROP TABLE surveys.boss_oneffort_tracks;

CREATE TABLE surveys.boss_oneffort_tracks
(
  flightid character varying,
  track_geom geometry(Geometry,4326),
  objectid serial NOT NULL,
  CONSTRAINT boss_oneffort_tracks_pkey PRIMARY KEY (objectid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE surveys.boss_oneffort_tracks
  OWNER TO londonj;
GRANT ALL ON TABLE surveys.boss_oneffort_tracks TO londonj;
GRANT ALL ON TABLE surveys.boss_oneffort_tracks TO richmonde;
GRANT SELECT ON TABLE surveys.boss_oneffort_tracks TO pep_user;
GRANT SELECT ON TABLE surveys.boss_oneffort_tracks TO arcgis_server;

CREATE INDEX boss_oneffort_tracks_track_geom_idx
  ON surveys.boss_oneffort_tracks
  USING gist
  (track_geom);

SELECT INTO surveys.boss_oneffort_tracks (
WITH fmclogs_effort_code AS (
SELECT flightid,
	dt_utc,
	geom, 
	CASE 
		WHEN effort = 'On' THEN 1 
		ELSE 0 
	END as effort_code
FROM surveys.fmclogs
ORDER BY flightid, dt_utc),
t1 AS (
SELECT flightid,effort_code,dt_utc,geom,
	LAG(effort_code) OVER (ORDER BY flightid,dt_utc) IS DISTINCT FROM effort_code as chg_pt
FROM fmclogs_effort_code),
t2 AS (
SELECT flightid, effort_code, dt_utc,SUM(chg_pt::int) OVER (order by flightid, dt_utc) as segID,geom from t1
),
t3 AS (
SELECT flightid,concat(flightid,'_',segID) as trk_segID,AVG(effort_code)::int as effort_code,St_MakeLine(geom)::geometry(Geometry,4326) as seg_geom
FROM t2
WHERE effort_code = 1
GROUP BY flightid, segID)
SELECT flightid,ST_Multi(ST_Union(seg_geom))::geometry(Geometry,4326) as track_geom FROM t3 GROUP BY flightid
);
