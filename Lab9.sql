/* 1) Display the names of the employees whose salary is the same as the lowest salaried employee 
in any department. */

SELECT (LAST_NAME || ', ' || FIRST_NAME) AS "Full Name"
FROM EMPLOYEES
WHERE SALARY IN (SELECT MIN(SALARY)
                FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID)
AND DEPARTMENT_ID IS NOT NULL;
