DROP TABLE IF EXISTS volusia.streets_merged

CREATE TABLE volusia.streets_merged
(
	Street_GUID SERIAL PRIMARY KEY,
	Street_Name varchar(25),
	Street_Type varchar(5),
	Left_Address_From int,
	Left_Address_To int,
	Right_Address_From int,
	Right_Address_To int,
	Speed_Limit_MPH int,
	Street_Geo geometry
)

INSERT INTO volusia.streets_merged (Street_name, Street_Type, Left_Address_From, Left_Address_To, Right_Address_From, Right_Address_To, Speed_Limit_MPH, Street_Geo)
SELECT street_nam, 
	street_typ, 
	MIN(l_add_from),
	MAX(l_add_to),
	MIN(r_add_from),
	MAX(r_add_to),
	MIN(mph),
	ST_Union(geom) AS street_geom 
FROM volusia.gis_streets 
GROUP BY street_nam, street_typ 
ORDER BY street_nam

---------------------------------------------------------------------------
-- Manual Standardization for high-error streets
---------------------------------------------------------------------------

UPDATE volusia.streets_merged
SET street_type = 'AVE'
WHERE street_type = 'AV'

UPDATE volusia.situs
SET adrsuf = 'AVE'
WHERE adrsuf = 'AV'

UPDATE volusia.situs
SET adrstr = 'INTL SPEEDWAY'
WHERE adrstr = 'INTERNATIONAL SPEEDWAY'

UPDATE volusia.situs
SET adrstr = 'BIG CRANE',
	adrsuf = 'LOOP'
WHERE adrstr = 'BIG CRANE LOOP'

UPDATE volusia.situs
SET adrstr = 'BEAR TOOTH',
	adrsuf = 'PATH'
WHERE adrstr = 'BEAR TOOTH PATH'

UPDATE volusia.situs
SET adrstr = 'GRIZZLY BEAR',
	adrsuf = 'PATH'
WHERE adrstr = 'GRIZZLY BEAR PATH'

UPDATE volusia.situs
SET adrstr = 'GOLDEN BEAR',
	adrsuf = 'PATH'
WHERE adrstr = 'GOLDEN BEAR PATH'

UPDATE volusia.situs
SET adrstr = 'POLAR BEAR',
	adrsuf = 'PATH'
WHERE adrstr = 'POLAR BEAR PATH'

UPDATE volusia.situs
SET adrstr = 'POOH BEAR',
	adrsuf = 'PATH'
WHERE adrstr = 'POOH BEAR PATH'

UPDATE volusia.situs
SET adrstr = 'PANDA BEAR',
	adrsuf = 'PATH'
WHERE adrstr = 'PANDA BEAR PATH'

UPDATE volusia.situs
SET adrstr = 'DR MARY MCLEOD BETHUNE'
WHERE adrstr = 'DR MARY M BETHUNE'

---------------------------------------------------------------------------
-- Final Situs updates
---------------------------------------------------------------------------
	
ALTER TABLE volusia.situs ADD COLUMN street_guid int

UPDATE volusia.situs sit
SET street_guid = str.street_guid
FROM volusia.streets_merged str
WHERE str.street_name = sit.adrstr
	AND (str.street_type = sit.adrsuf OR (str.street_type IS NULL AND sit.adrsuf IS NULL))
	
---------------------------------------------------------------------------
-- The top results will display the count of parcels per street name that
-- did not have a match within volusia.streets_merged
---------------------------------------------------------------------------
	
SELECT adrstr, adrsuf, COUNT(parid), street_guid FROM volusia.situs 
GROUP BY adrstr, street_guid, adrsuf
ORDER BY street_guid DESC
	
