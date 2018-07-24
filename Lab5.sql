/* 1) Display full name of the employees using format of Last, First, their  hire date and 
salary together with their department name and city, but only for departments which names 
start with an A or S sorted by department name and employee name.  Show me one row and tell 
me how many rows were in the output
Sample output: 
Termede, Ingrid                                 01-DEC-14      11000 Sales */

SELECT (E.LAST_NAME || ', ' || E.FIRST_NAME) AS "Full Name", E.HIRE_DATE, E.SALARY,
D.DEPARTMENT_NAME, L.CITY
FROM EMPLOYEES E
JOIN DEPARTMENTS D
  ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN LOCATIONS L
  ON D.LOCATION_ID = L.LOCATION_ID
WHERE D.DEPARTMENT_NAME LIKE 'A%' OR D.DEPARTMENT_NAME LIKE 'S%'
ORDER BY D.DEPARTMENT_NAME, E.LAST_NAME;

