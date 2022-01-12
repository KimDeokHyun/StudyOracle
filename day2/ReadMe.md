## 2일차 학습
### WHERE절

```sql
 select ename, job, sal, sal*12 ANNSAL
 from emp
 where sal between 1600 and 2975; --sal 값이 1600이상 2975이하인 값