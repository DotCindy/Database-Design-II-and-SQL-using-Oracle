/* 1) List all the countries that start with a letter entered by the user (prompt). The user 
must enter a lowercase letter */

SELECT * FROM COUNTRIES
WHERE COUNTRY_NAME LIKE UPPER('&COUNTRY_NAME%');

-- 2) -- let's make the previous question easier for the user !!!
SELECT * FROM countries
    WHERE UPPER(country_name) LIKE UPPER('&EnterLetter%');
/* Try it with UPPER and LOWER to see the effect compared to previous question.
JUST ANSWER YES if you tried it. */

/* 3) Calculate how many letters each country name has in it and list them from most letters 
to least letters */

SELECT COUNTRY_NAME "Country Name", LENGTH(COUNTRY_NAME) "Length"
FROM COUNTRIES
ORDER BY LENGTH(COUNTRY_NAME) DESC;

-- 4) Show the date 10 days before today (today is not hard coded but is supplied by the system)

SELECT SYSDATE-10 "10 Days Ago"
FROM DUAL;

-- 5) What date is the next Saturday from now

SELECT NEXT_DAY(SYSDATE, 'SATURDAY') "Next Saturday"
FROM DUAL;

/* 6) Display the difference between the Average pay and Lowest pay in the company. Name 
this result Salary Gap */

SELECT ROUND(AVG(SALARY)-MIN(SALARY),2) "Salary Gap"
FROM EMPLOYEES;

/* 7) Display the (1) department number and (2) Highest, (3) Lowest and (4)Average pay per 
each department. Do not label the columns .Round the average.
Sort the output so that the department with highest average salary is shown first. */

SELECT DEPARTMENT_ID, MAX(SALARY), MIN(SALARY), ROUND(AVG(SALARY),2)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY AVG(SALARY) DESC;

/* 8) Display how many people work the same job in the same department.
Name these headings results as .... No.,     Job,     How Many.
Include only jobs that involve more than one person.
Sort the output so that jobs with the most people involved are shown first. */

SELECT DEPARTMENT_ID, JOB_ID, COUNT(DEPARTMENT_ID)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING COUNT(DEPARTMENT_ID) > 1
ORDER BY COUNT(DEPARTMENT_ID) DESC;

/* 9) For each job title display the job title and total amount paid each month for this type 
of the job. Exclude titles AD_PRES and AD_VP and also include only jobs that require more 
than $15,000. 
Sort the output so that top paid jobs are shown first. */

SELECT JOB_ID "Job Title", ROUND(SUM(SALARY)/12,2) "Amount Paid Each Month"
FROM EMPLOYEES
WHERE NOT JOB_ID IN('AD_PRES', 'AD_VP')
GROUP BY JOB_ID
HAVING SUM(SALARY) > 15000
ORDER BY SUM(SALARY) DESC;

/* 10) For each department show the latest and earliest hire date, BUT
- exclude departments 10,  30 and 40
- also exclude those departments where the last person was hired in this century (2000 plus).
- Sort the output so that the most recent, meaning latest hire dates, are shown first. */

SELECT DEPARTMENT_ID, MAX(HIRE_DATE), MIN(HIRE_DATE)
FROM EMPLOYEES
WHERE NOT DEPARTMENT_ID IN(10,30,40)
GROUP BY DEPARTMENT_ID
HAVING MAX(HIRE_DATE) < '01-JAN-00'
ORDER BY MAX(HIRE_DATE) DESC;

-- 11) List all the countries and replace all letter "a"'s with "o"'s.

SELECT REPLACE(COUNTRY_NAME, 'a', 'o')
FROM COUNTRIES;

/* 12) For each manager number display how many persons he / she supervises. Exclude managers 
with numbers 100, 101 and 102 and also include only those managers that supervise more than 2 
persons.
Sort the output so that manager numbers with the most supervised persons are shown first.
This is often on a test or a question like it. */

SELECT MANAGER_ID "Manager ID", COUNT(EMPLOYEE_ID) "Supervises this many employees"
FROM EMPLOYEES
WHERE NOT MANAGER_ID IN(100,101,102)
GROUP BY MANAGER_ID
HAVING COUNT(EMPLOYEE_ID) > 2
ORDER BY COUNT(EMPLOYEE_ID) DESC;

/* 13) Select dept. ID, job and count of number employees as long as there are more than 2 
employees with that job in a department.
Sort by department then by job within department */

SELECT DEPARTMENT_ID, JOB_ID, COUNT(EMPLOYEE_ID)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING COUNT(EMPLOYEE_ID) > 2
ORDER BY DEPARTMENT_ID, JOB_ID;
