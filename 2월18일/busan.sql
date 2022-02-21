/*
[����]
��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ�ϼ���
��, ��ǰ�з� �ڵ尡 'P101', 'P201', 'P301'�� ���� ��ȸ�ϰ�
���Լ����� 15�� �̻��ΰ�, ���￡ ��� �ִ� ȸ�� �� ������ 1974����� ����鿡 ���� ��ȸ
ȸ�����̵� ���� ��������, ���Լ��� ���� �������� */

select p.prod_lgu, p.prod_name, p.prod_color, bp.buy_qty, c.cart_qty, b.buyer_name
from prod p, buyprod bp, cart c, buyer b, member m 
where m.mem_id= c.cart_member
and c.cart_prod =  p.prod_id
and p.prod_buyer = b.buyer_id
and p.prod_id = bp.buy_prod
and substr(m.mem_add1,1,2) = '����'
and substr(m.mem_regno1,1,2) = 74
and bp.buy_qty >=15
and (p.prod_lgu = 'P101'or p.prod_lgu = 'P201' or p.prod_lgu = 'P301')
order by mem_id desc, bp.buy_qty desc
;

/*
��ü �з��ǻ�ǰ�ڷ� ���� �˻� ��ȸ
Alias�� �з��ڵ�, �з���, ��ǰ�ڷ��

1. �з����̺� ��ȸ
SELECT * From lprod

2. �Ϲ� Join
select lprod_gu �з��ڵ�,
        lprod_nm �з���,
        count(prod_lgu) ��ǰ�ڷ��
        from lprod,prod
        where lprod_gu = prod_lgu
        group by lprod_gu, lprod_nm
        
3. outer join ��� Ȯ��
select lprod_gu �з��ڵ�, lprod_nm �з���,
count(prod_lgu) ��ǰ�ڷ��
from lprod_prod
where lprod_gu = prod_lgu(+)
group by lprod_gu, lprod_nm
order by lprod_gu 

--ansi ����
 ��� ���� �˻��Ǿ�� �� ���̺��� ��ġ�� �������� �Ѵ�.
��ġ�� ���� left, rigrt, full�� ������
(+) ���� ��Ȯ�ϰ� ����� ���´�
(+)�� �������� ���ϴ� full outer join�� �ȴ�.
*/
ansi outer join--
select lprod_gu �з��ڵ�, lprod_nm �з���,
count(prod_lgu) ��ǰ�ڷ��
from lprod
    left outer join prod on (lprod_gu = prod_lgu)
group by lprod_gu, lprod_nm
order by lprod_gu

/*��ü��ǰ�� 2005�� 1�� �԰������ �˻� ��ȸ
��ǰ�ڵ�, ��ǰ��, �԰����*/
--�Ϲ� join
select prod_id ��ǰ�ڵ�,
        prod_name ��ǰ��,
        SUM(buy_qty) �԰����
    from prod, buyprod
    where prod_id = buy_prod
    and buy_date between '2005-01-01' and '2005-01-31'
    group by prod_id, prod_name;

--outer join ��� Ȯ��
select prod_id ��ǰ�ڵ�,
    prod_name ��ǰ��,
    sum(buy_qty) �԰����
    from prod left outer join buyprod
        on (prod_id = buy_prod
            and buy_date between '2005-01-01' and '2005-01-31')
    group by prod_id, prod_name
    order by prod_id, prod_name;
    
/*��ü ȸ���� 2005�⵵ 4���� ������Ȳ ��ȸ
ȸ��id, ����, ���ż����� ��*/
select mem_id ȸ��id,
    mem_name ����,
    sum(cart_qty) ���ż���
    from member, cart
    where mem_id = cart_member
    and substr(cart_no,1,6)='200504'
    group by mem_id, mem_name
    order by mem_id, mem_name;

--join group by
/*2005�⵵ ���� ���� ��Ȳ�� �˻��Ͻÿ� 
���Կ�, ���Լ���, ���Աݾ�(���Լ���*��ǰ���̺� ���԰�)*/
select to_char(buy_date,'MM')���Կ�,
sum(buy_qty)���Լ���,
to_char(sum(buy_qty*prod_cost),'L999,999,999')���Աݾ�
from buyprod,prod
where buy_prod=prod_id
and extract(year from buy_date) = 2005
group by to_char(buy_date,'MM')
order by ���Կ� asc;

