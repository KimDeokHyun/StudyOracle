Create Table lprod(
    lprod_id number(5)  Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40)Not Null,
    CONSTRAINT pk_lprod Primary Key (lprod_gu)
);

--조회하기
Select * From lprod;
Value(
    1, 'P101', '컴퓨터제품'
);

INSERT into plrod(lprod_id,iprod_gu,lprod_nm)
    value(1,'P101','컴퓨터제품');
INSERT into plrod(lprod_id,iprod_gu,lprod_nm)
    value(2,'P102','전자제품');
INSERT into plrod(lprod_id,iprod_gu,lprod_nm)
    value(3,'P201','여성캐쥬얼');
INSERT into plrod(lprod_id,iprod_gu,lprod_nm)
    value(4,'P202','남성캐쥬얼');
INSERT into plrod(lprod_id,iprod_gu,lprod_nm)
    value(5,'P301','피혁잡화');
INSERT into plrod(lprod_id,iprod_gu,lprod_nm)
    value(6,'P302','화장품');
INSERT into plrod(lprod_id,iprod_gu,lprod_nm)
    value(7,'P401','음반/CD');
INSERT into plrod(lprod_id,iprod_gu,lprod_nm)
    value(8,'P402','도서');
INSERT into plrod(lprod_id,iprod_gu,lprod_nm)
    value(9,'P403','문구류');



Select*
From lprod
--조건추가
Where lprod_gu = 'P201';

 -- 상품분류코드가 P102에 대해서
 -- 상품분류명의 값을 향수로 수정해 주세요....
 SELECT * 
 FROM LPROD
 WHERE LPROD_GU = 'P102';
 
 UPDATE LPROD
      SET LPROD_NM='향수'
WHERE LPROD_GU = 'P102';

--상품분류코드가 'P202' 대한 데이터를 
--삭제해 주세요

 SELECT * 
 FROM LPROD
 WHERE LPROD_GU = 'P202';
 
 DELETE from lprod
 where LPROD_GU='P202';

COMMIT;

-- 테이블 생성하기
Create Table buyer(
    buyer_id char(6)  NOT NULL,
    buyer_name VARCHAR2(40) NOT NULL, 
    buyer_lgu char(4) Not Null,
    buyer_bank varchar2(60),
    buyer_bankno varchar2(60),
    buyer_bankname varchar2(15),
    buyer_zip char(7),
    buyer_add1 varchar2(100),
    buyer_add2 varchar2(70),
    buyer_comtel varchar2(14) NOT NULL,
    buyer_fax  varchar2(20) NOT NULL 
);

ALTER TABLE buyer ADD (buyer_mail varchar2(60) not null,
    buyer_charger varchar2(20),
    buyer_telext varchar2(2));
ALTER Table buyer modify (buyer_name varchar(60));
ALTER table buyer
    ADD (constraint pk_buyer Primary Key(buyer_id),
        constraint fr_buyer_lprod Foreign  key (buyer_lgu)
            References lprod(lprod_gu));
    COMMIT;