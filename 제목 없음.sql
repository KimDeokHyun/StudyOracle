--1번
select lower(email)
      , mobile
      , names
      , addr
      , levels
from membertbl
order by names;

--2번
select names 책제목
      , author 저자명
      , to_char(releasedate, 'yyyy-mm-dd') 출판일
      , price 가격
      from bookstbl b
      order by b.idx;
      
--3번
select d.names 장르
      , b.names 책제목
      , b.author 저자
      , to_char(b.releasedate, 'yyyy-mm-dd') 출판일
      , b.isbn 책코드번호
      , to_char(b.price) ||'원' 가격
from bookstbl b, divtbl d
where b.division = d.division
order by b.idx desc;

--4번
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
     ,'홍길동'
     , 'A'
     , '부산시 동구 초량동'
     , '010-7989-0909'
     , 'HGD09@NAVER.COM'
     , 'HGD7989'
     , 12345
     , NULL
     , NULL);
     
--5번

select nvl(d.names, '--합계--') 장르
      ,sum(b.price) 장르별합계금액
      
  from divtbl d
     , bookstbl b
where b.division = d.division
group by rollup( d.names ) ;

