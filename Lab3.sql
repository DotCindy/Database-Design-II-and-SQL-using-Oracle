/* 1) REMEMBER to copy the SQL and the output to the answer area
Any employees that are in departments 20, 50 and 70 display last name,  salary, and the salary if 
it is increased by 5%. Make sure the output is a whole number. Also add a column that subtracts 
the old salary from the new salary and multiplies the difference by 12.
Label that last column   Cost of Pay Increase */

SELECT  LAST_NAME "Last Name", SALARY "Salary", SALARY*1.05 "Salary+5%",        
ROUND(((SALARY*1.05)-SALARY)*12) "Cost of Pay Increase"
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID IN(20, 50, 70);

/* 2) Write a query to display the tomorrow’s date in the following format:
September 28th of year 2006  <-- this is the format for the date you display. Your result will 
depend on the day when you create this query.
Label the column Tomorrow. */

SELECT TO_CHAR (SYSDATE+1, 'Mon DD"th of year" YYYY') "Tomorrow"
FROM DUAL;

/* 3) USE CASE statement
Write a query that displays the employee’s Full Name and Job Title in the following format:
DAVIES, CURTIS is Store Clerk
Only employees whose last name ends with S and first name starts with  C or K.
Give this column an appropriate labe
Sort the result by the employees’ last names. */

SELECT  UPPER(LAST_NAME) || ', ' || UPPER(FIRST_NAME) || ' is ' || 
CASE JOB_ID
WHEN 'IT_PROG' THEN 'Programmer'
WHEN 'AC_ACCOUNT' THEN 'Accountant'
WHEN 'AC_MGR' THEN 'Manager'
WHEN 'ST_CLERK' THEN 'Store Clerk'
WHEN 'SA_REP' THEN 'Sales Rep'
WHEN 'ST_MAN' THEN 'Store Manager'
ELSE 'Not Known'
END "Person and Job"
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%s' AND (FIRST_NAME LIKE 'C%' OR FIRST_NAME LIKE 'K%')
ORDER BY LAST_NAME;
