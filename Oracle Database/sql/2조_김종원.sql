/* 1. 특정 상점의 직원의 로그인과 로그아웃 횟수 기록 출력 
    ---------------------------------------------
      사원코드   사원명   로그인횟수   로그아웃 횟수
    ---------------------------------------------
*/

SELECT "EM".EM_CODE AS "EMCODE",
        "EM".EM_NAME AS "EMNAME",
        COALESCE(TEMP1.LOGINCNT, 0) AS "LOGINCNT",
        COALESCE(TEMP2.LOGOUTCNT, 0) AS "LOGOUTCNT"
FROM HI RIGHT OUTER JOIN "EM" ON HI.HI_EMSTCODE = "EM".EM_STCODE AND HI.HI_EMCODE = "EM".EM_CODE
        LEFT OUTER JOIN (SELECT "EM".EM_STCODE AS "STCODE",
                                "EM".EM_CODE AS "EMCODE",
                                COUNT(HI.HI_STATE) AS "LOGINCNT"
                        FROM HI RIGHT OUTER JOIN "EM" ON HI.HI_EMSTCODE = "EM".EM_STCODE AND HI.HI_EMCODE = "EM".EM_CODE
                        WHERE HI.HI_STATE = 1
                        GROUP BY "EM".EM_STCODE, "EM".EM_CODE, "EM".EM_NAME)TEMP1 ON "EM".EM_STCODE = TEMP1.STCODE AND "EM".EM_CODE = TEMP1.EMCODE
        LEFT OUTER JOIN (SELECT "EM".EM_STCODE AS "STCODE",
                                "EM".EM_CODE AS "EMCODE",
                                COUNT(HI.HI_STATE) AS "LOGOUTCNT"
                        FROM HI RIGHT OUTER JOIN "EM" ON HI.HI_EMSTCODE = "EM".EM_STCODE AND HI.HI_EMCODE = "EM".EM_CODE
                        WHERE HI.HI_STATE = -1
                        GROUP BY "EM".EM_STCODE, "EM".EM_CODE, "EM".EM_NAME)TEMP2 ON "EM".EM_STCODE = TEMP2.STCODE AND "EM".EM_CODE = TEMP2.EMCODE
WHERE "EM".EM_STCODE = 'S001'
GROUP BY "EM".EM_CODE, "EM".EM_NAME, COALESCE(TEMP1.LOGINCNT, 0), COALESCE(TEMP2.LOGOUTCNT, 0);

/* 2. 특정 상점의 모든 직원중 로그인 횟수가 가장 많은 직원의 정보 출력 
    ----------------------------------------
      사원코드   사원명   로그인횟수   사원등급
    ----------------------------------------
*/
SELECT "EM".EM_CODE AS "EMCODE",
        "EM".EM_NAME AS "EMNAME",
        COALESCE(TEMP1.LOGINCNT, 0) AS "LOGINCNT",
        "EM".EM_LEVEL AS "EMLEVEL"
FROM (SELECT "EM".EM_STCODE AS "STCODE",
             "EM".EM_CODE AS "EMCODE",
             COUNT(HI.HI_STATE) AS "LOGINCNT"
      FROM HI RIGHT OUTER JOIN "EM" ON HI.HI_EMSTCODE = "EM".EM_STCODE AND HI.HI_EMCODE = "EM".EM_CODE
      WHERE HI.HI_STATE = 1
      GROUP BY "EM".EM_STCODE, "EM".EM_CODE)TEMP1 RIGHT OUTER JOIN "EM" ON "EM".EM_CODE = TEMP1.EMCODE AND "EM".EM_STCODE = TEMP1.STCODE
WHERE ("EM".EM_STCODE, COALESCE(TEMP1.LOGINCNT, 0)) IN (SELECT "EM".EM_STCODE,
                                                                COALESCE(MAX(LOGINCNT), 0)
                                                        FROM (SELECT "EM".EM_STCODE AS "STCODE", 
                                                                    "EM".EM_CODE AS "EMCODE",
                                                                     COUNT(HI.HI_STATE) AS "LOGINCNT"
                                                              FROM HI RIGHT OUTER JOIN "EM" ON HI.HI_EMSTCODE = "EM".EM_STCODE AND HI.HI_EMCODE = "EM".EM_CODE
                                                              WHERE HI.HI_STATE = 1
                                                                GROUP BY "EM".EM_STCODE, "EM".EM_CODE)TEMP2 RIGHT OUTER JOIN "EM" ON TEMP2.STCODE = "EM".EM_STCODE AND TEMP2.EMCODE = "EM".EM_CODE
                                                         GROUP BY "EM".EM_STCODE) AND
        "EM".EM_STCODE = 'S003'
