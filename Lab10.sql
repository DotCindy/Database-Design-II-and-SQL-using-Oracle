/* 1) Create table SALESREP and load it with data from table EMPLOYEES table. Use only the 
equivalent columns from EMPLOYEE as shown below. (Do NOT create this table from scratch),
è AND only for people in department 80. */
CREATE TABLE SALESREP AS
  SELECT EMPLOYEE_ID "RepId", FIRST_NAME "FName", LAST_NAME "LName"
    PHONE_NUMBER "Phone#", SALARY "Salary", COMMISSION_PCT "Commission"
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID = 80;

-- 2) a) Create CUST table.
CREATE TABLE CUST (
CUST#            NUMBER(6),
     CUSTNAME            VARCHAR2(30),
     CITY              VARCHAR2(20),
     RATING            CHAR(1),
     COMMENTS           VARCHAR2(200),
     SALESREP#           NUMBER(7)    );

INSERT INTO CUST VALUES (501, 'ABC LTD', 'Montreal', 'C', NULL, 201);
INSERT INTO CUST VALUES (502, ‘Black Giant’, ‘Ottawa’, ‘B’, NULL, 202);
INSERT INTO CUST VALUES (503, ‘Mother Goose’, ‘London’, ‘B’, NULL, 202);
INSERT INTO CUST VALUES (701, ‘BLUE SKY LTD’, ‘Vancouver’, ‘B’, NULL, 102);
INSERT INTO CUST VALUES (702, 'MIKE and SAM inc.', 'Kingston', 'A', NULL, 107);
INSERT INTO CUST VALUES (703, 'RED PLANET', 'Mississauga', 'C', NULL, 107);
INSERT INTO CUST VALUES (717, 'BLUE SKY LTD’, 'Regina', 'D', NULL, 102);

/* b) Create table GOODCUST from table CUST by using following columns (do NOT create this table
from scratch), but only if their rating is A or B. */
CREATE TABLE GOODCUST AS
  SELECT Cust# "CustId", CustName "Name", City "Location", SalesRep# "RepId"
  FROM CUST
  WHERE Rating IN('A', 'B');
  
/* 3) Now add new column to table SALESREP called JobCode  that will be of variable character type 
with maximum length of 12. Do a DESC SALESREP to ensure it executed */
ALTER TABLE SALESREP
  ADD "JobCode" VARCHAR2(12);

-- 4) Declare column Salary in table SALESREP as mandatory one and
-- Column Location in table GOODCUST as optional one. You can see location is already optional.
ALTER TABLE SALESREP
  MODIFY "Salary" NOT NULL;

-- 5) Lengthen FNAME in SALESREP to 37. The result of a DESCIBE should show it happening
ALTER TABLE SALESREP
MODIFY “FName” VARCHAR2(37);

/* You can only decrease the size or length of NAME in GOODCUST to the maximum length of data 
already stored. Do it by using SQL and not by looking at each entry and counting the characters */
SELECT MAX(LENGTH(“Name”))
    FROM GOODCUST
    WHERE LENGTH(“Name”) > ANY (SELECT LENGTH(“Name”)
                        FROM GOODCUST);
ALTER TABLE GOODCUST
    MODIFY “Name” VARCHAR(17);

/* 6) Now get rid of the column JobCode in table SALESREP in a way that will not affect 
daily performance. */
ALTER TABLE SALESREP
  SET UNUSED ("JobCode");

-- 7) Declare PK constraints in both new tables à RepId and CustId
ALTER TABLE SALESREP
  ADD CONSTRAINT SALESREP_PK PRIMARY KEY ("RepId");
ALTER TABLE GOODCUST
  ADD CONSTRAINT GOODCUST_PK PRIMARY KEY("CustId");

-- 8) Declare UK constraints in both new tables à Phone# and Name
ALTER TABLE GOODCUST
ADD CONSTRAINT GOODCUST_NAME_UK UNIQUE("Name");

-- [Error here in statement below]
ALTER TABLE SALESREP
  ADD CONSTRAINT SALES_PHONE#_UK UNIQUE("Phone#");

/* 9) Restrict amount of Salary column to be in the range [6000, 12000] and Commission to be 
not more than 50%. */
ALTER TABLE SALESREP
  ADD CONSTRAINT SALESREP_SALARY_CK CHECK(("Salary" BETWEEN 6000 AND 12000) AND "Commission" <= 0.50);

-- 10) RepId is a foreign key in the GOODCUST table


/* 11) Firstly write down the values for RepId column in table GOODCUST and then make all these 
values blank. Now redo the question 10. Was it successful? */
UPDATE GOODCUST
SET "RepId" = '';

/* 12) Disable this FK constraint now and enter old values for RepId in table GOODCUST and save 
them. Then try to enable your FK constraint. What happened? */
-- [Error constraint not found]
ALTER TABLE GOODCUST
DISABLE CONSTRAINT GOODCUST_REPID_FK;

UPDATE GOODCUST
SET "RepId" = 202
WHERE "CustId" = 502;

UPDATE GOODCUST
SET “RepId” = 202
WHERE “CustId” = 503;

UPDATE GOODCUST
SET “RepId” = 102
WHERE “CustId” = 701;

UPDATE GOODCUST
SET “RepId” = 107
WHERE “CustId” = 702;

ALTER TABLE GOODCUST
ENABLE CONSTRAINT GOODCUST_REPID_FK;
-- Failed because table has child records

/* 13) Get rid of this FK constraint. Then modify your CK constraint from question 9 to allow 
Salary amounts from 5000 to 15000. */
ALTER TABLE GOODCUST
DROP CONSTRAINT GOODCUST_REPID_FK;

ALTER TABLE SALESREP
DROP CONSTRAINT SALESREP_SALARY_CK;

ALTER TABLE SALESREP
ADD CONSTRAINT SALESREP_SALARY_CK
    CHECK((“Salary” BETWEEN 5000 AND 15000) AND (“Commission” < 0.5));

/* 14) Describe both new tables SALESREP and GOODCUST and then show all constraints
for these two tables by running the following query: */
DESC SALESREP;

DESC GOODCUST;
