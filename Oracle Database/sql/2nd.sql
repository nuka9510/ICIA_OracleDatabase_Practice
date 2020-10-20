/*
DataBase Term
 - Relation = Table
 - Attribute = Field = Column = �Ӽ� --> �ϰ��� ������Ÿ�Ը� ���� ����
 - Tuple = Record = Row = �Ӽ����� ����
 - Domain : �Ӽ��� ���� �� �ִ� ���� ����
 - Cardinality : Tuple�� ��
 - Degree : Attribute�� ��
 - Relation Schema : �Ӽ��� �̸�
 - Relation Instance : Tuple�� ����

 - Key : Row�� �����ϱ� ���� �ϳ� �̻��� Column
   -- Primary Key : �� ���� Record���̿��� ���� ���ڵ���
                    ������ Ư���� ���� �ϴ� �ϳ� �̻��� �Ӽ�
                  : 1���� ���̺� 1���� PK�� ����
   -- Foreign Key : 1:N���踦 ���� �� ���� ���̺��� N�� �Ӽ��� ���� �ִ� ���̺��� 
                    Column Data�� �ݵ�� 1�� �Ӽ��� ���� ���̺��� Column Data��
                    ��ġ��Ŵ���ν� �� ���� ���̺��� ���迡�� Object Integrity�� 
                    Reference Integrity�� �����ϵ��� �Ѵ�.
                
                    
DataBase Normalization
   : �������� �ߺ����� ���� �̻�(Anomaly) ���� ����
   1. Insert Anomaly
      : ���ο� �����͸� �����ϱ� ���� ���ʿ��� �����͵� �Բ� �����ؾ� �ϴ� ����
   2. Update Anomaly
      : �ߺ� Ʃ�� �� �Ϻθ� �����Ͽ� �����Ͱ� ����ġ�ϰ� �Ǵ� ���� 
   3. Deletion Anomaly
      : �����͸� ������ ��� �����Ͱ� ���Ե� ���ڵ尡 �����ǹǷ� �������� ���ƾ� ��
        �����͵� �Բ� �����Ǵ� ����
*/
SELECT * FROM DBA_USERS;

/* 2020-10-19 User Creation 
    Syntax____
    CREATE USER [USER_NAME]
    IDENTIFIED BY "[PASSWORD]";
    
    PROCESS
     - USER CREATION
     - GRANT PRIVILEAGE
    EXEC
     1. LOCAL WORK
     2. LOCAL SHUTDOWN --> SERVER WORK
*/
CREATE USER HOONZZANG
IDENTIFIED BY "7777"; --> LACKS CREATE SESSION PRIVILEAGE 
-- DCL : GRANT[REVOKE] [PRIV_NAME | ROLE: ������ ����]
GRANT CREATE SESSION TO HOONZZANG;  -- CONNECT
REVOKE CREATE SESSION FROM HOONZZANG;

-- DROP USER
DROP USER HOONZZANG;

/* DBA ACCOUNT CREATION 
    SYS --> HOONZZANG :: 8888 :: DBA ROLE
   DEV ACCOUNT CREATION 
    DBA --> HOON :: 0000 :: CONNECT, RESOURCE ROLE
*/
-- DBA :: <- SYS
CREATE USER HOONZZANG
IDENTIFIED BY "8888";
GRANT DBA TO HOONZZANG;

-- DEV :: <-- DBA
CREATE USER HOON
IDENTIFIED BY "0000";
GRANT CONNECT, RESOURCE TO HOON;

-- USER CHECK
SELECT * FROM DBA_USERS;

-- DROP ANONYMOUS ACCOUNT
DROP USER ANONYMOUS;

-- ��ü ���� ��ȸ
SELECT * FROM USER_TAB_PRIVS;
SELECT * FROM USER_TAB_PRIVS_MADE;
SELECT * FROM USER_TAB_PRIVS_RECD;

-- ROLE�� �ο��� �ý��� || ��ü ����
SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'DBA';
SELECT * FROM ROLE_TAB_PRIVS WHERE ROLE = 'RESOURCE';
SELECT * FROM USER_ROLE_PRIVS;

/* USER CREATION
    SYN___
    CREATE USER [USER_NAME] IDENTIFIED BY "[PASSWORD]"
    *DEFAULT TABLESPACE [TBS_NAME]
    TEMPORATY TABLESPACE [TBS_NAME]
    *QUOTA [INTEGER M | UNLIMITED] ON [TBS_NAME];
*/

/* DBA :: USERS  :: UNLIMITED */
ALTER USER HOONZZANG
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

/* DEV :: USERS  :: UNLIMITED */
ALTER USER HOON
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

SELECT * FROM DBA_USERS;

