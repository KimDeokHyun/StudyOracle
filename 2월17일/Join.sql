/*
����. 
ȸ������ �߿� ���ų����� �ִ� ȸ���� ���� ȸ�����̵�, ȸ���̸�, ����(0000-00-00 ����)�� ��ȸ�� �ּ���
������ ������ �������� �������� �� �ּ���
*/
select mem_id, mem_name, to_char(mem_bir,'YYYY-MM-DD')
from member
where not mem_id in (select cart_member from cart)

order by to_char(mem_bir,'YYYY-MM-DD') asc;

-- �Ѱ��� ���̺� ��ȸ
select prod_id, prod_name, prod_lgu
    from prod
        where exists (select lprod_gu
                    from lprod
                    where lprod_gu = prod.prod_lgu
                    and lprod_gu = 'P301');
                    
--Join
--Cross join
--[�Ϲݹ��]

select m.mem_id, c.cart_member, p.prod_id
from member m, cart c, prod p, lprod lp, buyer b;

select count(*)
from member m, cart c, prod p, lprod lp, buyer b;

--[����ǥ�ع��]
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

/*��ǰ���̺� ��ǰ�ڵ�, ��ǰ��, �з��� ��ȸ
��ǰ���̺� prod
�з����̺� lprod*/

--[�Ϲݹ��]
select prod.prod_id "��ǰ�ڵ�",
        prod.prod_name "��ǰ��",
        lprod.lprod_nm "�з���"
        from prod, lprod
        where prod.prod_lgu = lprod.lprod_gu;

--[����ǥ�ع��]
select prod.prod_id "��ǰ�ڵ�",
        prod.prod_name "��ǰ��",
        lprod.lprod_nm "�з���"
        from prod inner join lprod
            on( prod.prod_lgu = lprod.lprod_gu);
            
--Table Join Alias ���
--[�Ϲݹ��]
select A.prod_id "��ǰ�ڵ�",
        A.prod_name "��ǰ��",
        B.lprod_nm "�з���",
        C.buyer_name "�ŷ�ó��"
    from prod A, lprod B,buyer C
    where A.prod_lgu = B.lprod_gu
    And A.prod_buyer = C.buyer_id;
    
--[����ǥ��]
select A.prod_id "��ǰ�ڵ�",
        A.prod_name "��ǰ��",
        B.lprod_nm "�з���",
        C.buyer_name "�ŷ�ó��"
    from prod A inner join lprod B
        on(A.prod_lgu = B.lprod_gu)
        inner join buyer C
        on(A.prod_buyer = C.buyer_id);
    
/*[����]
ȸ���� ������ �ŷ�ó ������ ��ȸ�Ϸ��� �Ѵ�.
ȸ�����̵�, ȸ���̸�, ��ǰ�ŷ�ó��, ��ǰ�з����� ��ȸ */
select m.mem_id, m.mem_name, b.buyer_name, lp.lprod_nm 
from member m, buyer b, prod p, cart c, lprod lp
where m.mem_id= c.cart_member
and c.cart_prod =  p.prod_id
and p.prod_buyer = b.buyer_id
and p.prod_lgu = lp.lprod_gu;

/*
[����]
�ŷ�ó�� '�Ｚ����'�� �ڷῡ ���� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó�� ��ȸ*/
select p.prod_id, p.prod_name, b.buyer_name
from prod p, buyer b
where p.prod_buyer = b.buyer_id
and b.buyer_name = '�Ｚ����';


/*
[����]
��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó�ּ� ��ȸ
�ǸŰ��� <=10����, �ŷ�ó�ּ� = '�λ�'*/

select p.prod_id, p.prod_name, lp.lprod_nm, b.buyer_name, b.buyer_add1
from prod p, lprod lp, buyer b
where p.prod_buyer = b.buyer_id
and p.prod_lgu = lp.lprod_gu
and p.prod_sale <=100000
and b.buyer_add1 like '%�λ�%';

/*
[����]
��ǰ�з��ڵ尡 P101�ΰͿ� ���� 
��ǰ�з���, ��ǰ���̵�, �ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ�������ȸ
��, ��ǰ�з��� ���� ��������, ���̵���� ��������*/
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
             and substr(buyer_add1,1,2) = '��õ'
            )))
and substr(mem_memorialday,4 ,2 ) != 8
and mem_mileage <= (select avg(mem_mileage) from member)
and mem_memorial = '��ȥ�����'  ;

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
where mem_name = '��ö��')));

select b.buyer_name,  b.buyer_comtel 
from prod p, buyer b, member m, cart c
where p.prod_buyer = b.buyer_id
and c.cart_prod =  p.prod_id
and m.mem_name = '��ö��'
and p.prod_name like '%TV%'
