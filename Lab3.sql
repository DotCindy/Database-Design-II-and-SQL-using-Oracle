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

/* 4) For each employee hired in 2014, display the employee’s last name, hire date and calculate
the number of YEARS between TODAY and the date the employee was hired.  Label the column Years
worked. Order your results by the number of years employed.  Use the label to do the order by
Round the number of years employed up to the closest whole number. */

SELECT LAST_NAME "Last Name", HIRE_DATE "Hire Date", ROUND((SYSDATE-HIRE_DATE)/365) "Years worked"
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '01-JAN-14' AND '31-DEC-14'
ORDER BY "Years worked";

/* 5) Create a query that displays the city names, country codes and state/province names, but only
for those cities that start on S and have at least 8 characters in their name. If city does not have
a province name assigned, then 
put Province Unknown */

SELECT CITY "City", COUNTRY_ID "Country Code", 
NVL(STATE_PROVINCE,'Province Unknown') "State/Province Name"
FROM LOCATIONS
WHERE CITY LIKE 'S%_______';

/* 6) Display each employee’s last name, hire date, and salary review date. The salary review date is 
the first Wednesday after a year of service, but only for those hired after 2015.
Format the dates to appear in the format similar to
Chan                      30-JUN-16 WEDNESDAY , July      the Fifth of year 2017 */

SELECT LAST_NAME "Last Name", HIRE_DATE "Hire Date",
TO_CHAR(NEXT_DAY((HIRE_DATE+365), 'WEDNESDAY'), 
('DAY "," Month "the" Ddspth "of year" YYYY')) "Salary Review Date"
FROM EMPLOYEES
WHERE HIRE_DATE >= '01-JAN-16';
