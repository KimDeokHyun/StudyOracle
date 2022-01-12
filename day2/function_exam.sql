--문자열 함수

--대소문자
SELECT *FROM emp
where job = UPPER('analyst');

select upper('analyst') from dual;

SELECT lower(ename) ename,
          INITCAP(job) job
    from emp
    where comm is not null;

--LENGTH 길이
SELECT ename, LENGTH(ename) 글자수, LENGTHB(ename) 바이트수 
    From emp; 

--SUBSTRING (글자 자르기)
SELECT SUBSTR('안녕하세요. 한가람IT전문학원 빅데이터반입니다 ',18) Phase from dual;
 
 --REPLACE (글자대체)
SELECT REPLACE('안녕하세요. 한가람IT전문학원 빅데이터반입니다 ', '안녕하세요', '저리가세요') Phase from dual;

--CONCAT (두 문자열 데이터 합치기)
SELECT 'A' | | 'B' phase From dual;
SELECT CONCAT('A', 'B') phase FROM dual;

--TRIM (여백 삭제)
SELECT '     안녕하세요     ' from dual;
SELECT LTRIM('     안녕 하세요     ') Phase from dual;  -- 좌측 여백 삭제
SELECT RTRIM('     안녕 하세요     ') Phase from dual;  -- 우측 여백 삭제
SELECT TRIM('     안녕 하세요     ') Phase from dual;   -- 좌,우측 여백 삭제 단, 문자 사이 공백 삭제x

--ROUND (반올림)
SELECT ROUND(15.193, 1) from dual;

--SYSDATE
SELECT SYSDATE FROM DUAL;

--TO_CHAR
SELECT ename, hiredate, TO_CHAR(hiredate,'YYYY-MM-DD') 문자열,
          sal + TO_CHAR(sal) || '$' 단위추가 from  emp;
          
--TO_NUMBER
SELECT TO_NUMBER(REPLACE('2400$', '$', ' ')) + 100 단위생략 FROM dual;
select '2400' + 100 from dual;

--TO _DATE
SELECT TO_DATE('2022-01-12') 날짜 FROM dual;
SELECT TO_DATE('01/12/22', 'mm dd yy') 정렬 FROM dual;

--NVL
SELECT ename, job, sal , NVL(comm, 0) comm, (sal*12) + NVL(comm, 0) annsal 
    FROM emp
    ORDER BY sal DESC; 
    
--집계함수 (Sum, Count, Min, Max, Avg)
SELECT sal, NVL(comm, 0) comm FROM emp;
SELECT SUM(sal) totalsal FROM emp; 
SELECT SUM(comm) totalcom FROM emp; 

SELECT MAX(sal) FROM emp;
SELECT MIN(sal) FROM emp;
SELECT ROUND(AVG(sal),0) FROM emp;

--GROUP BY
SELECT MAX(sal) 월급최대, SUM(sal) 직업군당급여합계, job
 FROM emp
   GROUP BY job
    HAVING MAX(sal) >4000
     ORDER BY job ASC;
     
SELECT nvl(to_char(deptno),'종합') deptno, nvl(job,'합계') job,
 round(avg(sal),0) 급여평균, max(sal) 급여최대,
 sum(sal)급여합계, count(*) 그룹별직원수
 FROM emp
  group by rollup(deptno, job);  
