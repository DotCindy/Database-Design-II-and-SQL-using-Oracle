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
