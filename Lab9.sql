/* 1) Display the names of the employees whose salary is the same as the lowest salaried employee 
in any department. */
SELECT (LAST_NAME || ', ' || FIRST_NAME) AS "Full Name"
FROM EMPLOYEES
WHERE SALARY IN (SELECT MIN(SALARY)
                FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID)
AND DEPARTMENT_ID IS NOT NULL;

/* 2) Create a view named ALLEMPS that consists of all employees includes employee_id, last_name, 
salary, department_id, department_name, city and country (if applicable) */
CREATE VIEW ALLEMPS AS
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, DEPARTMENT_ID, DEPARTMENT_NAME, CITY, COUNTRY_NAME
FROM EMPLOYEES
JOIN DEPARTMENTS
  USING(DEPARTMENT_ID)
JOIN LOCATIONS
  USING(LOCATION_ID)
JOIN COUNTRIES
  USING(COUNTRY_ID);

/* 3) Use the ALLEMPS view to: a. Display the employee_id, last_name, salary and city for all 
employees */
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, CITY
FROM ALLEMPS;

/* 4) Using the same view
Display the total salary of all employees by city */
SELECT CITY, SUM(SALARY)
FROM ALLEMPS
GROUP BY CITY;

-- 5) Increase the salary of the lowest paid employee(s) in each department by 100
UPDATE ALLEMPS
SET SALARY = SALARY+100
WHERE SALARY IN(SELECT MIN(SALARY)
                FROM ALLEMPS
                WHERE DEPARTMENT_ID IS NOT NULL
                GROUP BY DEPARTMENT_ID);
                
-- 6) What happens if you try to insert an employee by providing values for all columns in this view?
INSERT INTO ALLEMPS VALUES
(98,'LE',99999,90,'IT','Toronto','Canada');
/* Error report:
SQL Error: ORA-01776: cannot modify more than one base table through a join view
01776. 00000 -  "cannot modify more than one base table through a join view"
*Cause:    Columns belonging to more than one underlying table were either
           inserted into or updated.
*Action:   Phrase the statement as two or more separate statements. */

-- 7) DELETE the employee named Vargas
DELETE FROM ALLEMPS
WHERE LAST_NAME = 'Vargas';

/* 8) Create a view named ALLDEPTS that consists of all departments and includes department_id, 
department_name, city and country (if applicable) */
CREATE VIEW ALLDEPTS AS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, CITY, COUNTRY_NAME
FROM DEPARTMENTS
LEFT JOIN LOCATIONS
  USING(LOCATION_ID)
LEFT JOIN COUNTRIES
  USING(COUNTRY_ID);

-- 9) For all departments display the department_id, name and city. Use ALLDEPTS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, CITY
FROM ALLDEPTS;

-- 10) For each city that has departments located in it display the number of departments
SELECT CITY, COUNT(DEPARTMENT_ID)
FROM ALLDEPTS
GROUP BY CITY;

/* 11) Create a view called ALLDEPTSUMM that consists of all departments and includes for each 
department: department_id, department_name, number of employees, number of salaried employees, 
total salary of all employees */
CREATE VIEW ALLDEPTSUMM AS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, COUNT(EMPLOYEE_ID) AS "# of Emps",
  COUNT(EMPLOYEE_ID) AS "# of Salaried Emps",
  SUM(SALARY) AS "Total Salary"
FROM DEPARTMENTS
JOIN EMPLOYEES
  USING(DEPARTMENT_ID)
GROUP BY DEPARTMENT_ID, DEPARTMENT_NAME
ORDER BY DEPARTMENT_ID;

/* 12) Use the ALLDEPTSUMM view to display department name and number of employees for departments 
that have more than the average number of employees */
SELECT DEPARTMENT_NAME, "# of Emps"
FROM ALLDEPTSUMM
WHERE "# of Emps" > (SELECT AVG("# of Emps")
                    FROM ALLDEPTSUMM);
                    
/* 13) In the past this has not worked, so this for reading only
GRANT statement to allow another student (use their Neptune account) to
retrieve data for your employees table and
 to allow that same student to retrieve, insert and update data in your departments table */
 
