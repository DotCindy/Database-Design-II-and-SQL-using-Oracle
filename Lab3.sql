/* 1) REMEMBER to copy the SQL and the output to the answer area
Any employees that are in departments 20, 50 and 70 display last name,  salary, and the salary if 
it is increased by 5%. Make sure the output is a whole number. Also add a column that subtracts 
the old salary from the new salary and multiplies the difference by 12.
Label that last column   Cost of Pay Increase */

SELECT  LAST_NAME "Last Name", SALARY "Salary", SALARY*1.05 "Salary+5%",        
ROUND(((SALARY*1.05)-SALARY)*12) "Cost of Pay Increase"
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID IN(20, 50, 70);

SELECT TO_CHAR (SYSDATE+1, 'Mon DD"th of year" YYYY') "Tomorrow"
FROM DUAL;
