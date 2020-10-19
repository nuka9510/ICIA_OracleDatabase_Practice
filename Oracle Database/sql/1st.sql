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

-- USER CHECK
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
CREATE USER KJW
IDENTIFIED BY "7777"; --> LACKS CREATE SESSION PRIVILEAGE 
-- DCL : GRANT[REVOKE] [PRIV_NAME | ROLE: ������ ����]
GRANT CREATE SESSION TO KJW;  -- CONNECT

-- DROP USER
DROP USER KJW;

/* DBA ACCOUNT CREATION 
    SYS --> KJW :: 0000 :: DBA ROLE
   DEV ACCOUNT CREATION 
    DBA --> UKJW :: 7777 :: CONNECT, RESOURCE ROLE
*/

-- DBA :: <- SYS
CREATE USER KJW
IDENTIFIED BY "0000";
GRANT DBA TO KJW;

-- DEV :: <-- DBA
CREATE USER UKJW
IDENTIFIED BY "7777";
GRANT CONNECT, RESOURCE TO UKJW;

DROP USER ANONYMOUS;

-- ��ü ���� ��ȸ
SELECT * FROM USER_TAB_PRIVS;
SELECT * FROM USER_TAB_PRIVS_MADE;
SELECT * FROM USER_TAB_PRIVS_RECD;

-- ROLE�� �ο��� �ý��� || ��ü ����
SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'DBA';
SELECT * FROM ROLE_TAB_PRIVS WHERE ROLE = 'RESOURCE';
SELECT * FROM USER_ROLE_PRIVS;

CREATE USER ZERO
IDENTIFIED BY "1Q2W3E4R";
GRANT CONNECT, RESOURCE TO ZERO;

CREATE USER Re
IDENTIFIED BY "start";
GRANT CONNECT, RESOURCE TO Re;

CREATE USER RAM
IDENTIFIED BY "REM";
GRANT CONNECT, RESOURCE TO RAM;

/* USER CREATION
    SYN___
    CREATE USER [USER_NAME] IDENTIFIED BY "[PASSWORD]"
    *DEFAULT TABLESPACE [TBS_NAME]
    TEMPORATY TABLESPACE [TBS_NAME]
    *QUOTA [INTEGER M | UNLIMITED] ON [TBS_NAME];
*/

/* DBA :: USERS  :: UNLIMITED */
ALTER USER KJW
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

/* DEV :: USERS  :: UNLIMITED */
ALTER USER UKJW
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

ALTER USER ZERO
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

ALTER USER RAM
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

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
