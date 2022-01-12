--행단위로 조회하는 셀렉션
SELECT*FROM emp
 WHERE sal = 5000; --emp테이블 전체에서 sal이 5000인 row 출력
 
SELECT*FROM emp
 WHERE job = 'CLERK'; --emp 테이블 전체에서 job이 CLERK인 row 출력
  
SELECT*FROM emp
 WHERE comm = 0 or comm is null; --comm = 0 또는 null인 row 출력
   
SELECT*FROM emp
 WHERE comm is null and job = 'ANALYST';  --comm이 NULL이고 직업이 ANALYST인 사람만 출력

--프로젝션    
SELECT empno, ename, deptno 
 from emp
 where deptno = 30; --emp테이블 내 empno, ename, deptno colmn을 선택. deptno = 30인 데이터 출력
 
--Join 두개 이상의 테이블을 하나의 테이블처럼 조회하는 방법
select*from emp
 JOIN dept                                --emp테이블에 dept테이블을 조인.
    ON emp.deptno = dept.deptno;  --emp내 deptno = dept내 deptno
    
--DISTINCT
Select distinct job from emp; --중복 제외한 job만 출력

--별칭 지정 as
 select ename, job, sal, sal*12 as ANNSAL
 from emp;
 
 --오름차순/내림차순
 Select ename, job, sal, sal*12 As ANNSAL
 From emp
 Order By job ASC , sal ASC;      --ASC : 오름차순 / DESC : 내림차순
 
 --Join + AS
select*from emp e -- AS 생략. (PL/SQL) 
 JOIN dept d
    ON e.deptno = d.deptno;  

--WHERE
select ename, job, sal, sal*12 ANNSAL
 from emp
 where not sal =1000; 
 
--In
select ename, job, sal, sal*12 ANNSAL
 from emp
 where sal in (800, 1600, 5000);
 
 --BETWEEN A and B
 select ename, job, sal, sal*12 ANNSAL
 from emp
 where sal between 1600 and 2975; --sal 값이 1600이상 2975이하인 값

--Like
--1)
select ename, job, sal, sal*12 ANNSAL
 from emp
 where ename like '_A_E_';
--2)
select ename, job, sal, sal*12 ANNSAL
 from emp
 where ename like 'J%E%';