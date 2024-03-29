-------------------------------------------------------------------------------
----CET341 ADVANCE DATABASE TECHNOLOGIES----
----DATABASE SCRIPT FOR SQL-----
---CREATED BY: AKASH DHITAL------
---STUDENT ID: 219305860--------
-------------------------------------------------------------------------------


-----------------------------------------------------------
----DROP TABLE-------
-----------------------------------------------------------
DROP TABLE ADVERTISEMENT;
/
DROP TABLE ADVERTISEMENT_MEDIA;
/
DROP TABLE VIEWS;
/
DROP TABLE LEASE_AGREEMENT;
/
DROP TABLE TENANT;
/
DROP TABLE PROPERTY;
/
DROP TABLE PROPERTY_OWNER;
/
DROP TABLE STAFF ;
/
DROP TABLE BRANCH;
/
DROP TABLE PROPERTY_OWNER_ObjType;
/
DROP TABLE LAND;
/


-------------------------------------------------------------
----DROP OBJECT-------
-------------------------------------------------------------
DROP TYPE PROPERTY_OWNER_TYPE FORCE;
/
DROP TYPE PRIVATE_OWNER FORCE;
/
DROP TYPE BUSINESS_OWNER FORCE;
/
DROP TYPE TENANT_TYPE FORCE;
/
DROP TYPE PRIVATE_TENANT FORCE;
/
DROP TYPE BUSINESS_TENANT FORCE;
/
DROP TYPE LANDTYPE FORCE;
/
DROP TYPE NESTEDPROPERTY_OWNER_TYPE FORCE;
/

-----------------------------------------------------------
-----CREATE TYPE-----
-----------------------------------------------------------
CREATE TYPE PROPERTY_OWNER_TYPE AS OBJECT ( 
 OWNER_NO CHAR(4), 
 STREET_NO CHAR(4), 
 STREET CHAR(10), 
 CITY CHAR(10), 
 PROVINCE CHAR(20), 
 POSTAL_CODE CHAR(6)
)NOT FINAL;
/


CREATE TYPE PRIVATE_OWNER UNDER PROPERTY_OWNER_TYPE(
FIRSTNAME CHAR(20),
LASTNAME CHAR(20) 
);
/

CREATE TYPE BUSINESS_OWNER UNDER PROPERTY_OWNER_TYPE(
BUSINESS_OWNER_NAME CHAR(20)
);
/

CREATE TYPE NESTEDPROPERTY_OWNER_TYPE AS TABLE OF REF PROPERTY_OWNER_TYPE;
/

CREATE TYPE LANDTYPE AS OBJECT
( LAND_ID  NUMBER(5),
LAND_REG_NO  CHAR(9),
IS_AVAILABLE CHAR(3),
CATEGORY NESTEDPROPERTY_OWNER_TYPE
);
/

CREATE TYPE TENANT_TYPE AS OBJECT(
TENANT_NO CHAR(4),
STREET_NO CHAR(4),
STREET CHAR(10),
PROVINCE CHAR(20),
POSTAL_CODE CHAR(6)
)NOT FINAL;
/


CREATE TYPE PRIVATE_TENANT UNDER TENANT_TYPE(
FIRSTNAME CHAR(20),
LASTNAME CHAR(20)
);
/

CREATE TYPE BUSINESS_TENANT UNDER TENANT_TYPE (
BUSINESS_NAME CHAR(20)
);
/



---------------------------------------------------------
----CREATING TABLE BRANCH------
---------------------------------------------------------
CREATE TABLE BRANCH ( 
 BRANCH_NO CHAR(10) NOT NULL, 
 STREET_NO CHAR(10) NOT NULL, 
 STREET CHAR(10) NOT NULL, 
 CITY CHAR(10) NOT NULL, 
 PROVINCE CHAR(20) NOT NULL, 
 POSTAL_CODE CHAR(6) NOT NULL, 
 BRANCH_MANAGER CHAR(10), 
 PRIMARY KEY (BRANCH_NO), 
 CHECK (PROVINCE IN ('BAGMATI','GANDAKI','SUDHURPASHCHIM','MADHESH','KARNALI','LUMBINI','PROVINCE_ONE')), 
 CHECK(REGEXP_LIKE(POSTAL_CODE,'[0-9][0-9][0-9]')),
 UNIQUE(BRANCH_MANAGER) 
 );
 /
