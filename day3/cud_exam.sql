--������ �Է� INSERT
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
      
--TEST ���̺� �Է�����      
INSERT INTO TEST
    (idx, title, descs)
VALUES
    (1  ,'��������', NULL );
    
INSERT INTO TEST
    (idx, title, descs)
VALUES
    (2  ,'��������2', NULL );
    
    
INSERT INTO TEST
    (idx, title, descs, REGDATE)
VALUES
    (3  ,'��������3', NULL, SYSDATE );

INSERT INTO TEST
    (idx, title, descs, REGDATE)
VALUES
    (4  ,'��������4', NULL, to_date('2021-12-31','yyyy-mm-dd') ); 
    
--������
SELECT SEQ_TEST. CURRVAL FROM DUAL;
SELECT SEQ_TEST. NEXTVAL FROM DUAL;

INSERT INTO TEST
    (idx, title, descs, REGDATE)
VALUES
    (SEQ_TEST.NEXTVAL,'��������7', NULL, SYSDATE );
    
--UPDATE
UPDATE test
   SET title = '��������?'
     , descs = '���� ����'
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