--���ڿ� �Լ�

--��ҹ���
SELECT *FROM emp
where job = UPPER('analyst');

select upper('analyst') from dual;

SELECT lower(ename) ename,
          INITCAP(job) job
    from emp
    where comm is not null;

--LENGTH ����
SELECT ename, LENGTH(ename) ���ڼ�, LENGTHB(ename) ����Ʈ�� 
    From emp; 

--SUBSTRING (���� �ڸ���)
SELECT SUBSTR('�ȳ��ϼ���. �Ѱ���IT�����п� �����͹��Դϴ� ',18) Phase from dual;
 
 --REPLACE (���ڴ�ü)
SELECT REPLACE('�ȳ��ϼ���. �Ѱ���IT�����п� �����͹��Դϴ� ', '�ȳ��ϼ���', '����������') Phase from dual;

--CONCAT (�� ���ڿ� ������ ��ġ��)
SELECT 'A' | | 'B' phase From dual;
SELECT CONCAT('A', 'B') phase FROM dual;

--TRIM (���� ����)
SELECT '     �ȳ��ϼ���     ' from dual;
SELECT LTRIM('     �ȳ� �ϼ���     ') Phase from dual;  -- ���� ���� ����
SELECT RTRIM('     �ȳ� �ϼ���     ') Phase from dual;  -- ���� ���� ����
SELECT TRIM('     �ȳ� �ϼ���     ') Phase from dual;   -- ��,���� ���� ���� ��, ���� ���� ���� ����x

--ROUND (�ݿø�)
SELECT ROUND(15.193, 1) from dual;

--SYSDATE
SELECT SYSDATE FROM DUAL;

--TO_CHAR
SELECT ename, hiredate, TO_CHAR(hiredate,'YYYY-MM-DD') ���ڿ�,
          sal + TO_CHAR(sal) || '$' �����߰� from  emp;
          
--TO_NUMBER
SELECT TO_NUMBER(REPLACE('2400$', '$', ' ')) + 100 �������� FROM dual;
select '2400' + 100 from dual;

--TO _DATE
SELECT TO_DATE('2022-01-12') ��¥ FROM dual;
SELECT TO_DATE('01/12/22', 'mm dd yy') ���� FROM dual;

--NVL
SELECT ename, job, sal , NVL(comm, 0) comm, (sal*12) + NVL(comm, 0) annsal 
    FROM emp
    ORDER BY sal DESC; 
    
--�����Լ� (Sum, Count, Min, Max, Avg)
SELECT sal, NVL(comm, 0) comm FROM emp;
SELECT SUM(sal) totalsal FROM emp; 
SELECT SUM(comm) totalcom FROM emp; 

SELECT MAX(sal) FROM emp;
SELECT MIN(sal) FROM emp;
SELECT ROUND(AVG(sal),0) FROM emp;

--GROUP BY
SELECT MAX(sal) �����ִ�, SUM(sal) ��������޿��հ�, job
 FROM emp
   GROUP BY job
    HAVING MAX(sal) >4000
     ORDER BY job ASC;
     
SELECT nvl(to_char(deptno),'����') deptno, nvl(job,'�հ�') job,
 round(avg(sal),0) �޿����, max(sal) �޿��ִ�,
 sum(sal)�޿��հ�, count(*) �׷캰������
 FROM emp
  group by rollup(deptno, job);  