---------------------------------------------------------------------
 ----INSERTATION OF DATA INTO BRANCH------
 --------------------------------------------------------------------
 INSERT INTO BRANCH(BRANCH_NO,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,BRANCH_MANAGER) 
VALUES('B0001','00001','JYATHA','KATHMANDU','BAGMATI','44600','SANDESH');
/
INSERT INTO BRANCH(BRANCH_NO,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,BRANCH_MANAGER) 
VALUES('B0002','00002','RAMSHAH','GORKHA','GANDAKI','34000','BIBEK');
/
INSERT INTO BRANCH(BRANCH_NO,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,BRANCH_MANAGER) 
VALUES('B0003','00003','HARIPUR','SARLAHI','MADHESH','45800','ANCHALA');
/
INSERT INTO BRANCH(BRANCH_NO,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,BRANCH_MANAGER) 
VALUES('B0004','00004','BIRENDRA','JUMLA','KARNALI','21200','ALEX');
/
INSERT INTO BRANCH(BRANCH_NO,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,BRANCH_MANAGER) 
VALUES('B0005','00005','BASANTAPUR','KATHMANDU','BAGMATI','44601','GAURAV');
/
INSERT INTO BRANCH(BRANCH_NO,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,BRANCH_MANAGER) 
VALUES('B0006','00006','THAPATHALI','KATHMANDU','BAGMATI','44652','KIRAN');
/
 
--------------------------------------------------------------------
-----CREATING TABLE STAFF-------
--------------------------------------------------------------------
CREATE TABLE STAFF ( 
 STAFF_NO CHAR(10) NOT NULL, 
 LAST_NAME CHAR(20) NOT NULL, 
 FIRST_NAME CHAR(10) NOT NULL, 
 MIDDLE_NAME CHAR(10), 
 STREET_NO CHAR(4) NOT NULL, 
 STREET CHAR(10) NOT NULL, 
 CITY CHAR(10) NOT NULL, 
 PROVINCE CHAR(20) NOT NULL, 
 POSTAL_CODE CHAR(6) NOT NULL, 
 SEX CHAR(1) NOT NULL, 
 SALARY DECIMAL(9,2) NOT NULL, 
 BRANCH_MANAGER CHAR(10) NOT NULL,
 BRANCH_NO CHAR(10) NOT NULL, 
 PRIMARY KEY (STAFF_NO), 
 FOREIGN KEY (BRANCH_NO) REFERENCES BRANCH,
  CHECK (PROVINCE IN ('BAGMATI','GANDAKI','SUDHURPASHCHIM','MADHESH','KARNALI','LUMBINI','PROVINCE_ONE')), 
 CHECK (SEX IN ('F','M','N')), 
 CHECK (SALARY > 0), 
 CHECK(REGEXP_LIKE(POSTAL_CODE,'[0-9][0-9][0-9]'))
);
/

------------------------------------------------------------------------------
------INSERTATION OF DATA INTO STAFF---------
------------------------------------------------------------------------------
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S001','SHARMA','SITA','DEVI','2011','JYATHA','KATHMANDU','BAGMATI','44600','F','5000.00','SANDESH','B0001');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S008','DHAKAL','ANISHA','KUMARI','0001','JYATHA','KATHMANDU','BAGMATI','44600','F','5000.00','SANDESH','B0001');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S002','POUDEL','SUJAN','NA','2020','RAMSHAH','GORKHA','GANDAKI','34000','M','7000.00','BIBEK','B0002');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S005','THAPA','ABIRAL','BAHADUR','2020','BASANTAPUR','KATHMANDU','BAGMATI','44601','F','20000.00','AELSON','B0002');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S009','ARYAL','PRASHANT','RAJ','2020','BASANTAPUR','KATHMANDU','BAGMATI','44601','M','20000.00','BIBEK','B0002');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S003','DONG','LOK','BAHADUR','1958','KALIKA','CHITWAN','BAGMATI','44800','F','10000.00','ANCHALA','B0003');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S007','SHRESTHA','MADAN','KRISHNA','1958','KALIKA','TANDI','BAGMATI','44800','M','50000.00','SUYOG','B0003');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S010','SHRESTHA','HARI','BAHADUR','1958','KALIKA','TANDI','BAGMATI','44800','M','50000.00','ANCHALA','B0003');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S011','AMAGAI','SUNIL','PRASAD','1958','BIRENDRA','JUMLA','KARNALI','44800','M','60000.00','ALEX','B0004');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S012','DANGOL','BALEN','BISHNU','1958','BIRENDRA','JUMLA','KARNALI','44800','M','70000.00','ALEX','B0004');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME, FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S013','KC','ARJUN','NARSINGH','1958','BIRENDRA','JUMLA','KARNALI','44800','M','70000.00','ALEX','B0004');
/
INSERT INTO STAFF(STAFF_NO, LAST_NAME,FIRST_NAME,MIDDLE_NAME,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,SEX,SALARY,BRANCH_MANAGER,BRANCH_NO)
VALUES('S004','MOTHOMELA','BOINEELO','LIFTUS','1955','BLOCK9','NAWALPUR','BAGMATI','44821','M','1000.00','ALEX','B0003');
/