----
select prod_id ��ǰ�ڵ�, prod_name ��ǰ��,
    count(*) �Ǹ�Ƚ��
    from prod, cart
    where prod_id = cart_prod
    and substr(cart_no, 1,4) = '2005'
    group by prod_id, prod_name
    having count(*) >= 5; 
    
--
/*��ǰ�з��� ��ǻ����ǰ('P101')�� ��ǰ�� 2005�⵵ ���ں� �Ǹ���ȸ
�Ǹ��� �Ǹűݾ�(5000000)�ʰ��� ��츸,, �Ǹż���
-having�� �̿��Ͽ� �ش� ��ȸ*/

select substr(cart_no,1,8) �Ǹ���,
    sum(cart_qty * prod_sale) �Ǹűݾ�,
    sum(cart_qty) �Ǹż���
    from prod, cart
    where cart_no like '2005%'
        and prod_id = cart_prod
        and prod_lgu = 'P101'
        Group by substr(cart_no,1,8)
        having sum(cart_qty*prod_sale) >5000000
        order by substr(cart_no,1,8);

--��������
/* SQL ���� �ȿ� �� �ٸ� select ������ �ִ� ���� ���Ѵ�.
Subquery�� ���ٸ� SQL������ �ʹ� ���� join �� �ؾ��ϰų� ������ ����������.
subquery�� ��ȣ�� ���´�.
�����ڸ� ���� �����ʿ� ��ġ
from���� ����ϴ� ��� view�� ���� ������ ���̺�ó�� Ȱ��Ǿ� inline view��� �θ���
main query�� sub query������ ������ ���ο� ����
����, �񿬰� ���������� ����
��ȯ�ϴ� ���� ��, �÷����� ���� ������/������, �����÷�/�����÷����� ����.
��ü������ �������� Ư���� �����ϸ� ����. */

--��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ
--���� ��� ������ ��� subquery�� �ʿ�x
--Subquery
 select prod_id, prod_name,
 (select lprod_nm from lprod where prod_lgu = lprod_gu)
 from prod;

--��ǰ���̺��� �ǸŰ��� ��ǰ����ǸŰ����� ū ��ǰ�� �˻�
--(��ǰ��, �ǸŰ�, ����ǸŰ�)
select A.prod_name ��ǰ��,
    to_char(A.prod_sale, '999,999,999')�ǸŰ�,
    to_char(B.avg_sale,'999,999,999') ����ǸŰ�
    from prod a, (select avg(prod_sale) avg_sale
        from prod) b
        where a.prod_sale >b.avg_sale;
        
select mem_name ȸ����, CASE 
          WHEN SUBSTR(mem_regno2,1,1) = 1 THEN '����'
          ELSE '����' END as "����", mem_add1 || mem_add2 �ּ�, mem_mail �̸����ּ�,
mem_name || 'ȸ������' || Extract(month from mem_bir) || '�� ������ �������� ���� �մϴ�.
2 ��Ʈ ' || substr(mem_add1,1,2) || '���� �̿��� �ּż� �����մϴ�.
�̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.
�����ε� ���� �̿� �ٶ��ϴ�.' as "���� ���� ����"
from member
    where mem_add1 like '%����%'
        and TO_CHAR(mem_bir,'mm') ='03' and
        mem_id in 
        (select cart_member
            from cart
            where substr(cart_no,5,2) between '04' and  '06'
            and cart_qty > (select avg(cart_qty) from cart));
            
SELECT prod_name �̸�,
          prod_sale �ǸŰ���,
          prod_sale + NVL(prod_mileage,0) �հ��
	FROM prod
	WHERE prod_lgu IN (SELECT lprod_gu
		FROM lprod
		WHERE lprod_nm = '����ĳ�־�')
		 AND prod_name like '%����%'
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
SELECT  mem_name as ȸ����,
           mem_mileage as ���ϸ���,
	CASE 
	 When mem_mileage > = 2500 THEN '���ȸ��'
              Else '�Ϲ�ȸ��' 
              END as �����÷�
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
	 When mem_mileage > = 2500 THEN '���ȸ��'
              Else '�Ϲ�ȸ��' 
              END as �����÷�
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
    


