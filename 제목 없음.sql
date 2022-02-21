--1��
select lower(email)
      , mobile
      , names
      , addr
      , levels
from membertbl
order by names;

--2��
select names å����
      , author ���ڸ�
      , to_char(releasedate, 'yyyy-mm-dd') ������
      , price ����
      from bookstbl b
      order by b.idx;
      
--3��
select d.names �帣
      , b.names å����
      , b.author ����
      , to_char(b.releasedate, 'yyyy-mm-dd') ������
      , b.isbn å�ڵ��ȣ
      , to_char(b.price) ||'��' ����
from bookstbl b, divtbl d
where b.division = d.division
order by b.idx desc;

--4��
insert into MEMBERTBL
     ( idx
     , names
     , levels
     , addr
     , mobile
     , email
     , userid
     , password
     , lastlogindt
     , loginipaddr)
values
     (SQS_1.NEXTval
     ,'ȫ�浿'
     , 'A'
     , '�λ�� ���� �ʷ���'
     , '010-7989-0909'
     , 'HGD09@NAVER.COM'
     , 'HGD7989'
     , 12345
     , NULL
     , NULL);
     
--5��

select nvl(d.names, '--�հ�--') �帣
      ,sum(b.price) �帣���հ�ݾ�
      
  from divtbl d
     , bookstbl b
where b.division = d.division
group by rollup( d.names ) ;