---------------------------------------------------------------------
----CREATING A OBJECT TYPE----
---------------------------------------------------------------------
CREATE TABLE PROPERTY_OWNER OF PROPERTY_OWNER_TYPE(
OWNER_NO NOT NULL,
PRIMARY KEY (OWNER_NO), 
CHECK (PROVINCE IN ('BAGMATI','GANDAKI','SUDHURPASHCHIM','MADHESH','KARNALI','LUMBINI','PROVINCE_ONE')),  
CHECK(REGEXP_LIKE(POSTAL_CODE,'[0-9][0-9][0-9]'))
);
/

-------------------------------------------------------------------
----DATA INSERTTATION----
-------------------------------------------------------------------
INSERT INTO PROPERTY_OWNER 
VALUES(PRIVATE_OWNER('O001','S001','RAMSHAH','GORKHA','GANDAKI','34000','SANDESH','PANTA'));
/
INSERT INTO PROPERTY_OWNER 
VALUES(PRIVATE_OWNER('O002','S010','BLOCK9','NAWALPUR','BAGMATI','44526','DONG','LOK'));
/
INSERT INTO PROPERTY_OWNER 
VALUES(PRIVATE_OWNER('O003','S020','CHAKRAPATH','DOLAKHA','SUDHURPASHCHIM','44341','BIKASH','GIRI'));
/
INSERT INTO PROPERTY_OWNER 
VALUES(PRIVATE_OWNER('O011','S005','CHAKRAPATH','DOLAKHA','SUDHURPASHCHIM','44341','HARI','THAPA'));
/
INSERT INTO PROPERTY_OWNER 
VALUES(BUSINESS_OWNER('O004','S120','BYPASS','BHARATPUR','BAGMATI','44371','DBLCARE'));
/
INSERT INTO PROPERTY_OWNER 
VALUES(BUSINESS_OWNER('O005','S130','GATE','DHANKUTA','SUDHURPASHCHIM','44371','HAEL MINE'));
/
INSERT INTO PROPERTY_OWNER 
VALUES(BUSINESS_OWNER('O006','S140','HARINATH','BHAKTAPUR','BAGMATI','44351','RG INDUSTRIES'));
/
--------------------------------------------------------------------
----CREATING TABLE PROPERTY------
--------------------------------------------------------------------
CREATE TABLE PROPERTY ( 
 PROPERTY_NO CHAR(4) NOT NULL, 
 OWNER_NO CHAR(4) NOT NULL, 
 STREET_NO CHAR(4) NOT NULL, 
 STREET CHAR(10) NOT NULL, 
 CITY CHAR(10) NOT NULL, 
 PROVINCE CHAR(20) NOT NULL, 
 POSTAL_CODE CHAR(6) NOT NULL,
 PROPERTY_TYPE CHAR (10), 
 PRIMARY KEY (PROPERTY_NO), 
 FOREIGN KEY (OWNER_NO) REFERENCES PROPERTY_OWNER, 
CHECK (PROVINCE IN ('BAGMATI','GANDAKI','SUDHURPASHCHIM','MADHESH','KARNALI','LUMBINI','PROVINCE_ONE')),   
 CHECK(REGEXP_LIKE(POSTAL_CODE,'[0-9][0-9][0-9]'))
);
/
---------------------------------------------------------------------
-------DATA INSERTATION INTO PROPERTY----------
---------------------------------------------------------------------
INSERT INTO PROPERTY(PROPERTY_NO, OWNER_NO, STREET_NO,STREET , CITY, PROVINCE , POSTAL_CODE,PROPERTY_TYPE)
VALUES('P001','O001','2000','SNOW','HUMLA','KARNALI','44333','COMMERCIAL' );
/
INSERT INTO PROPERTY(PROPERTY_NO, OWNER_NO, STREET_NO,STREET , CITY, PROVINCE , POSTAL_CODE,PROPERTY_TYPE)
VALUES('P008','O011','2000','SNOW','HUMLA','KARNALI','44333','COMMERCIAL' );
/
INSERT INTO PROPERTY(PROPERTY_NO, OWNER_NO, STREET_NO,STREET , CITY, PROVINCE , POSTAL_CODE,PROPERTY_TYPE)
VALUES('P002','O001','2001','JANAKPUR','BARA','KARNALI','44833','RESIDENT' );
/
INSERT INTO PROPERTY(PROPERTY_NO, OWNER_NO, STREET_NO,STREET , CITY, PROVINCE , POSTAL_CODE,PROPERTY_TYPE)
VALUES('P003','O005','1830','KALI','NUWAKOT','BAGMATI','DFR558','COMMERCIAL');
/
INSERT INTO PROPERTY(PROPERTY_NO, OWNER_NO, STREET_NO,STREET , CITY, PROVINCE , POSTAL_CODE,PROPERTY_TYPE)
VALUES('P004','O003','1825','SNOW','HUMLA','KARNALI','44330','RESIDENT');
/
INSERT INTO PROPERTY(PROPERTY_NO,OWNER_NO,STREET_NO,STREET,CITY,PROVINCE,POSTAL_CODE,PROPERTY_TYPE)
VALUES('P005','O001','2011','BLOCK9','NAWALPUR','BAGMATI','44123','COMMERCIAL');
/
INSERT INTO PROPERTY(PROPERTY_NO, OWNER_NO, STREET_NO,STREET , CITY, PROVINCE , POSTAL_CODE,PROPERTY_TYPE)
VALUES('P006','O005','1830','RIO','GULMI','KARNALI','44558','COMMERCIAL');
/
INSERT INTO PROPERTY(PROPERTY_NO, OWNER_NO, STREET_NO,STREET , CITY, PROVINCE , POSTAL_CODE,PROPERTY_TYPE)
VALUES('P007','O005','1830','RIO','GULMI','KARNALI','44558','COMMERCIAL');
/

