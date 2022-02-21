/*
[문제] Group by, AVG
구매내역(장바구니) 정보에서 회원 아이디별로 구매수량에 대한 평균을 조회
회원 아이디를 기준으로 내림차순 */

select cart_member 멤버ID, avg(cart_qty) 평균구매수량
    from cart
    group by cart_member
    order by cart_member;
    
/*
[문제] round,avg
상품정보에서 판매가격의 평균 값을 구하라.
단, 평균값은 소수점 2까지 표현. */
select prod_name, round(avg(prod_sale),2) avg
    from prod;
    
/*
[문제] round,avg,group_by
상품정보에서 상품분류별 판매가격의 평균값을 구하라
조회 : 상품분류코드, 상품분류별 판매가격의 평균
단, 평균값은 소수점 2까지 표현. */
select prod_lgu, round(avg(prod_sale),2) avg
    from prod
    group by prod_lgu;

/* 
[문제]
회원테이블의 취미종류 수를 count 집계*/
select count(distinct mem_like)
    from member;

/* 
[문제]
회원테이블의 직업종류 수를 count 집계*/
select count(distinct mem_job) 직업
    from member;

/*
[문제]
회원 전체의 마일리지 평균보다 큰 회원에 대한
아이디, 이름, 마일리지를 조회해 주세요.
정렬은 마일리지 내림차순 */

select mem_id, mem_name, mem_mileage
    from member
    where mem_mileage >=(select avg(mem_mileage) from member)
    order by mem_mileage;

/* 장바구니테이블의 회원별 최대구매수량을 검색하시오
 회원id, 최대수량, 최소수량*/
select cart_member 회원id,
    max(distinct cart_qty) "최대수량(distinct)",
    max(cart_qty)최대수량,
    min(distinct cart_qty)"최소수량(distinct)",
    min(cart_qty)최소수량
    from cart
    group by cart_member;

/*  2000년도 7월 11일이라 가정하고 장바구니테이블에 발생될 추가주문번호를 검색
최고치주문번호, 추가주문번호) */
select max(cart_no), MAX(cart_no) + 1
    from cart
WHERE cart_no like '20050711%';

/*
[문제]
구매정보에서 년도별로 판매된 상품의 갯수, 평균구매수량을 조회하려 한다.
정령은 년도를 기준으로 내림차순. */
select count(cart_prod), avg(count(cart_prod))
    from cart
    group by cart_no
order by cart_no; */

/*
[문제]
구매정보에서 년도별, 상품분류코드별 상품의 갯수를 조회하려고 한다.
(상품 갯수는 count) 정렬을 년도 기준 내림차순*/

select substr(cart_no,1 ,4 ) as yyyy, 
        substr(cart_prod,1 ,4 ) as 상품분류코드,
        count(cart_qty) as count_qty
from cart
group by substr(cart_no,1 ,4 ) ,substr(cart_prod,1 ,4 )
order by yyyy desc;

/*
[문제]
회원테이블의 회운전체의 마일리지평균, 마일리지 합계, 최고 마일리지,
최소마일리지, 인운수 검색
(마일리지 평균, 마일리지합계, 최고마일리지, 최소마일리지, 인원수)*/
select round(avg(mem_mileage),2) avg, sum(mem_mileage) sum,
        max(mem_mileage) max, min(mem_mileage) min, count(mem_mileage) count        
from member;

/*
[문제]
상품테이블에서 상품분류별, 판매가전체의 평균, 합계, 최고 값, 최저 값, 자료 수 검색
(평균, 합계, 최고값, 최저값, 자료수)*/
select prod_lgu, round(avg(prod_sale),2) avg, sum(prod_sale) sum,
        max(prod_sale) max, min(prod_sale) min, count(prod_sale) count        
from prod
group by prod_lgu
having count(prod_lgu) >=20;

