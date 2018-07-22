/* 1) Display the (1) employee_id,(2) Last name, First name (as one name with a comma between) 
and a column name called Full Name(3) salary
Only show employees earning in the range of $8000 to $15,000.
Sort the output by top salaries first and then by last name. */

SELECT EMPLOYEE_ID, LAST_NAME || ' ' || FIRST_NAME AS "FULL NAME", SALARY
FROM EMPLOYEES
WHERE SALARY >= 8000 AND SALARY <= 15000
ORDER BY SALARY DESC, LAST_NAME;

/* 2) -- Modify previous query (#1) so that additional condition is to display only
-- if they work as Programmers or Sales Representatives.
-- Use same sorting as before. */

SELECT EMPLOYEE_ID, LAST_NAME || ' ' || FIRST_NAME AS "FULL NAME", SALARY, JOB_ID
FROM EMPLOYEES
WHERE SALARY BETWEEN 8000 AND 15000 AND JOB_ID IN('IT_PROG','SA_REP')
ORDER BY SALARY DESC, LAST_NAME;

/* 3) -- The Human Resources department wants to find high salary and low salary employees. 
Use columns, employee id, last name, salary and job_id only. You are modifying a previous 
query so that it displays the same job titles but for people who earn outside the given 
salary range from question.  Use same sorting as before. */

SELECT EMPLOYEE_ID, LAST_NAME, SALARY, JOB_ID
FROM EMPLOYEES
WHERE NOT SALARY BETWEEN 8000 AND 15000 AND JOB_ID IN('IT_PROG','SA_REP')
ORDER BY SALARY DESC, LAST_NAME;

-- 4)
SELECT
    last_name AS "Last Name",    --- column titles not needed
    salary AS "Salary",
    job_id AS "Job Title",
    hire_date as "Started"
    FROM employees
    WHERE
        (hire_date < DATE '1998-01-01')
    ORDER BY hire_date DESC;

/* 5) Display the job titles and full names of employees whose first name contains an ‘e’ or ‘E’ 
anywhere as well as a 'g'. The output should look like:
Job Title  Full Name                                   
---------- ----------------------------------------------
SA_REP     Miguel Sanchez */

SELECT JOB_ID "Job Title", FIRST_NAME || ' ' || LAST_NAME AS "FULL NAME"
FROM EMPLOYEES
WHERE (FIRST_NAME LIKE '%e%' OR FIRST_NAME LIKE '%E%') AND FIRST_NAME LIKE '%g%';

/* 6) Create a report to display last name, salary, and commission percent for all employees 
that earn a commission and employee number greater than 100. */

SELECT LAST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE EMPLOYEE_ID > 100 AND COMMISSION_PCT IS NOT NULL;

/* 7) Do the same as previous question, but use a numeric value instead of a column name to 
put the report in order by salary from highest to lowest */

SELECT LAST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE EMPLOYEE_ID > 100 AND COMMISSION_PCT IS NOT NULL
ORDER BY 2 DESC;
