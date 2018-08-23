/* 2) Create this table called DIVISION
Follow these general rules in the process:
A. Create all CHECK,  NOT NULL)and UNIQUE as column level constraints
Constraint names needed for CHECK constraints. The other constraints (NN and UK) do not need a name.
B. Create all PK and FK constraints at the table level and give them proper constraint names that 
follow Oracle industry standard. */
CREATE TABLE DIVISION (
    DIVISION_ID        NUMBER(3),
    DIVISION_NAME    VARCHAR(25)        NOT NULL    UNIQUE,
CONSTRAINT DIVISION_DIVISION_ID_PK
PRIMARY KEY(DIVISION_ID));

-- 3) Insert the sample data shown for division
INSERT INTO DIVISION(DIVISION_ID, DIVISION_NAME)
VALUES(10, ‘East Coast’);
INSERT INTO DIVISION(DIVISION_ID, DIVISION_NAME)
VALUES(20, ‘Quebec’);
INSERT INTO DIVISION(DIVISION_ID, DIVISION_NAME)
VALUES(30, ‘Ontario’);

-- 4) Create this WAREHOUSE table using the same general rules as in the previous question
CREATE TABLE WAREHOUSE (
    WAREHOUSE_ID    NUMBER(3),
    CITY            VARCHAR(15)        NOT NULL    UNIQUE,
    RATING            CHAR(1),
CONSTRAINT WAREHOUSE_RATING_CK
    CHECK(RATING IN(‘A’,’B’,’C’,’D’)),
    FOUND_DATE        DATE            NOT NULL,
    DIVISION_ID        NUMBER(3)        NOT NULL,
CONSTRAINT WAREHOUSE_WAREHOUSE_ID_PK
    PRIMARY KEY(WAREHOUSE_ID),
CONSTRAINT WAREHOUSE_DIVISION_ID_FK
    FOREIGN_KEY(DIVISION_ID)
    REFERENCES DIVISION(DIVISION_ID));

-- 5) For the WAREHOUSE table insert the following sample data
INSERT INTO WAREHOUSE (WAREHOUSE_ID, CITY, RATING, FOUND_DATE, DIVISION_ID)
VALUES(1, ‘Montreal’, ‘A’, SYSDATE, 10);
INSERT INTO WAREHOUSE (WAREHOUSE_ID, CITY, RATING, FOUND_DATE, DIVISION_ID)
VALUES(7, ‘Fredericton’, SYSDATE, 10);
INSERT INTO WAREHOUSE (WAREHOUSE_ID, CITY, RATING, FOUND_DATE, DIVISION_ID)
VALUES(10, ‘Toronto’, ‘A’, SYSDATE, 30);

-- 6) Create table SECTION
CREATE TABLE SECTION (
    WAREHOUSE_ID
    SECTION_ID
    DESCRIPTION
    CAPACITY
CONSTRAINT SECTION_WH_ID_SECTION_ID_PK
    PRIMARY KEY(WAREHOUSE_ID, SECTION_ID),
CONSTRAINT SECTION_WAREHOUSE_ID_FK
    FOREIGN KEY(WAREHOUSE_ID)
    REFERENCES WAREHOUSE(WAREHOUSE_ID));

/* 7) After creating all tables add column MGR_ID to table SECTION as a FK column, that is related 
to the PK column EMPLOYEE_ID in table EMPLOYEE */
ALTER TABLE SECTION
    ADD MGR_ID NUMBER(3)
    ADD CONSTRAINT SECTION_MGR_ID_FK
    FOREIGN KEY(MGR_ID)
    REFERENCES EMPLOYEES(EMPLOYEE_ID);

/* 8) Modify the CHECK constraint on column RATING in table WAREHOUSE, so that it also may accept 
a new value G. */
ALTER TABLE WAREHOUSE
    DROP CONSTRAINT WAREHOUSE_RATING_CK;
ALTER TABLE WAREHOUSE
    ADD CONSTRAINT WAREHOUSE_RATING_CK
    CHECK(RATING IN(‘A’,’B’,’C’,’D’,’G’));

/* 9) Create a new Sequence called Whse_id_seq_2017 that will generate unique numbers for PK values
in table WAREHOUSE, so that the numbers start at 510 with the step of 10 and upper limit is 700 
and will have NO values stored in the memory. */
CREATE SEQUENCE “Whse_id_seq_2017”
    INCREMENT BY 10
    START WITH 510
    MAXVALUE 700
    NOCACHE
    NOCYCLE;

/* 10) Add new row to table WAREHOUSE by using this sequence for a city in Atlanta with B rating. 
You will assume today’s date as a foundation date. You cannot enter a specific date. 
**Insert record to DIVISION first as DIVISION_ID is FK of WAREHOUSE.
INSERT INTO DIVISION VALUES(10,'Europe'); */
INSERT INTO DIVISION VALUES(40, ‘Europe’);
INSERT INTO WAREHOUSE(WAREHOUSE_ID, CITY, RATING, FOUND_DATE, DIVISION_ID)
VALUES(“Whse_id_seq_2017”.NEXTVAL, ‘Atlanta’, ‘B’, SYSDATE, 40);

/* 11) Create table CITIES from table LOCATIONS, but only for location numbers less than 2000 (do 
NOT create this table from scratch).  à You will have 5 to 20 rows */
CREATE TABLE CITIES AS
  SELECT LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID
  FROM LOCATIONS
  WHERE LOCATION_ID < 2000;

-- 12) Issue command to show the structure of the table CITIE and show the output from the command
DESC CITIES;

-- 13) Issue the SELECT command on cities and show result here.
SELECT * FROM CITIES;

/* 14) Create a View called WhsSec_Man_view that will display for each Warehouse_id and Section_id,
the City, Division and manager’s Last_name. Alias for Last_name should be LName and for Division 
should be Group */
CREATE VIEW "WhsSec_Man_view" AS (
SELECT WAREHOUSE_ID, SECTION_ID, CITY, DIVISION_NAME "Group", LAST_NAME "LName"
FROM WAREHOUSE
JOIN SECTION
        USING(WAREHOUSE_ID)
      JOIN DIVISION
        USING (DIVISION_ID)
      JOIN EMPLOYEES
        ON MGR_ID = EMPLOYEE_ID);
        
-- 15) What is the SELECT command to issue to see if in 2 months time this view still exists.
SELECT * FROM "WhsSec_Man_view";

-- 16) If you want to modify the view what is the first line of the command
CREATE OR REPLACE VIEW "WhsSec_Man_view" (
