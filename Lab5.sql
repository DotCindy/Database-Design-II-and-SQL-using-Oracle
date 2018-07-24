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

/* 2) Display the department name, city, street address and postal code for all departments 
sorted by city and department name. */

SELECT DEPARTMENT_NAME, CITY, STREET_ADDRESS, POSTAL_CODE
FROM DEPARTMENTS
JOIN LOCATIONS USING(LOCATION_ID)
ORDER BY CITY, DEPARTMENT_NAME;

/* 3) Display the full name of the manager of each department in states/provinces of Ontario, 
California, Bavaria and Washington along with the department name, city, postal code and 
province name.   Sort the output by city and then by department name. */

SELECT (LAST_NAME || ', ' || FIRST_NAME) AS "Full Name", DEPARTMENT_NAME,
CITY, POSTAL_CODE, STATE_PROVINCE "Province Name"
FROM EMPLOYEES E
JOIN DEPARTMENTS D
  ON E.MANAGER_ID = D.MANAGER_ID
JOIN LOCATIONS L
  ON L.LOCATION_ID = D.LOCATION_ID
WHERE L.STATE_PROVINCE IN('Ontario', 'California', 'Bavaria', 'Washington')
ORDER BY CITY, DEPARTMENT_NAME;

/* 4) Display employee’s Managers ID, managers Last Name and employee number nd last name 
Label the columns Manager, Mgr# ,Employee and Emp#, respectively. Sort by manager number */

SELECT M.LAST_NAME "Manager", M.MANAGER_ID "Mgr#", E.LAST_NAME "Employee", E.EMPLOYEE_ID "Emp#"
FROM EMPLOYEES E 
LEFT OUTER JOIN EMPLOYEES M
  ON (E.MANAGER_ID = M.EMPLOYEE_ID)
ORDER BY M.MANAGER_ID;

-- 5) Display the location id, address, city, state and country for each location id.
SELECT LOCATION_ID, STREET_ADDRESS, CITY, STATE_PROVINCE, COUNTRY_NAME
FROM LOCATIONS L
LEFT JOIN COUNTRIES C
  ON (L.COUNTRY_ID = C.COUNTRY_ID);

-- 6) Display the employee id, last name, job, department name, and job grade for all employees.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.JOB_ID, DEPARTMENT_NAME, J.GRADE
FROM EMPLOYEES E
LEFT JOIN JOB_GRADES J
  ON E.SALARY BETWEEN J.LOWEST_SAL AND J.HIGHEST_SAL
LEFT JOIN DEPARTMENTS D
  ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

/* 7) Display the employee id and first name of every employee along with the first name and 
id of the employee's manager (if applicable).
order by employee d
only show rows with employee id greater than 30 and less than 110 */

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, M.FIRST_NAME, M.MANAGER_ID
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES M
  ON (M.EMPLOYEE_ID = E.MANAGER_ID)
WHERE (E.EMPLOYEE_ID BETWEEN 31 AND 109) AND M.MANAGER_ID IS NOT NULL
ORDER BY E.EMPLOYEE_ID;

/* 8) Display the employee id, last name of every employee and the name of the department and 
city that the employee is assigned to (if applicable). */

SELECT E.EMPLOYEE_ID, E.LAST_NAME, DEPARTMENT_NAME, CITY
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
  ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
LEFT JOIN LOCATIONS L
  ON (L.LOCATION_ID = D.LOCATION_ID)
WHERE CITY IS NOT NULL;

/* 9) Display the name of each city and the names of employees assigned to that city 
(if applicable). */

SELECT L.CITY "City", (E.LAST_NAME || ', ' || E.FIRST_NAME) AS "Employee Name"
FROM LOCATIONS L
LEFT JOIN DEPARTMENTS D
  ON (L.LOCATION_ID = D.LOCATION_ID)
LEFT JOIN EMPLOYEES E
  ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
WHERE FIRST_NAME IS NOT NULL
ORDER BY CITY;

-- 10) Display all employees and all cities.

SELECT L.CITY "City", (E.LAST_NAME || ', ' || E.FIRST_NAME) AS "Employee Name"
FROM LOCATIONS L
FULL JOIN DEPARTMENTS D
  ON (L.LOCATION_ID = D.LOCATION_ID)
FULL JOIN EMPLOYEES E
  ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
ORDER BY CITY;