/* ���̺� ���� �� �˾ƾ� �� ���� 
   0. PROCESS 
      ENTITY ���� --> ENTITY ��ġ --> ENTITY RELATIONSHIP
      
   1. ENTITY
      - KEY ENTITY
      - MAIN ENTITY
      - ACTION ENTITY
      - PRODUCTION ENTITY
   2. NORMALIZATION
   3. ATTRIBUTE
   4. IDENTIFIER
   5. RELATIONSHIP
   6. DOMAIN
*/

/* 2020-10-20 :: TABLE
    PROCESS
      1. CREATE :: ATTRIBUTES 
      2. CREATE :: TABLESPACE 
      3. ALTER  :: CONSTRAINTS
      4. CREATE :: SYNONYM  --> �����ָ� ��밡��
                :: PUBLIC SYNONYM --> ������ �Ӹ� �ƴ϶� ������ �ο����� ������ ���
                   --> DML���������� ��� ���� 
      5. GRANT  :: OBJECT PRIVILEGE
      
    SYNTAX____________
    CREATE TABLE [TAB_NAME](
      [COL_NAME]    [DATA-TYPE]     [PROPERTY],
          :              :               :    ,
      [COL_NAME]    [DATA-TYPE]     [PROPERTY],
      CONSTRAINT 
    )TABLESPACE [TBS_NAME];
*/
-- 1. DBA :: STORE TABLE(ST)
CREATE TABLE STORES(
 ST_CODE    NCHAR(4),
 ST_NAME    NVARCHAR2(100),
 ST_ADDR    NVARCHAR2(100)
)TABLESPACE USERS;

/* CONSTRAINTS 
    : Ư�� ���̺��� Ư�� �÷��� �Է� ���� �뵵
    1. PRIMARY KEY
       - �ϳ��� ���̺� �� ���� PK ���� ����
       - UNIQUE
       - NOT NULL
*/
-- ADD
ALTER TABLE STORES
ADD CONSTRAINT ST_CODE_PK  PRIMARY KEY(ST_CODE);
-- DROP
ALTER TABLE STORES
DROP CONSTRAINT ST_CODE_PK;

-- DATA INSERT
INSERT INTO STORES(ST_CODE, ST_NAME, ST_ADDR) 
VALUES('I001', '���̳׸���', '��õ�� ����Ȧ�� ���͵�');
INSERT INTO STORES(ST_CODE, ST_NAME, ST_ADDR) 
VALUES('I001', '���̳׸���', '��õ�� ����Ȧ�� ���͵�'); --> X
INSERT INTO STORES(ST_CODE, ST_NAME, ST_ADDR) 
VALUES( NULL, '���̳׸���', '��õ�� ����Ȧ�� ���͵�');  --> X

   /* ALTER �� Ȱ�� 
    SUB COMMAND :   ADD --> �÷� �߰�
                    ADD CONSTRAINT --> �������� �߰�
                    DROP COLUMN --> �÷� ����
                    DROP CONSTRAINT --> �������� ����
                    MODIFY  --> �÷� ����
   */
   -- �÷� ����(DATA TYPE, PROPERTY)
   ALTER TABLE STORES MODIFY ST_ADDR NOT NULL;
   -- �÷� ����
   ALTER TABLE STORES DROP COLUMN ST_ADDR;
   -- �÷� �߰�
   ALTER TABLE STORES ADD ST_ADDR  NVARCHAR2(100);
   -- -- �÷� ����(DATA TYPE, PROPERTY)
   UPDATE STORES SET ST_ADDR = '��õ������ ����Ȧ�� ���͵�' WHERE ST_CODE = 'I001';
   ALTER TABLE STORES MODIFY ST_ADDR NOT NULL;
   
/* SYNONYM
    : Ư�� ���̺��� ȣ�� �̸��� ��Ī���� ����
    : SYNONYM�� CREATE�� �������� ��� ����
    : DML����(INSERT, UPDATE, DELETE, SELECT)��� ����
    SYNTAX________
    CREATE SYNONYM [TAB_ALIAS] FOR [OBJECT]
*/
CREATE SYNONYM ST FOR HOONZZANG.STORES;
DROP SYNONYM ST;
SELECT * FROM ST;

/* OBJECT PRIVILEGE :: ��ü ������
    SYNTAX___________
    GRANT [OBJ_PRIV_NAME], ... , [OBJ_PRIV_NAME] ON [OBJECT] TO [SCHEMA]
*/
GRANT SELECT ON HOONZZANG.STORES TO HOON;
-- HOON��ȸ
SELECT * FROM HOONZZANG.STORES;

--> DBA : PUBLIC SYNONYM 
CREATE PUBLIC SYNONYM ST FOR HOONZZANG.STORES;
   --> HOON ���
   SELECT * FROM ST;
   
