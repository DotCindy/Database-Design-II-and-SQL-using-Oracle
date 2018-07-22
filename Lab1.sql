// 1) Load CMCdemo-20182-withreps.txt and CMCscript

// 2)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOB_HISTORY;

// 3) 
SET pagesize 200

// 4) NONE

// 5) No answer needed

// 6) What command would show the structure of the LOCATIONS table.
DESC LOCATIONS;

// 7) Create a query to display the output shown below. NOTE: unless you are using a fixed font like Courier New the output will be a little wavy looking
// City#        City        Province with Country Code
// ------------------------------------------------------------------
// 1000         Roma        IN THE IT
// 1100         Venice      IN THE IT
// 1200         Tokyo       Tokyo Prefecture IN THE JP
// 1300         Hiroshima   IN THE JP
// 1400         Southlake   Texas IN THE US
// 1500         South       San Francisco California IN THE US

SELECT  LOCATION_ID “City#”, CITY “City”, STATE_PROVINCE || ‘ IN THE ‘ || as “Province with Country Code”
FROM    LOCATIONS
WHERE   LOCATION_ID >= 1000 AND LOCATION_ID <= 1500;

// 8) Create a query to display unique (department codes and job titles) from the EMPLOYEES table.
// AGAIN, show the SQL and also the output

SELECT  DISTINCT DEPARTMENT_ID, JOB_ID
FROM    EMPLOYEES;
