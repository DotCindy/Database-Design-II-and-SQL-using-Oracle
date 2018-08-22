/* 1) Create table CITIES from table LOCATIONS, but only for location numbers less than 2000 
(do NOT create this table from scratch).
à You will have exactly 10 rows here.
When you describe CITIES, the output is shown below: */
CREATE TABLE CITIES AS
  SELECT LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY,
    STATE_PROVINCE, COUNTRY_ID
  FROM LOCATIONS
  WHERE LOCATION_ID < 2000;

/* 2) Create table TOWNS from table LOCATIONS, but only for location numbers less than 1500 
(do NOT create this table from scratch). This table will have same structure as table CITIES.
à You will have exactly 5 rows here. */
CREATE TABLE TOWNS AS
  SELECT LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY,
    STATE_PROVINCE, COUNTRY_ID
  FROM LOCATIONS
  WHERE LOCATION_ID < 1500;

/* 3) Now you will empty your RECYCLE BIN with one powerful command. Then remove your table 
TOWNS, so that will remain in the recycle bin. Check that it is really there and what time was 
removed. */
PURGE RECYCLEBIN;
DROP TABLE TOWNS;
SELECT * FROM RECYCLEBIN;

/* 4) Restore your table TOWNS from recycle bin and describe it. Check what is in your recycle 
bin now. */
FLASHBACK TABLE TOWNS TO BEFORE DROP;
SELECT * FROM RECYCLEBIN;

/* 5) Now remove table TOWNS so that does NOT remain in the recycle bin. Check that is really NOT 
there and then try to restore it. Explain what happened? */
DROP TABLE TOWNS PURGE;
FLASHBACK TABLE TOWNS TO BEFORE DROP;

/* 6) Create simple view called CAN_CITY_VU, based on table CITIES so that will contain only 
columns Street_Address, Postal_Code, City and State_Province for locations only in CANADA. 
Then display all data from this view. */
CREATE VIEW CAN_CITY_VU AS
SELECT STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE
FROM CITIES
WHERE UPPER(COUNTRY_ID) LIKE 'CA';

