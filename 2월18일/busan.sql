/*
[문제]
상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회하세요
단, 상품분류 코드가 'P101', 'P201', 'P301'인 것을 조회하고
매입수량이 15개 이상인것, 서울에 살고 있는 회원 중 생일이 1974년생인 사람들에 대해 조회
회원아이디 기준 내림차순, 매입수량 기준 내림차순 */

select p.prod_lgu, p.prod_name, p.prod_color, bp.buy_qty, c.cart_qty, b.buyer_name
from prod p, buyprod bp, cart c, buyer b, member m 
where m.mem_id= c.cart_member
and c.cart_prod =  p.prod_id
and p.prod_buyer = b.buyer_id
and p.prod_id = bp.buy_prod
and substr(m.mem_add1,1,2) = '서울'
and substr(m.mem_regno1,1,2) = 74
and bp.buy_qty >=15
and (p.prod_lgu = 'P101'or p.prod_lgu = 'P201' or p.prod_lgu = 'P301')
order by mem_id desc, bp.buy_qty desc
;

/*
전체 분류의상품자료 수를 검색 조회
Alias는 분류코드, 분류명, 상품자료수

1. 분류테이블 조회
SELECT * From lprod

2. 일반 Join
select lprod_gu 분류코드,
        lprod_nm 분류명,
        count(prod_lgu) 상품자료수
        from lprod,prod
        where lprod_gu = prod_lgu
        group by lprod_gu, lprod_nm
        
3. outer join 사용 확인
select lprod_gu 분류코드, lprod_nm 분류명,
count(prod_lgu) 상품자료수
from lprod_prod
where lprod_gu = prod_lgu(+)
group by lprod_gu, lprod_nm
order by lprod_gu 

--ansi 형식
 모든 행이 검색되어야 할 테이블의 위치를 기준으로 한다.
위치에 따라서 left, rigrt, full로 나눈다
(+) 보다 명확하게 결과가 나온다
(+)가 지원하지 못하는 full outer join이 된다.
*/
ansi outer join--
select lprod_gu 분류코드, lprod_nm 분류명,
count(prod_lgu) 상품자료수
from lprod
    left outer join prod on (lprod_gu = prod_lgu)
group by lprod_gu, lprod_nm
order by lprod_gu

/*전체상품의 2005년 1월 입고수량을 검색 조회
상품코드, 상품명, 입고수량*/
--일반 join
select prod_id 상품코드,
        prod_name 상품명,
        SUM(buy_qty) 입고수량
    from prod, buyprod
    where prod_id = buy_prod
    and buy_date between '2005-01-01' and '2005-01-31'
    group by prod_id, prod_name;

--outer join 사용 확인
select prod_id 상품코드,
    prod_name 상품명,
    sum(buy_qty) 입고수량
    from prod left outer join buyprod
        on (prod_id = buy_prod
            and buy_date between '2005-01-01' and '2005-01-31')
    group by prod_id, prod_name
    order by prod_id, prod_name;
    
/*전체 회원의 2005년도 4월의 구매현황 조회
회원id, 성명, 구매수량의 합*/
select mem_id 회원id,
    mem_name 성명,
    sum(cart_qty) 구매수량
    from member, cart
    where mem_id = cart_member
    and substr(cart_no,1,6)='200504'
    group by mem_id, mem_name
    order by mem_id, mem_name;

--join group by
/*2005년도 월별 매입 현황을 검색하시오 
매입월, 매입수량, 매입금액(매입수량*상품테이블 매입가)*/
select to_char(buy_date,'MM')매입월,
sum(buy_qty)매입수량,
to_char(sum(buy_qty*prod_cost),'L999,999,999')매입금액
from buyprod,prod
where buy_prod=prod_id
and extract(year from buy_date) = 2005
group by to_char(buy_date,'MM')
order by 매입월 asc;

----
select prod_id 상품코드, prod_name 상품명,
    count(*) 판매횟수
    from prod, cart
    where prod_id = cart_prod
    and substr(cart_no, 1,4) = '2005'
    group by prod_id, prod_name
    having count(*) >= 5; 
    
--
/*상품분류가 컴퓨터제품('P101')인 상품의 2005년도 일자별 판매조회
판매일 판매금액(5000000)초과의 경우만,, 판매수량
-having을 이용하여 해당 조회*/

select substr(cart_no,1,8) 판매일,
    sum(cart_qty * prod_sale) 판매금액,
    sum(cart_qty) 판매수량
    from prod, cart
    where cart_no like '2005%'
        and prod_id = cart_prod
        and prod_lgu = 'P101'
        Group by substr(cart_no,1,8)
        having sum(cart_qty*prod_sale) >5000000
        order by substr(cart_no,1,8);

