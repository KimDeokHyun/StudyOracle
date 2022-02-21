--where절
--기타연산자
--상품 분류테이블에서 현재 상품테이블에 존재하는 분류만 검색(분류코드,분류명)
select lprod_gu 분류코드, lprod_nm 분류명
from lprod
where lprod_gu in (SELECT prod_lgu from prod);

--상품 분류테이블에서 현재 상품테이블에 존재하지 않는 분류만 검색하시오? (alias는 분류코드, 분류명)
SELECT lprod_gu 분류코드, lprod_nm 분류명
FROM lprod
where lprod_gu not in (SELECT prod_lgu from prod);
/*
한번도 상품을 구매한적이 없는 회원 아이디, 이름 조회
*/
SELECT mem_id 회원아이디, mem_name 회원이름
FROM member
where mem_id not in(SELECT cart_member
    FROM cart);
    /*
lprod : 상품분류정보
prod: 상품정보
buyer: 거래처 정보
member: 회원 정보
cart: 구매 정보
buyprod: 입고상품정보
remain: 재고 수불정보 
 */
 /*
 한번도 판매된 적이 없는 상품을 조회하려고 합니다.
 판매된 적이 없는 상품이름을 조회해 주세여
 */
 select prod_name 상품이름 
 from prod
 where prod_id not in (select cart_no
 from cart); 
 /*
 회원 중에 김은대 회원이 지금까지 구매했던 모든 상품명을 조회해 주세요.
 */
SELECT prod_name
FROM prod
where prod_id in (select cart_prod from cart
where cart_member in ( select mem_id from member where mem_name='김은대'));

/*
상품 중 판매가격이 10만원이상, 30만원 이하인 상품을 조회
조회 컬럼은 상품명 , 판매가격 입니다.
정렬은 판매가격을 기준으로 내림차순 해주세요
*/
SELECT prod_name 상품명, prod_sale 판매가격
FROM prod
where prod_sale >= 100000 and prod_sale <=300000
order by prod_sale desc;

SELECT prod_name 상품명, prod_sale 판매가격
FROM prod
where prod_sale between 100000 and 300000
order by prod_sale desc;

--회원 중 생일이 1975-01-01 에서 1976-12-31 사이에 태어난 회운을 검색하시오?
-- alias 는  회원id 회원명, 생일
SELECT mem_id 회원id, mem_name 회원명, mem_bir 생일
FROM member
where mem_bir BETWEEN '1975-01-01 'and '1976-12-31'
order by mem_bir asc;

/*
거래처 담당자 강남구씨가 담당하는 상품을 
구매한 회원들을 조회하려고 합니다.
회원아이디, 회원이름을 조회해주세요..
*/
select mem_id 회원아이디, mem_name 회원이름
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
            where buyer_charger='강남구'
            )));


select mem_id 회원아이디, mem_name 회원이름
from member
where mem_id in (select cart_member from cart
                            where cart_prod in (select prod_id from prod
where prod_lgu in ( select lprod_gu from lprod
                                                            where lprod_gu in (select buyer_lgu from buyer 
                                                            where buyer_charger='강남구'))));
                                                            
/*
상품 중 매입가가 300,000~1,500,00이고 
판매가가 800,000~2,000,000 인 상품을 검색하시오 
(Alias는 상품명, 매입가, 판매가)
*/
SELECT prod_name 상품명, prod_cost 매입가, prod_sale 판매가
FROM prod
where prod_cost between 300000 and 1500000 and prod_sale BETWEEN 800000 and 2000000;

/*
회원 중 생일이 1975년도 생이 아닌 회원을 검색하시오?
(Alias는 회원ID, 회원 명, 생일)
*/
SELECT mem_id 회원, mem_name 회원명, mem_bir 생일
FROM member
where not (mem_bir between '75/01/01' and '75/12/31');

--회원테이블에서 김씨 성을 가진 회원을 검색하시오
--(Alias는 회원ID, 성명)
select mem_id 회원, mem_name 성명
from member
where mem_name like '김%';
--회원테이블의 주민등록번호 앞자리를 검색하여 1975년생을 제외한 회원을 검색하시오
--(Alias는 회원ID, 성명,주민등록번호)
select mem_id 회원, mem_name 성명 ,mem_regno1 주민등록번호
from member
where not mem_regno1 not like '75%';