--------------------------------------------------------------------------
---------CREATING PROPERTY_OWNER_objType Table--------
--------------------------------------------------------------------------

CREATE TABLE PROPERTY_OWNER_ObjType of PROPERTY_OWNER_TYPE(
OWNER_NO NOT NULL,
PRIMARY KEY (OWNER_NO), 
CHECK (PROVINCE IN ('BAGMATI','GANDAKI','SUDHURPASHCHIM','MADHESH','KARNALI','LUMBINI','PROVINCE_ONE')),  
CHECK(REGEXP_LIKE(POSTAL_CODE,'[0-9][0-9][0-9]'))
);
/
insert into PROPERTY_OWNER_ObjType values (PROPERTY_OWNER_TYPE('O006','S140','HARINATH','BHAKTAPUR','BAGMATI','44351'));
/
insert into PROPERTY_OWNER_ObjType values (PRIVATE_OWNER('O014','S050','CHAKRAPATH','DOLAKHA','SUDHURPASHCHIM','44341','HARI','THAPA'));
/
insert into PROPERTY_OWNER_ObjType values (BUSINESS_OWNER('O015' ,'S140','HARINATH','BHAKTAPUR','BAGMATI','44351','RG INDUSTRIES'));
/


--------------------------------------------------------------------------
------------------CREATING TABLE LAND-------------
--------------------------------------------------------------------------
CREATE TABLE LAND OF LANDTYPE
(
LAND_ID PRIMARY KEY,
LAND_REG_NO UNIQUE
)
NESTED TABLE category STORE AS
 NESTEDPROPERTY_OWNERTABLE;
 /
 
 INSERT INTO LAND VALUES
(1, 'BA1KA4001', 'A', NESTEDPROPERTY_OWNER_TYPE());
/

INSERT INTO TABLE
(
 SELECT LD.category
 FROM LAND LD
 WHERE LD.LAND_ID = 1)
VALUES ((select ref(PT) from PROPERTY_OWNER_ObjType PT where OWNER_NO='0006'));
/

