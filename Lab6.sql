-- 1)
SET AUTOCOMMIT ON

/* 2) Make sure you exist as an employee with a NULL salary and 0.2 commission_pct in 
department 90. Fill in the other fields as well
That requires an INSERT */
INSERT INTO EMPLOYEES
(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID,
SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES (99, 'Cindy', 'Le', 'CLE', '999.999.9999', '10-JUN-18', 'IT_PROG',
NULL, 0.2, 103, 90);

-- 3) Change the salary of the both employees with a last name of Matos and Whalen to be 2500.
UPDATE EMPLOYEES
SET SALARY = 2500
WHERE LAST_NAME IN('Matos', 'Whalen');

/* 4) YOU MUST USE SUBQUERIES for these questions.
(Must also minimize the number of tables when answering. Example don't use 10 tables when 3 
will do)
Display the last names of all employees who are in the same department as the employee named 
who has a name called Abel. */
SELECT LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                      FROM EMPLOYEES
                      WHERE LAST_NAME = 'Abel');
                      
-- 5) Display the last name then first name of the lowest paid employee(s)
SELECT LAST_NAME, FIRST_NAME
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEES);
                
-- 6) Display the city that the lowest paid employee(s) are located in.
SELECT CITY
FROM EMPLOYEES E
JOIN DEPARTMENTS D
  ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN LOCATIONS L
  ON L.LOCATION_ID = D.LOCATION_ID
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEES);
                
-- 7) Display the last name and  first name of the lowest paid employee(s) in each department
SELECT LAST_NAME, FIRST_NAME
FROM EMPLOYEES
WHERE SALARY IN (SELECT MIN(SALARY)
                FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID);
               
-- 8) Display the last name of the lowest paid employee(s) in each city
SELECT LAST_NAME, FIRST_NAME
FROM EMPLOYEES E
WHERE SALARY IN (SELECT MIN(SALARY)
                FROM EMPLOYEES E
                JOIN DEPARTMENTS D
                  ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                JOIN LOCATIONS L
                  ON L.LOCATION_ID = D.LOCATION_ID
                GROUP BY CITY);
                
/* 9) Display last name and salary for all employees who earn less than the lowest salary in 
ANY department.
Sort the output by top salaries first and then by last name. */
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT MIN(SALARY)
                    FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID)
ORDER BY SALARY DESC, LAST_NAME;

/* 10) Display last name, job title and salary for all employees whose salary matches any of 
the salaries from the IT Department.
Do NOT use Join method.
Sort the output by salary ascending first and then by last_name */

SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 60)
ORDER BY SALARY, LAST_NAME;
