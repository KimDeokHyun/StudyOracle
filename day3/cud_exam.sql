--데이터 입력 INSERT
INSERT INTO BONUS
      ( ename
      , job
      , sal
      , comm)
VALUES
      ( 'JACK'
      , 'SALESMAN'
      , 4000
      , NULL) ;
      
--TEST 테이블 입력쿼리      
INSERT INTO TEST
    (idx, title, descs)
VALUES
    (1  ,'내용증명', NULL );
    
INSERT INTO TEST
    (idx, title, descs)
VALUES
    (2  ,'내용증명2', NULL );
    
    
INSERT INTO TEST
    (idx, title, descs, REGDATE)
VALUES
    (3  ,'내용증명3', NULL, SYSDATE );

INSERT INTO TEST
    (idx, title, descs, REGDATE)
VALUES
    (4  ,'내용증명4', NULL, to_date('2021-12-31','yyyy-mm-dd') ); 
    
--시퀀스
SELECT SEQ_TEST. CURRVAL FROM DUAL;
SELECT SEQ_TEST. NEXTVAL FROM DUAL;

INSERT INTO TEST
    (idx, title, descs, REGDATE)
VALUES
    (SEQ_TEST.NEXTVAL,'내용증명7', NULL, SYSDATE );
    
--UPDATE
UPDATE test
   SET title = '내용증명?'
     , descs = '내용 변경'
 WHERE IDX = 100;
 
--DELETE
 DELETE FROM test
  where idx = 101;
  
--SUB QUARY
SELECT ROWNUM, ENAME, JOB, SAL, COMM FROM(
  SELECT ENAME, JOB, SAL, COMM FROM EMP
ORDER BY SAL DESC)
WHERE ROWNUM<=1;

SELECT ROWNUM, IDX, TITLE FROM TEST