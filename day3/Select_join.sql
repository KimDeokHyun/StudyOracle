--INNER JOIN
Select E.Empno
      , E.Ename
      , E.Job
      , To_Char(E.Hiredate,'yyyy-mm-dd') Hiredate
      , E.Deptno
      , d.dname
    From Emp e
    INNER Join dept d
    ON e.deptno = d.deptno
    WHERE e.job = 'SALESMAN';

--PL/SQL INNER JOIN
    
SELECT e.empno
      , e.ename
      , e.job
      , To_Char(E.Hiredate,'yyyy-mm-dd') Hiredate
      , d.deptno
      , d.dname
  From EMP e, DEPT d
  Where 1 = 1                --속도 up
    AND e.deptno = d.deptno;
 
--WHERE e.deptno = d.deptno (+) : LEFT OUTER JOIN
--WHERE e.deptno(+) = d.deptno  : RIGHT OUTER JOIN

--LEFT OUTER JOIN
Select E.Empno
      , E.Ename
      , E.Job
      , To_Char(E.Hiredate,'yyyy-mm-dd') Hiredate
      , E.Deptno
      , d.dname
    From Emp e
   LEFT OUTER Join dept d
    ON e.deptno = d.deptno;

--RIGHT OUTER JOIN
Select E.Empno
      , E.Ename
      , E.Job
      , To_Char(E.Hiredate,'yyyy-mm-dd') Hiredate
      , E.Deptno
      , d.dname
    From Emp e
   RIGHT OUTER Join dept d
    ON e.deptno = d.deptno;
    
--3중 테이블 조인
SELECT e.empno
      , e.ename
      , e.job
      , To_Char(E.Hiredate,'yyyy-mm-dd') Hiredate
      , d.deptno
      , d.dname
      , b.comm
  From EMP e, DEPT d, bonus b
  Where e.deptno(+) = d.deptno
    And e.ename = b.ename(+);