GROUP BY "EM".EM_STCODE, "EM".EM_CODE, "EM".EM_NAME, COALESCE(TEMP1.LOGINCNT, 0), "EM".EM_LEVEL;

/* 3. 특정 상점의 모든 직원을 대상으로 직원별 판매실적을 출력
    ----------------------------------------
      사원코드   사원명   주문건수    매출액
    ----------------------------------------
*/ 
SELECT TEMP2.EMCODE AS "EMCODE",
        TEMP2.EMNAME AS "EMNAME",
        SUM(TEMP2.ODCOUNT) AS "ODCOUNT",
        TO_CHAR(SUM(COALESCE(TEMP1.PRICE, 0)), '999,999,999') AS "PRICE"
FROM (SELECT OT.OT_ODCODE AS "ODCODE",
            SUM(OT.OT_QTY * GO.GO_PRICE) AS "PRICE"
        FROM OT INNER JOIN GO ON OT.OT_GOCODE = GO.GO_CODE
        GROUP BY OT.OT_ODCODE)TEMP1 RIGHT OUTER JOIN
    (SELECT OD.OD_CODE AS "ODCODE",
            "EM".EM_STCODE AS "STCODE",
            "EM".EM_CODE AS "EMCODE",
            "EM".EM_NAME AS "EMNAME",
            COUNT(OD.OD_CODE) AS "ODCOUNT"
        FROM OD RIGHT OUTER JOIN "EM" ON OD.OD_EMCODE = "EM".EM_CODE
        GROUP BY OD.OD_CODE, "EM".EM_STCODE, "EM".EM_CODE,"EM".EM_NAME)TEMP2 ON TEMP1.ODCODE = TEMP2.ODCODE
WHERE TEMP2.STCODE = 'S001'
GROUP BY TEMP2.EMCODE, TEMP2.EMNAME; 

/* 4. 모든 상품의 정보 출력
    --------------------------------------------
      상품코드   상품명   가격    재고     유통기한
    --------------------------------------------
*/ 

SELECT GO.GO_CODE AS "GOCODE",
        GO.GO_NAME AS "GONAME",
        GO.GO_PRICE AS "PRICE",
        SUM(COALESCE(SC.SC_STOCKS, 0)) AS "STOCK",
        COALESCE(TO_CHAR(SC.SC_EXPIRE, 'YYYYMMDD'), '00000000') AS "EXPIRE"
FROM SC RIGHT OUTER JOIN GO ON SC.SC_GOCODE = GO.GO_CODE
GROUP BY GO.GO_CODE, GO.GO_NAME, GO.GO_PRICE, COALESCE(TO_CHAR(SC.SC_EXPIRE, 'YYYYMMDD'), '00000000');
/* 5. 4의 결과중 판매가능한 상품정보를 출력
    --------------------------------------------
      상품코드   상품명   가격    재고     유통기한
    --------------------------------------------
*/ 
SELECT GO.GO_CODE AS "GOCODE",
        GO.GO_NAME AS "GONAME",
        GO.GO_PRICE AS "PRICE",
        SUM(COALESCE(SC.SC_STOCKS, 0)) AS "STOCK",
        COALESCE(TO_CHAR(SC.SC_EXPIRE, 'YYYYMMDD'), '00000000') AS "EXPIRE"
FROM SC RIGHT OUTER JOIN GO ON SC.SC_GOCODE = GO.GO_CODE
WHERE SC.SC_STOCKS > 0 AND SC.SC_EXPIRE >= SYSDATE
GROUP BY GO.GO_CODE, GO.GO_NAME, GO.GO_PRICE, COALESCE(TO_CHAR(SC.SC_EXPIRE, 'YYYYMMDD'), '00000000');