
--���̺� �ҷ�����
SELECT*FROM EMP;

--���̺� �κ� �� ����ϱ�
SELECT column1, column2, column3 FROM EMP;
--���� ����Ű : Ctrl+enter

--Distinct �ߺ� ������ ���� 
--�� ��� �ߺ����Ű� �ȵ�
select distinct empno, deptno from emp; --13��

select distinct job, deptno from emp; --9��

--���Ǻ� where
select*from emp
 where empno = 7499;

select*from emp
 where ename = 'ȫ�浿';
 
 select*from emp
 where job = 'CLERK';
 
 select*from emp
  where sal >= 1500;
