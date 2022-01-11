
--테이블 불러오기
SELECT*FROM EMP;

--테이블 부분 열 출력하기
SELECT column1, column2, column3 FROM EMP;
--실행 단축키 : Ctrl+enter

--Distinct 중복 데이터 삭제 
--이 경우 중복제거가 안됨
select distinct empno, deptno from emp; --13개

select distinct job, deptno from emp; --9개

--조건부 where
select*from emp
 where empno = 7499;

select*from emp
 where ename = '홍길동';
 
 select*from emp
 where job = 'CLERK';
 
 select*from emp
  where sal >= 1500;