------------------------------------------------------------------------
------CREATING A OBJECT TYPE TABLE------
------------------------------------------------------------------------
CREATE TABLE TENANT OF TENANT_TYPE(
TENANT_NO NOT NULL,
PRIMARY KEY (TENANT_NO), 
CHECK (PROVINCE IN ('BAGMATI','GANDAKI','SUDHURPASHCHIM','MADHESH','KARNALI','LUMBINI','PROVINCE_ONE')),    
CHECK(REGEXP_LIKE(POSTAL_CODE,'[0-9][0-9][0-9]'))
);
/

--------------------------------------------------------------------------
-------DATA INSERTATION---------
--------------------------------------------------------------------------
INSERT INTO TENANT
VALUES(PRIVATE_TENANT('T001','S001','RAMSHAH','GANDAKI','44123','SANDESH','PANTA'));
/
INSERT INTO TENANT 
VALUES(PRIVATE_TENANT('T002','S002','RAMSHAH','GANDAKI','44123','SITA','SHARMA'));
/
INSERT INTO TENANT 
VALUES(PRIVATE_TENANT('T007','S005','RAMSHAH','GANDAKI','44123','HARI','THAPA'));
/
INSERT INTO TENANT 
VALUES(PRIVATE_TENANT('T003','S003','JYATHA','BAGMATI','44111','BINO','PHIRI'));
/
INSERT INTO TENANT 
VALUES(BUSINESS_TENANT('T004','S004','RAMSHAH','GANDAKI','AEC143','TULEK'));
/
INSERT INTO TENANT 
VALUES(BUSINESS_TENANT('T004','S005','RAMSHAH','GANDAKI','44103','TULEK'));
/
INSERT INTO TENANT VALUES(BUSINESS_TENANT('T008','S002','BASANTAPUR','BAGMATI','44143','COSMETIC'));
/

----------------------------------------------------------------
-------CREATING TABLE LEASE_AGREEMENT---------
----------------------------------------------------------------
CREATE TABLE LEASE_AGREEMENT ( 
 LEASE_AGREEMENT_ID CHAR(4) NOT NULL,
 PROPERTY_NO CHAR(4) NOT NULL, 
 TENANT_NO CHAR(4) NOT NULL,
 SIGNING_DATE TIMESTAMP,
 STARTING_DATE TIMESTAMP,
 ENDING_DATE TIMESTAMP, 
 PRIMARY KEY (LEASE_AGREEMENT_ID), 
 FOREIGN KEY (PROPERTY_NO) REFERENCES PROPERTY, 
 FOREIGN KEY (TENANT_NO) REFERENCES TENANT, 
 PERIOD FOR LEASE_HIST_TIME(STARTING_DATE,ENDING_DATE)
 );
/

-------------------------------------------------------------------
-------DATA INSERTATION INTO LEASE_AGREEMENT----------
-------------------------------------------------------------------
INSERT INTO LEASE_AGREEMENT( LEASE_AGREEMENT_ID,PROPERTY_NO,TENANT_NO,SIGNING_DATE,STARTING_DATE ,ENDING_DATE)
VALUES('LA01','P001','T001','20/FEB/2020','20/FEB/2020','20/FEB/2021');
/
INSERT INTO LEASE_AGREEMENT( LEASE_AGREEMENT_ID,PROPERTY_NO,TENANT_NO,SIGNING_DATE,STARTING_DATE ,ENDING_DATE)
VALUES('LA02','P002','T002','20/MARCH/2020','20/MARCH/2020','20/MARCH/2021');
/
INSERT INTO LEASE_AGREEMENT( LEASE_AGREEMENT_ID,PROPERTY_NO,TENANT_NO,SIGNING_DATE,STARTING_DATE ,ENDING_DATE)
VALUES('LA03','P003','T003','20/APRIL/2020','20/APRIL/2020','20/APRIL/2021');
/
INSERT INTO LEASE_AGREEMENT( LEASE_AGREEMENT_ID,PROPERTY_NO,TENANT_NO,SIGNING_DATE,STARTING_DATE ,ENDING_DATE)
VALUES('LA0','P004','T004','20/APRIL/2020','20/APRIL/2020','20/APRIL/2021');
/
INSERT INTO LEASE_AGREEMENT( LEASE_AGREEMENT_ID,PROPERTY_NO,TENANT_NO,SIGNING_DATE,STARTING_DATE ,ENDING_DATE)
VALUES('LA05','P005','T005','20/APRIL/2020','20/APRIL/2020','20/APRIL/2021');
/
INSERT INTO LEASE_AGREEMENT( LEASE_AGREEMENT_ID,PROPERTY_NO,TENANT_NO,SIGNING_DATE,STARTING_DATE ,ENDING_DATE)
VALUES('LA06','P008','T007','20/APRIL/2022','20/APRIL/2022','20/APRIL/2023');
/
INSERT INTO LEASE_AGREEMENT( LEASE_AGREEMENT_ID,PROPERTY_NO,TENANT_NO,SIGNING_DATE,STARTING_DATE ,ENDING_DATE)
VALUES('LA07','P006','T006','22/MAY/2022','22/MAY/2022','22/DECEMBER/2022');
/
INSERT INTO LEASE_AGREEMENT( LEASE_AGREEMENT_ID,PROPERTY_NO,TENANT_NO,SIGNING_DATE,STARTING_DATE ,ENDING_DATE)
VALUES('LA08','P007','T008','18/JUNE/2022','18/MAY/2022','18/DECEMBER/2022');
/