--서브쿼리
/* SQL 구문 안에 또 다른 select 구문이 있는 것을 말한다.
Subquery가 없다면 SQL구문은 너무 많은 join 을 해야하거나 구문이 복잡해진다.
subquery는 괄호로 묶는다.
연산자를 사용시 오른쪽에 배치
from절에 사용하는 경우 view와 같이 독립된 테이블처럼 활용되어 inline view라고 부른다
main query와 sub query사이의 참조성 여부에 따라
연관, 비연관 서브쿼리로 구분
반환하는 행의 수, 컬럼수에 따라 단일행/다중행, 단일컬럼/다중컬럼으로 구분.
대체적으로 연산자의 특성을 이해하면 쉽다. */

--상품코드, 상품명, 분류명을 조회
--실제 상기 내용의 경우 subquery가 필요x
--Subquery
 select prod_id, prod_name,
 (select lprod_nm from lprod where prod_lgu = lprod_gu)
 from prod;

--상품테이블에서 판매가가 상품평균판매가보다 큰 상품을 검색
--(상품명, 판매가, 평균판매가)
select A.prod_name 상품명,
    to_char(A.prod_sale, '999,999,999')판매가,
    to_char(B.avg_sale,'999,999,999') 평균판매가
    from prod a, (select avg(prod_sale) avg_sale
        from prod) b
        where a.prod_sale >b.avg_sale;
        
select mem_name 회원명, CASE 
          WHEN SUBSTR(mem_regno2,1,1) = 1 THEN '남자'
          ELSE '여자' END as "성별", mem_add1 || mem_add2 주소, mem_mail 이메일주소,
mem_name || '회원님의' || Extract(month from mem_bir) || '월 생일을 진심으로 축하 합니다.
2 마트 ' || substr(mem_add1,1,2) || '점을 이용해 주셔서 감사합니다.
이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.
앞으로도 많은 이용 바랍니다.' as "생일 축하 문구"
from member
    where mem_add1 like '%대전%'
        and TO_CHAR(mem_bir,'mm') ='03' and
        mem_id in 
        (select cart_member
            from cart
            where substr(cart_no,5,2) between '04' and  '06'
            and cart_qty > (select avg(cart_qty) from cart));
            
SELECT prod_name 이름,
          prod_sale 판매가격,
          prod_sale + NVL(prod_mileage,0) 합계액
	FROM prod
	WHERE prod_lgu IN (SELECT lprod_gu
		FROM lprod
		WHERE lprod_nm = '여성캐주얼')
		 AND prod_name like '%여름%'
		 AND prod_id IN (SELECT buy_prod
                                FROM buyprod
                                WHERE buy_qty >= 30
                                 AND substr(buy_date,4,2) = 06);
                                 
SELECT mem_id
            , mem_name
            , mem_mileage
FROM member m
        , cart c
        , prod p
        , buyer b
        , lprod l
WHERE m.mem_id = c.cart_member
    AND c.cart_prod = p.prod_id
    AND p.prod_buyer = b.buyer_id
    AND b.buyer_lgu = l.lprod_gu
    AND lprod_gu LIKE 'P20%'
    AND prod_insdate >= '05/02/01'
    AND prod_sale >= 200000;

--------------------------
SELECT  mem_name as 회원명,
           mem_mileage as 마일리지,
	CASE 
	 When mem_mileage > = 2500 THEN '우수회원'
              Else '일반회원' 
              END as 변경컬럼
	FROM member
	WHERE mem_id IN (
		SELECT cart_member
                         FROM cart
                         WHERE cart_prod IN (
			SELECT prod_id 
			FROM prod
			WHERE prod_buyer IN (
				SELECT buyer_id
				FROM buyer 
				WHERE buyer_id LIKE 'P20%' ) 
                                       AND prod_insdate > = '05/01/31'
                                       AND prod_cost > 200000)0
                                                ));            
                                                
SELECT mem_id,
        mem_name,
        mem_mileage,
    CASE 
	 When mem_mileage > = 2500 THEN '우수회원'
              Else '일반회원' 
              END as 변경컬럼
FROM member m
        , cart c
        , prod p
        , buyer b
        , lprod l
WHERE m.mem_id = c.cart_member
    AND c.cart_prod = p.prod_id
    AND p.prod_buyer = b.buyer_id
    AND b.buyer_lgu = l.lprod_gu
    AND lprod_gu LIKE 'P20%'
    AND prod_insdate >= '05/02/01'
    AND prod_sale >= 200000;                                                  
    