/*회운테이블에서 지역(주소1의 2자리), 생일년도별로 마일리지평균 마일리지합계
최고 마일리지, 최소마일리지, 자료수를 검색 */

select substr(mem_add1,1,2) 지역,
        to_char(mem_bir,'yyyy' ) 연도,
        round(avg(mem_mileage),2) 마일리지평균,
        sum(mem_mileage) 마일리지합계,
        max(mem_mileage) 최고마일리지,
        min(mem_mileage) 최소마일리지,
        count(mem_mileage) 자료수        
    from member
    group by substr(mem_add1,1,2),
        to_char(mem_bir,'yyyy' );

--거래처 담당자 성씨가 '김' 이면 NULL로 갱신
UPDATE buyer set buyer_charger = NULL
WHERE buyer_charger like '김%';

--거래처 담당자가 성씨가 '성' 이면 white space로 갱신
update buyer set buyer_charger = ' '
where buyer_charger like '성%';

--Null값 비교
select buyer_name 거래처, buyer_charger담당자
from buyer
where buyer_charger_null;

--회원 마일리지에 100을 더한 수치를 검색
--NVL사용, 성명, 마일리지, 변경마일리지

--회원마일리지가 있으면 '정상회원' Null이면 '비정상회원'
select mem_name, mem_mileage,
        nvl2(mem_mileague, '정상','비정상') as mileague_null
    from member;

--DECODE

select decode(9,10,'A',9,'B',8,'C','D')
    from dual;
    
        
select decode(substr(prod_lgu,1,2),
        'P1','컴퓨터/전자 제품',
        'P2',' 의류',
        'P3', '잡화', '기타')
        from prod;
        
--함수
--상품분류중 앞의 두글자가 'P1'이면 판매가를 10%인상하고
--'P2'면 15%인상, 나머지는 동일 판매가로 검색
--(decode함수 사용, 상품명,판매가,변경판매가)
select prod_name as 상품명,
        prod_sale 판매가,
        decode(substr(prod_lgu,1,2),
            'P1',prod_sale*1.1,
            'P2',prod_sale*1.15) as new_sale    
from prod;

--회원정보테이블의 주민등록 뒷자리(7자리 중 첫째자리)에서 성별 구분을 검색하시오
--Case 구분 사용, (회원명, 주민등록번호(주민1-주민2),성별)
select mem_name 이름,
        mem_regno1|| '-' ||mem_regno2 주민등록번호,
        case
            when substr(mem_regno2,1,1) = 1 
            then '남자'
            else
            '여자'
            end as mf
            from member;

--decode구문사용
select mem_name 이름,
        mem_regno1|| '-' ||mem_regno2 주민등록번호,
        decode(substr(mem_regno2,1,1),1,'남자','여자') 성별
        from member;

select substr(mem_name,1,1) ||'**' 이름,
	mem_id 아이디,
	mem_bir 생일,
	mem_mail,
	'***-***-' || substr(mem_hp,9,4)
from member;
---------------------------------------------
/*문제
홀수달에 구매되지 않은 상품들을 확인하고
세탁주의가 아닌 상품들의 
상품의 id, 이름, 마진률(이익률)이 몇퍼센트인지 구하라.
마진률이 최하인 값은 10%를 추가하여 입력하고, 
마진률이 제일 높은 값은 10%를 인하하여 입력하라.
정렬은 상품군, 상품명순으로 나열하라. */



select prod_id ID,
	prod_name 이름,
decode (prod_sale-prod_cost,
            (select min(prod_sale-prod_cost) from prod),
            (prod_sale-prod_cost)*1.1,
            (select max(prod_sale-prod_cost) from prod),
            (prod_sale-prod_cost)*0.9,
            prod_sale-prod_cost) as margin
from prod
where mod(to_number(substr(prod_insdate,4 ,2 ) ),2)=0
and prod_delivery != '세탁주의'
order by prod_lgu, prod_name;

select substr(prod_insdate,4 ,2)
from prod;