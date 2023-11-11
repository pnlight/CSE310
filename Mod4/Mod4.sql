/*This code is to create different users in PGSQL. We'll be using them next week but for now we'll just leave them there.*/
CREATE ROLE editors 
NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT;

CREATE ROLE viewers
NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT;

CREATE ROLE editor1 LOGIN 
ENCRYPTED PASSWORD 'editorsecret' 
NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT IN ROLE editors;

CREATE ROLE viewer1 LOGIN 
ENCRYPTED PASSWORD 'viewersecret' 
NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT IN ROLE viewers;

GRANT USAGE ON SCHEMA sde TO editors;
GRANT USAGE ON SCHEMA sde TO viewers;

-- SCHEMA: sde

-- DROP SCHEMA IF EXISTS sde ;

-- this creates my schema and grants all the authorization. I already have an schema as sde so this will do nothing.
CREATE SCHEMA IF NOT EXISTS sde
    AUTHORIZATION sde;

GRANT USAGE ON SCHEMA sde TO PUBLIC;

GRANT ALL ON SCHEMA sde TO sde;

-- I also have an sde schema already setup.

CREATE DATABASE Test_mod4;

\c Test_mod4;

CREATE EXTENSION IF NOT EXISTS postgis; -- make sure PostGIS is installed we need the spatial references for it to work on ArcGIS.

CREATE SCHEMA sde;

SET search_path TO sde, public;

CREATE TABLE spatial_ref_sys (
    srid integer NOT NULL,
    auth_name character(256),
    auth_srid integer,
    srtext character(2048),
    proj4text character(2048)
);

INSERT INTO spatial_ref_sys(srid, auth_name, auth_srid, srtext, proj4text) 
VALUES (3857, 'EPSG', 3857, 'GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.01745329251994328,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]]', '+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext +no_defs');

CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE sde.testpoints (
    id serial PRIMARY KEY,
    geom geometry(Point, 3857),
    attribute1 varchar(255),
    attribute2 integer
);

CREATE INDEX idx_my_points_geom ON sde.testpoints USING GIST(geom);

INSERT INTO sde.testpoints (geom, attribute1, attribute2)
VALUES (ST_GeomFromText('POINT(-71.060316 48.432044)', 3857), 'Example', 1);

-- Most of these commands are for testing purpose. We will create the layers directly in arcgis pro and we can do the wrangling in the back end.

-- The adding and update of the attribute is better done in the front end which is ArcGIS. 

-- But we can do joins adds and remove in PGSQL too for example:

