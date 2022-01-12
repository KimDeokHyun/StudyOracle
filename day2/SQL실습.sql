--������� ��ȸ�ϴ� ������
SELECT*FROM emp
 WHERE sal = 5000; --emp���̺� ��ü���� sal�� 5000�� row ���
 
SELECT*FROM emp
 WHERE job = 'CLERK'; --emp ���̺� ��ü���� job�� CLERK�� row ���
  
SELECT*FROM emp
 WHERE comm = 0 or comm is null; --comm = 0 �Ǵ� null�� row ���
   
SELECT*FROM emp
 WHERE comm is null and job = 'ANALYST';  --comm�� NULL�̰� ������ ANALYST�� ����� ���

--��������    
SELECT empno, ename, deptno 
 from emp
 where deptno = 30; --emp���̺� �� empno, ename, deptno colmn�� ����. deptno = 30�� ������ ���
 
--Join �ΰ� �̻��� ���̺��� �ϳ��� ���̺�ó�� ��ȸ�ϴ� ���
select*from emp
 JOIN dept                                --emp���̺� dept���̺��� ����.
    ON emp.deptno = dept.deptno;  --emp�� deptno = dept�� deptno
    
--DISTINCT
Select distinct job from emp; --�ߺ� ������ job�� ���

--��Ī ���� as
 select ename, job, sal, sal*12 as ANNSAL
 from emp;
 
 --��������/��������
 Select ename, job, sal, sal*12 As ANNSAL
 From emp
 Order By job ASC , sal ASC;      --ASC : �������� / DESC : ��������
 
 --Join + AS
select*from emp e -- AS ����. (PL/SQL) 
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
 where sal between 1600 and 2975; --sal ���� 1600�̻� 2975������ ��

--Like
--1)
select ename, job, sal, sal*12 ANNSAL
 from emp
 where ename like '_A_E_';
--2)
select ename, job, sal, sal*12 ANNSAL
 from emp
 where ename like 'J%E%';