---------------------------------------------------------------------
--------CREATING TABLE VIEW----------
---------------------------------------------------------------------
CREATE TABLE VIEWS ( 
 PROPERTY_NO CHAR(4) NOT NULL, 
 TENANT_NO CHAR(4) NOT NULL, 
 VIEWING_DATE DATE NOT NULL, 
 PRIMARY KEY (PROPERTY_NO,TENANT_NO), 
 FOREIGN KEY (PROPERTY_NO) REFERENCES PROPERTY, 
 FOREIGN KEY (TENANT_NO) REFERENCES TENANT
);
/

---------------------------------------------------------------------
------DATA INSERTATION INTO VIEWS---------
---------------------------------------------------------------------
INSERT INTO VIEWS(PROPERTY_NO,TENANT_NO,VIEWING_DATE)VALUES('P001','T001','20/FEB/2020');
/
INSERT INTO VIEWS(PROPERTY_NO,TENANT_NO,VIEWING_DATE)VALUES('P002','T002','20/MARCH/2020');
/
INSERT INTO VIEWS(PROPERTY_NO,TENANT_NO,VIEWING_DATE)VALUES('P003','T003','20/APRIL/2020');
/
INSERT INTO VIEWS(PROPERTY_NO,TENANT_NO,VIEWING_DATE)VALUES('P004','T004','20/MAY/2020');
/
INSERT INTO VIEWS(PROPERTY_NO,TENANT_NO,VIEWING_DATE)VALUES('P005','T005','30/APRIL/2020');
/

---------------------------------------------------------------------------
------CREATE TABLE ADVERTISEMENT-------
---------------------------------------------------------------------------
CREATE TABLE ADVERTISEMENT_MEDIA ( 
 MEDIA_NAME CHAR(20) NOT NULL, 
 PRIMARY KEY (MEDIA_NAME) 
);
/
---------------------------------------------------------------------------
--------DATA INSERTATION INTO ADVERTISEMENT_MEDIA----------
---------------------------------------------------------------------------
INSERT INTO ADVERTISEMENT_MEDIA(MEDIA_NAME)VALUES('TWITTER');
/
INSERT INTO ADVERTISEMENT_MEDIA(MEDIA_NAME)VALUES('INSTAGRAM');
/
INSERT INTO ADVERTISEMENT_MEDIA(MEDIA_NAME)VALUES('FACEBOOK');
/
INSERT INTO ADVERTISEMENT_MEDIA(MEDIA_NAME)VALUES('TELEGRAM');
/
INSERT INTO ADVERTISEMENT_MEDIA(MEDIA_NAME)VALUES('YOUTUBE');

