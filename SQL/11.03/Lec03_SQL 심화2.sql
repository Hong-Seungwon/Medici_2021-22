use sakila;
desc customer;
-- 활성화 고객만 대여횟수 반환
select c.first_name, c.last_name, 
case
	when c.active=0 then 0
    else (select count(*) from rental r
		where r.customer_id=c.customer_id)
    end num_rentals
from customer c;

-- 2005년 5월 6월 7월 영화 대여횟수
select monthname(rental_date) rental_month,
count(*) num_rentals
from rental
where rental_date between '2005-05-01' and '2005-08-01'
group by monthname(rental_date);
-- May, June, July
select 
(case when monthname(rental_date) = 'May' then 1
else 0 end) May,
(case when monthname(rental_date) = 'June' then 1
else 0 end) June,
(case when monthname(rental_date) = 'July' then 1
else 0 end) July
from rental
where rental_date between '2005-05-01' and '2005-08-01';

select 
sum(case when monthname(rental_date) = 'May' then 1
else 0 end) May,
sum(case when monthname(rental_date) = 'June' then 1
else 0 end) June,
sum(case when monthname(rental_date) = 'July' then 1
else 0 end) July
from rental
where rental_date between '2005-05-01' and '2005-08-01';

select * 
from book
where bookname like '%축구%';

create view vw_Book as
select *
from book
where bookname like '%축구%';

select * from vw_book;

drop view vw_book;

-- Orders 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰
create view vw_orders(orderid, custid, name,
bookid, bookname, saleprice, orderdate) as
select o.orderid, o.custid, c.name,
o.bookid, b.bookname, o.saleprice, o.orderdate
from orders o 
	inner join customer c
    on o.custid=c.custid
    inner join book b
    on o.bookid=b.bookid;
    
select * from vw_orders;

select orderid, bookname, saleprice
from vw_orders
where name = '김연아';
    
create or replace view  revw_orders(orderid, custid, name,
bookid, bookname, saleprice, orderdate) as
select o.orderid, o.custid, c.name,
o.bookid, b.bookname, o.saleprice, o.orderdate
from orders o 
	inner join customer c
    on o.custid=c.custid
    inner join book b
    on o.bookid=b.bookid;
    
    