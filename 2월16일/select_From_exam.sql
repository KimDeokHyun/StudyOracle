/*
[����] Group by, AVG
���ų���(��ٱ���) �������� ȸ�� ���̵𺰷� ���ż����� ���� ����� ��ȸ
ȸ�� ���̵� �������� �������� */

select cart_member ���ID, avg(cart_qty) ��ձ��ż���
    from cart
    group by cart_member
    order by cart_member;
    
/*
[����] round,avg
��ǰ�������� �ǸŰ����� ��� ���� ���϶�.
��, ��հ��� �Ҽ��� 2���� ǥ��. */
select prod_name, round(avg(prod_sale),2) avg
    from prod;
    
/*
[����] round,avg,group_by
��ǰ�������� ��ǰ�з��� �ǸŰ����� ��հ��� ���϶�
��ȸ : ��ǰ�з��ڵ�, ��ǰ�з��� �ǸŰ����� ���
��, ��հ��� �Ҽ��� 2���� ǥ��. */
select prod_lgu, round(avg(prod_sale),2) avg
    from prod
    group by prod_lgu;

/* 
[����]
ȸ�����̺��� ������� ���� count ����*/
select count(distinct mem_like)
    from member;

/* 
[����]
ȸ�����̺��� �������� ���� count ����*/
select count(distinct mem_job) ����
    from member;

/*
[����]
ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ����
���̵�, �̸�, ���ϸ����� ��ȸ�� �ּ���.
������ ���ϸ��� �������� */

select mem_id, mem_name, mem_mileage
    from member
    where mem_mileage >=(select avg(mem_mileage) from member)
    order by mem_mileage;

/* ��ٱ������̺��� ȸ���� �ִ뱸�ż����� �˻��Ͻÿ�
 ȸ��id, �ִ����, �ּҼ���*/
select cart_member ȸ��id,
    max(distinct cart_qty) "�ִ����(distinct)",
    max(cart_qty)�ִ����,
    min(distinct cart_qty)"�ּҼ���(distinct)",
    min(cart_qty)�ּҼ���
    from cart
    group by cart_member;

/*  2000�⵵ 7�� 11���̶� �����ϰ� ��ٱ������̺� �߻��� �߰��ֹ���ȣ�� �˻�
�ְ�ġ�ֹ���ȣ, �߰��ֹ���ȣ) */
select max(cart_no), MAX(cart_no) + 1
    from cart
WHERE cart_no like '20050711%';

/*
[����]
������������ �⵵���� �Ǹŵ� ��ǰ�� ����, ��ձ��ż����� ��ȸ�Ϸ� �Ѵ�.
������ �⵵�� �������� ��������. */
select count(cart_prod), avg(count(cart_prod))
    from cart
    group by cart_no
order by cart_no; */

/*
[����]
������������ �⵵��, ��ǰ�з��ڵ庰 ��ǰ�� ������ ��ȸ�Ϸ��� �Ѵ�.
(��ǰ ������ count) ������ �⵵ ���� ��������*/

select substr(cart_no,1 ,4 ) as yyyy, 
        substr(cart_prod,1 ,4 ) as ��ǰ�з��ڵ�,
        count(cart_qty) as count_qty
from cart
group by substr(cart_no,1 ,4 ) ,substr(cart_prod,1 ,4 )
order by yyyy desc;

/*
[����]
ȸ�����̺��� ȸ����ü�� ���ϸ������, ���ϸ��� �հ�, �ְ� ���ϸ���,
�ּҸ��ϸ���, �ο�� �˻�
(���ϸ��� ���, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ο���)*/
select round(avg(mem_mileage),2) avg, sum(mem_mileage) sum,
        max(mem_mileage) max, min(mem_mileage) min, count(mem_mileage) count        
from member;

/*
[����]
��ǰ���̺��� ��ǰ�з���, �ǸŰ���ü�� ���, �հ�, �ְ� ��, ���� ��, �ڷ� �� �˻�
(���, �հ�, �ְ�, ������, �ڷ��)*/
select prod_lgu, round(avg(prod_sale),2) avg, sum(prod_sale) sum,
        max(prod_sale) max, min(prod_sale) min, count(prod_sale) count        
from prod
group by prod_lgu
having count(prod_lgu) >=20;

/*ȸ�����̺��� ����(�ּ�1�� 2�ڸ�), ���ϳ⵵���� ���ϸ������ ���ϸ����հ�
�ְ� ���ϸ���, �ּҸ��ϸ���, �ڷ���� �˻� */