--------------------------------------------------------------------------
-------CREATING TABLE ADVERTISEMENT----------
--------------------------------------------------------------------------
CREATE TABLE ADVERTISEMENT ( 
 ADVERTISEMENT_NO CHAR(4) NOT NULL, 
 MEDIA_NAME CHAR(20) NOT NULL, 
 ADVERTISEMENT_DATE DATE NOT NULL, 
 PROPERTY_NO CHAR(4) NOT NULL, 
 PRIMARY KEY (MEDIA_NAME,ADVERTISEMENT_NO), 
 FOREIGN KEY (MEDIA_NAME) REFERENCES ADVERTISEMENT_MEDIA, 
 FOREIGN KEY (PROPERTY_NO) REFERENCES PROPERTY
);
/
--------------------------------------------------------------------------
-------DATA INSERTATION INTO ADVERTISEMENT----------
--------------------------------------------------------------------------
INSERT INTO ADVERTISEMENT(ADVERTISEMENT_NO,MEDIA_NAME, ADVERTISEMENT_DATE ,PROPERTY_NO)VALUES('A001','INSTAGRAM','20/FEB/2020','P001');
/
INSERT INTO ADVERTISEMENT(ADVERTISEMENT_NO,MEDIA_NAME, ADVERTISEMENT_DATE ,PROPERTY_NO)VALUES('A002','TELEGRAM','20/MARCH/2020','P002');
/
INSERT INTO ADVERTISEMENT(ADVERTISEMENT_NO,MEDIA_NAME, ADVERTISEMENT_DATE ,PROPERTY_NO)VALUES('A003','TWITTER','20/APRIL/2020','P003');
/
INSERT INTO ADVERTISEMENT(ADVERTISEMENT_NO,MEDIA_NAME, ADVERTISEMENT_DATE ,PROPERTY_NO)VALUES('A004','FACEBOOK','20/APRIL/2020','P004');
/
INSERT INTO ADVERTISEMENT(ADVERTISEMENT_NO,MEDIA_NAME, ADVERTISEMENT_DATE ,PROPERTY_NO)VALUES('A005','YOUTUBE','20/MAY/2020','P005');
/


-----------------------------------------------------------------------------
-------------JOINING TABLE USING INNER JOIN---------------
-----------------------------------------------------------------------------
SELECT T.TENANT_NO,TREAT(VALUE(T) AS PRIVATE_TENANT).FIRSTNAME 
FIRSTNAME,TREAT(VALUE(T) AS PRIVATE_TENANT).LASTNAME 
LASTNAME,TREAT(VALUE(T) AS BUSINESS_TENANT).BUSINESS_NAME
BUSINESS_NAME,LEASE_AGREEMENT_ID,P.PROPERTY_NO,P.PROPERTY_TYPE,SIGNING_DATE,
STARTING_DATE,ENDING_DATE
FROM TENANT T
INNER JOIN LEASE_AGREEMENT L
ON T.TENANT_NO = L.TENANT_NO
INNER JOIN PROPERTY P
ON P.PROPERTY_NO = L.PROPERTY_NO;
/

----------------------------------------------------------------------------
-------------TASK 4B-------------
----------NESTED-------------
-----------------------------------------------------------------------------
SELECT p.OWNER_NO, TREAT(VALUE(p) AS BUSINESS_OWNER).BUSINESS_OWNER_NAME,CITY
FROM PROPERTY_OWNER_ObjType p 
WHERE VALUE(p) IS OF (BUSINESS_OWNER);
/
---------------------------------------------------------------------------
-------TEMPORAL FEATURES-------
---------------------------------------------------------------------------


SELECT TENANT_NO, PROPERTY_NO, LEASE_AGREEMENT_ID,SIGNING_DATE,STARTING_DATE,ENDING_DATE
FROM LEASE_AGREEMENT
VERSIONS PERIOD FOR LEASE_HIST_TIME BETWEEN TRUNC(SYSDATE)-35 AND TRUNC(SYSDATE);
-----------------------------------------------------------------------------
---------ROLLUP------------
-----------------------------------------------------------------------------
/
SELECT STAFF_NO,BRANCH_NO, SUM(SALARY) AS TOTAL_SALARY
FROM STAFF
GROUP BY ROLLUP(STAFF_NO, BRANCH_NO)
ORDER BY STAFF_NO, BRANCH_NO;
/
----------------------------------------------------------------------------
-----------CUBE------------------
----------------------------------------------------------------------------
SELECT STAFF_NO, SUM(SALARY) AS TOTAL_SALARY
FROM STAFF
GROUP BY CUBE(STAFF_NO)
ORDER BY STAFF_NO;
/
----------------------------------------------------------
------MAX------
---------------------------------------------------------
SELECT S.STAFF_NO,S.FIRST_NAME,S.MIDDLE_NAME, S.LAST_NAME, S.CITY,S.SALARY,S.BRANCH_NO
FROM STAFF S
WHERE S.SALARY IN(SELECT MAX(S1.SALARY)FROM STAFF S1
WHERE S.BRANCH_NO= S1.BRANCH_NO)
ORDER BY S.STAFF_NO DESC;
/
--------------------------------------------------------------------------------------------------------------------
--------------------------------------END OF SCRIPT-----------------------------------------------------------------
---------------------------------------THANK YOU--------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------



