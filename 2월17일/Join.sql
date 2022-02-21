/*
문제. 
회원정보 중에 구매내역이 있는 회원에 대한 회원아이디, 회원이름, 생일(0000-00-00 형태)을 조회해 주세요
정렬은 생일을 기준으로 오름차순 해 주세요
*/
select mem_id, mem_name, to_char(mem_bir,'YYYY-MM-DD')
from member
where not mem_id in (select cart_member from cart)

order by to_char(mem_bir,'YYYY-MM-DD') asc;

-- 한개의 테이블 조회
select prod_id, prod_name, prod_lgu
    from prod
        where exists (select lprod_gu
                    from lprod
                    where lprod_gu = prod.prod_lgu
                    and lprod_gu = 'P301');
                    
--Join
--Cross join
--[일반방식]

select m.mem_id, c.cart_member, p.prod_id
from member m, cart c, prod p, lprod lp, buyer b;

select count(*)
from member m, cart c, prod p, lprod lp, buyer b;

--[국제표준방식]
Select
From member cross join cart 
             cross join prod    
             cross join lprod
             cross join buyer;

--Equi - Join (simple-join)
/* select table.column, table.column
    from table1, table2
    where table1.clumn = table2.column
*/

/*상품테이블서 상품코드, 상품명, 분류명 조회
상품테이블 prod
분류테이블 lprod*/

--[일반방식]
select prod.prod_id "상품코드",
        prod.prod_name "상품명",
        lprod.lprod_nm "분류명"
        from prod, lprod
        where prod.prod_lgu = lprod.lprod_gu;

--[국제표준방식]
select prod.prod_id "상품코드",
        prod.prod_name "상품명",
        lprod.lprod_nm "분류명"
        from prod inner join lprod
            on( prod.prod_lgu = lprod.lprod_gu);
            
--Table Join Alias 사용
--[일반방식]
select A.prod_id "상품코드",
        A.prod_name "상품명",
        B.lprod_nm "분류명",
        C.buyer_name "거래처명"
    from prod A, lprod B,buyer C
    where A.prod_lgu = B.lprod_gu
    And A.prod_buyer = C.buyer_id;
    
--[국제표준]
select A.prod_id "상품코드",
        A.prod_name "상품명",
        B.lprod_nm "분류명",
        C.buyer_name "거래처명"
    from prod A inner join lprod B
        on(A.prod_lgu = B.lprod_gu)
        inner join buyer C
        on(A.prod_buyer = C.buyer_id);
    
/*[문제]
회원이 구매한 거래처 정보를 조회하려고 한다.
회원아이디, 회원이름, 상품거래처명, 상품분류명을 조회 */
select m.mem_id, m.mem_name, b.buyer_name, lp.lprod_nm 
from member m, buyer b, prod p, cart c, lprod lp
where m.mem_id= c.cart_member
and c.cart_prod =  p.prod_id
and p.prod_buyer = b.buyer_id
and p.prod_lgu = lp.lprod_gu;

/*
[문제]
거래처가 '삼성전자'인 자료에 대한 상품코드, 상품명, 거래처명 조회*/
select p.prod_id, p.prod_name, b.buyer_name
from prod p, buyer b
where p.prod_buyer = b.buyer_id
and b.buyer_name = '삼성전자';


/*
[문제]
상품테이블에서 상품코드, 상품명, 분류명, 거래처명, 거래처주소 조회
판매가격 <=10만원, 거래처주소 = '부산'*/

select p.prod_id, p.prod_name, lp.lprod_nm, b.buyer_name, b.buyer_add1
from prod p, lprod lp, buyer b
where p.prod_buyer = b.buyer_id
and p.prod_lgu = lp.lprod_gu
and p.prod_sale <=100000
and b.buyer_add1 like '%부산%';

/*
[문제]
상품분류코드가 P101인것에 대한 
상품분류명, 상품아이디, 판매가, 거래처담당자, 회원아이디, 주문수량조회
단, 상품분류명 기준 내림차순, 아이디기준 오름차순*/
select lp.lprod_nm,  p.prod_id, p.prod_sale, b.buyer_charger, c.cart_member, c.cart_qty
from prod p, lprod lp, buyer b, member m, cart c
where m.mem_id= c.cart_member
and c.cart_prod =  p.prod_id
and p.prod_buyer = b.buyer_id
and p.prod_lgu = lp.lprod_gu
and p.prod_lgu = 'P101'
order by lp.lprod_nm,c.cart_member desc;

-----------------          

select mem_id, mem_name, mem_mileage
from member
where mem_id in (
    select cart_member 
    from cart
    where cart_prod in (
        select prod_lgu 
        from prod
        where prod_lgu in ( 
            select buyer_id 
            from buyer 
            where substr(buyer_id,1,2) = 'P1'
             and substr(buyer_add1,1,2) = '인천'
            )))
and substr(mem_memorialday,4 ,2 ) != 8
and mem_mileage <= (select avg(mem_mileage) from member)
and mem_memorial = '결혼기념일'  ;

------
select buyer_name,  buyer_comtel 
from buyer
where buyer_id in (
select prod_lgu
from prod
where prod_name like '%TV%' 
and prod_id in(
select cart_prod
from cart
where cart_member in (
select mem_id
from member
where mem_name = '오철희')));

select b.buyer_name,  b.buyer_comtel 
from prod p, buyer b, member m, cart c
where p.prod_buyer = b.buyer_id
and c.cart_prod =  p.prod_id
and m.mem_name = '오철희'
and p.prod_name like '%TV%'
