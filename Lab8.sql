SELECT department_id
FROM departments
MINUS
SELECT department_id
FROM departments
WHERE job_id = 'ST_CLERK'


/* 1) Same department requests a list of countries that have no departments located in them. 
Display country ID and the country name. Use SET operators. */

SELECT COUNTRY_ID, COUNTRY_NAME
FROM COUNTRIES
MINUS
SELECT COUNTRY_ID, COUNTRY_NAME
FROM COUNTRIES
JOIN LOCATIONS
  USING(COUNTRY_ID)
JOIN DEPARTMENTS
  USING(LOCATION_ID)
WHERE DEPARTMENT_ID IS NOT NULL;

/* 2) The Vice President needs very quickly a list of departments 10, 50, 20 in that 
order. job and department ID are to be displayed */

SELECT DISTINCT JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 10
UNION ALL
SELECT DISTINCT JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
UNION ALL
SELECT DISTINCT JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20;