select  'a' || 'bcde' from dual;
select mem_id || ' name is' || mem_name from member;
select concat('my name is' , mem_name) from member;
select chr(65) "chr", asc||('A') "asc||" from dual;
select asc||(chr(65) result from dual;
select chr(75)"chr", asc||('K') "asc||" from dual;
select lower ('DATA manipulation Language') "LOWER",
        upper('DATA manipulation Language') "UPPER",
        initcap('DATA manipulation Language') "INITCAP" FROM DUAL;
        
--회원테이블의 회원ID를 대문자로 변환하여 검색하시오 
--(Alias명은 변환 전ID, 변환 후ID)
select mem_id 변환전id,
        upper(mem_id)"변환 후id"
        from member;
        
select replace('java flex via','a')
from dual;
/*
회원테이블의 회원성명 중 성씨 '이' -->'리' 치환하여
뒤에 이름을 붙인 후 검색하시오
(Alias명은 회원명, 회원명치환)
*/
select concat(replace(substr(mem_name,1,1),'이','리'),
         substr(mem_name,2))
         from member;
         
SELECT sysdate-1
 FROM dual;
 --현재 시간에서 5달 더하기       
SELECT add_months(sysdate,5)
FROM dual;
--다음 월요일 , 이번달 마지막 날
SELECT next_day (sysdate, '월요일'),
    last_day(sysdate)
    from dual;
    
--이번달이 며칠이 남았는지 검색하시오
select last_day(sysdate)-sysdate
from dual;

--extract 날짜에서 필요한 부분만 추출
SELECT extract(year from sysdate) "년도"
    FROM dual;
--생일이 3월인 회원을 검색하시오
select mem_bir,
extract(month from mem_bir) as bir3
from member
where extract(month from mem_bir) = '3'; 

/*
회원 생일 중 1973년생이 주로 구매한 상품을 
오름차순으로 조회하려고 합니다.
 - 조회컬럼: 상품명
 - 단, 상품명에 삼성이 포함된 상품만 조회,
 그리고 조회결과는 둥복제거
 */
select prod_name 상품명
from prod
where prod_name like '%삼성%' and
prod_id in (
        select cart_prod    
        from cart
        where cart_member in ( 
        select mem_id   
        from member
        where  extract(year from mem_bir) = 1973))
    order by prod_name asc;
 
 /* 
 to char : 숫자 ,문자, 날짜를 지정한 형식의 문자열 변환
 */
 
--상품테이블에서 상품입고일을 '2008-09-28' 형식으로 나오게 검색하시오 (Alias 상품명, 상품판매가, 입고일)
select prod_name 상품명, prod_sale 상품판매가, 
to_char (prod_insdate,'YYYY-MM-DD') AS 입고일
from prod;

--회원이름과 생일로 다음처럼 출력되게 작성하시오
select  mem_name || '님은' || 
extract(year from mem_bir) ||'년도'|| 
extract(month from mem_bir)|| '월 출생이고 태어난 요일은 ' || to_char(mem_bir, 'day') as day
from member;

select to_char (1234.6, '99,999.00') from dual;
select to_char (-1234.6, 'L99,999.00PR') from dual;  --$ ,L 은 달러및 지역 화폐기호
select to_char (255, 'XXX') from dual;

--상품테이블에서 상품코드, 상품명,매입가격, 소비자 가격, 판매가격을 출력하시오
-- 단, 가격은 천단위 구분 및 원화표시
SELECT prod_id 상품코드 , prod_name 상품명,
to_char(prod_cost,'L999,999,999') 매입가격, 
to_char(prod_price , 'L999,999,999')소비자가격,
to_char(prod_sale,'L999,999,999') 판매가격
FROM PROD;

--회원테이블에서 이쁜이회원의 회원id2~4 문자열을 숫자형으로 치환한 후 10을 더하여 새로운 회원 id로 조합하시오
--(alias는 회원id, 조합회원id)
select mem_id,
substr(mem_id,1,2) ||
(substr(mem_id,3,4)+10) as new_mem_id
         from member
         where mem_name = '이쁜이';
         
-- 상품테이블의 상품분류별 매입가격 평균값
/*
일반컬럼과 그룹함수를 같이 사용할 경우에는 
꼭~ Group by 절을 넣어 주어야 합니다
그리고 Group by절에는 일반컬럼이 모두 들어가야 합니다.
*/
select prod_lgu,
round(avg(prod_cost),2) --"분류별 매입평균 가격"
from prod
group by prod_lgu;

-- 상품테이브르이 판매가겨 평균 값을 구하시오
select avg(prod_sale) as avg_sale
from plod;

-- 상품테이블의 상품분류별 판매가격 평균 값을 구하시오
select prod_lgu, avg(prod_sale) as avg_sale
from prod
group by prod_lgu;
/*
장바구니테이블의 회원별 count집계 하시오 
*/
select cart_member, count(cart_member) as mem_count
from cart
group by cart_member;
/*
구매수량의 전체평균 이상을 구매한 회원들의 
아이디와 이름을 조회해 주세요.
단 정렬은 주민번호 앞자리 기준으로 오름차순
*/
select mem_id, mem_name 
from member
where 
mem_id in (select cart_member from cart
where cart_qty>=(select avg(cart_qty) from cart ))
order by mem_regno1 asc;
