CREATE TABLE total_building AS
SELECT building.buildingid, building.shortname, building.floorcount, building.bldgtype
FROM building
INNER JOIN survey ON building.buildingid = survey.building;