-- DROP TABLE surveys.boss_tracks;

CREATE TABLE surveys.boss_tracks AS 
SELECT a.flightid, St_MakeLine(geom)::geometry(Geometry,4326) as track_line
FROM (SELECT flightid, geom FROM surveys.fmclogs ORDER BY flightid,dt_utc) a 
GROUP BY a.flightid;
ALTER TABLE surveys.boss_tracks ADD COLUMN objectid SERIAL NOT NULL;
ALTER TABLE surveys.boss_tracks ADD PRIMARY KEY (objectid);

CREATE INDEX ON surveys.boss_tracks USING gist (track_line);