-- 2. DBA :: GOODS TABLE(GO)
CREATE TABLE GOODS(
 GO_CODE        NCHAR(4),
 GO_NAME        NVARCHAR2(50),
 GO_PRICE       NUMBER(7,0),
 GO_COMMENTS    NVARCHAR2(100)
)TABLESPACE USERS;

 -- PROPERTY
 ALTER TABLE GOODS
 MODIFY GO_NAME NOT NULL
 MODIFY GO_PRICE DEFAULT 0;
 
 -- 2-3. CONSTRAINTS 
 ALTER TABLE GOODS
 ADD CONSTRAINT GO_CODE_PK   PRIMARY KEY(GO_CODE);
 
 -- 2-4. SYNONYM
 CREATE PUBLIC SYNONYM GO FOR HOONZZANG.GOODS;
 
 -- 2-5. GRANT 
 GRANT INSERT, SELECT ON HOONZZANG.GOODS TO HOON;
 
 -- 2-6. TEST DATA  <-- DEV
 INSERT INTO GO(GO_CODE, GO_NAME, GO_PRICE, GO_COMMENTS) 
 VALUES('1001', '�����', 1500, '�Ϲ�');
 INSERT INTO GO(GO_CODE, GO_NAME, GO_PRICE, GO_COMMENTS) 
 VALUES('1002', '�����', 3000, '�뷡��');
 
 SELECT * FROM GO;
 
-- 3. DBA :: CUSTOMER TABLE(CM)
CREATE TABLE CUSTOMER(
 CM_CODE    NCHAR(5),
 CM_NAME    NVARCHAR2(5)
)TABLESPACE USERS;

 -- PROPERTY
 
 -- 3-3. CONSTRAINTS 
 ALTER TABLE CUSTOMER
 ADD CONSTRAINT CM_CODE_PK  PRIMARY KEY(CM_CODE);
 
 -- 3-4. SYNONYM
 CREATE PUBLIC SYNONYM CM FOR HOONZZANG.CUSTOMER;
 
 -- 3-5. GRANT
 GRANT INSERT,SELECT ON HOONZZANG.CUSTOMER TO HOON;
 
 -- 3-6. TEST DATA  <-- DEV
 INSERT INTO CM(CM_CODE, CM_NAME) VALUES('C0001', '�ٻ簡');
 INSERT INTO CM(CM_CODE, CM_NAME) VALUES('C0002', '������');
 INSERT INTO CM(CM_CODE, CM_NAME) VALUES('C0003', '�ǿԾ�');
 INSERT INTO CM(CM_CODE, CM_NAME) VALUES('C0000', '��ȸ��');
 
 SELECT * FROM CM;
 
 COMMIT;
 
 -- CM_PHONE ADD :: DBA
 ALTER TABLE CUSTOMER
 ADD CM_PHONE   NCHAR(11);
 -- CM_PHONE UNIQUE CONSTRAINT ADD  :: DBA
 ALTER TABLE CUSTOMER
 ADD CONSTRAINT CM_PHONE_UK     UNIQUE(CM_PHONE);
 
 GRANT UPDATE ON HOONZZANG.CUSTOMER TO HOON;
 -- TEST DATA :: DEV
 UPDATE CM SET CM_PHONE = '01056808050' WHERE CM_CODE = 'C0001';
 UPDATE CM SET CM_PHONE = '01056808050' WHERE CM_CODE = 'C0002';  --> X
 
 SELECT * FROM CM;
 
 
-- EMPOLYEES TABLE(EM) :: DBA
CREATE TABLE EMPLOYEES(
 EM_STCODE      NCHAR(4),
 EM_CODE        NCHAR(4),
 EM_PWD         NVARCHAR2(10),
 EM_NAME        NVARCHAR2(5)
)TABLESPACE USERS;

 -- PROPERTY
 ALTER TABLE EMPLOYEES
 MODIFY EM_PWD  NOT NULL
 MODIFY EM_NAME NOT NULL;
 
 -- CONSTRAINTS
 ALTER TABLE EMPLOYEES
 ADD CONSTRAINT EM_STCODE_CODE_PK PRIMARY KEY(EM_STCODE, EM_CODE)
 ADD CONSTRAINT EM_STCODE_FK    FOREIGN KEY(EM_STCODE) REFERENCES STORES(ST_CODE);
 
 -- SYNONYM
 CREATE PUBLIC SYNONYM "EM" FOR HOONZZANG.EMPLOYEES;
 
 -- GRANT 
 GRANT ALL ON HOONZZANG.EMPLOYEES TO HOON;
 
 -- TEST DATA :: DEV
 INSERT INTO "EM"(EM_STCODE, EM_CODE, EM_PWD, EM_NAME) 
 VALUES('I001', 'E001', '1234', '���Ⱦ�');
 INSERT INTO "EM"(EM_STCODE, EM_CODE, EM_PWD, EM_NAME) 
 VALUES('I002', 'E002', '1234', '���Ⱦ�');  --> X
 
 SELECT * FROM "EM";
 COMMIT;
 
-- CHECK
SELECT * FROM HOONZZANG.STORES;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_TAB_COLS WHERE TABLE_NAME = 'STORES';
SELECT * FROM USER_CONSTRAINTS;



