select substr(mem_add1,1,2) ����,
        to_char(mem_bir,'yyyy' ) ����,
        round(avg(mem_mileage),2) ���ϸ������,
        sum(mem_mileage) ���ϸ����հ�,
        max(mem_mileage) �ְ��ϸ���,
        min(mem_mileage) �ּҸ��ϸ���,
        count(mem_mileage) �ڷ��        
    from member
    group by substr(mem_add1,1,2),
        to_char(mem_bir,'yyyy' );

--�ŷ�ó ����� ������ '��' �̸� NULL�� ����
UPDATE buyer set buyer_charger = NULL
WHERE buyer_charger like '��%';

--�ŷ�ó ����ڰ� ������ '��' �̸� white space�� ����
update buyer set buyer_charger = ' '
where buyer_charger like '��%';

--Null�� ��
select buyer_name �ŷ�ó, buyer_charger�����
from buyer
where buyer_charger_null;

--ȸ�� ���ϸ����� 100�� ���� ��ġ�� �˻�
--NVL���, ����, ���ϸ���, ���渶�ϸ���

--ȸ�����ϸ����� ������ '����ȸ��' Null�̸� '������ȸ��'
select mem_name, mem_mileage,
        nvl2(mem_mileague, '����','������') as mileague_null
    from member;

--DECODE

select decode(9,10,'A',9,'B',8,'C','D')
    from dual;
    
        
select decode(substr(prod_lgu,1,2),
        'P1','��ǻ��/���� ��ǰ',
        'P2',' �Ƿ�',
        'P3', '��ȭ', '��Ÿ')
        from prod;
        
--�Լ�
--��ǰ�з��� ���� �α��ڰ� 'P1'�̸� �ǸŰ��� 10%�λ��ϰ�
--'P2'�� 15%�λ�, �������� ���� �ǸŰ��� �˻�
--(decode�Լ� ���, ��ǰ��,�ǸŰ�,�����ǸŰ�)
select prod_name as ��ǰ��,
        prod_sale �ǸŰ�,
        decode(substr(prod_lgu,1,2),
            'P1',prod_sale*1.1,
            'P2',prod_sale*1.15) as new_sale    
from prod;

--ȸ���������̺��� �ֹε�� ���ڸ�(7�ڸ� �� ù°�ڸ�)���� ���� ������ �˻��Ͻÿ�
--Case ���� ���, (ȸ����, �ֹε�Ϲ�ȣ(�ֹ�1-�ֹ�2),����)
select mem_name �̸�,
        mem_regno1|| '-' ||mem_regno2 �ֹε�Ϲ�ȣ,
        case
            when substr(mem_regno2,1,1) = 1 
            then '����'
            else
            '����'
            end as mf
            from member;

--decode�������
select mem_name �̸�,
        mem_regno1|| '-' ||mem_regno2 �ֹε�Ϲ�ȣ,
        decode(substr(mem_regno2,1,1),1,'����','����') ����
        from member;

select substr(mem_name,1,1) ||'**' �̸�,
	mem_id ���̵�,
	mem_bir ����,
	mem_mail,
	'***-***-' || substr(mem_hp,9,4)
from member;
---------------------------------------------
/*����
Ȧ���޿� ���ŵ��� ���� ��ǰ���� Ȯ���ϰ�
��Ź���ǰ� �ƴ� ��ǰ���� 
��ǰ�� id, �̸�, ������(���ͷ�)�� ���ۼ�Ʈ���� ���϶�.
�������� ������ ���� 10%�� �߰��Ͽ� �Է��ϰ�, 
�������� ���� ���� ���� 10%�� �����Ͽ� �Է��϶�.
������ ��ǰ��, ��ǰ������� �����϶�. */



select prod_id ID,
	prod_name �̸�,
decode (prod_sale-prod_cost,
            (select min(prod_sale-prod_cost) from prod),
            (prod_sale-prod_cost)*1.1,
            (select max(prod_sale-prod_cost) from prod),
            (prod_sale-prod_cost)*0.9,
            prod_sale-prod_cost) as margin
from prod
where mod(to_number(substr(prod_insdate,4 ,2 ) ),2)=0
and prod_delivery != '��Ź����'
order by prod_lgu, prod_name;

select substr(prod_insdate,4 ,2)
from prod;