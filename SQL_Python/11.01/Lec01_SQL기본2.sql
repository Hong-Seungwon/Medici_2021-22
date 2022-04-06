
use bookstore;

-- 가격이 10000원 20000원 책
select	*
from book
where price>=10000 and price<=20000;

select * from book
where price between 10000 and 20000;

select * from book
where publisher='굿스포츠' or 
publisher='대한미디어';

select * from book
where publisher in('굿스포츠', '대한미디어');

select * from book
where publisher not in('굿스포츠', '대한미디어');

select bookname, publisher
from book
where bookname like '축구의 역사';

select bookname, publisher
from book
where bookname like '%의 %';

select *
from book
order by price desc, publisher asc;

select *
from orders;

select sum(saleprice) as total
from orders
where custid=2;

select sum(saleprice) as total,
avg(saleprice) as average,
min(saleprice) as mininum,
max(saleprice) as maxinum
from orders;

select count(*)
from orders;

-- 고객별 총 수량, 총 판매액
select custid, count(*) as 도서수량,
sum(saleprice) as 총액
from orders
group by custid;

select custid, count(*)
from orders
where saleprice>=8000
group by custid
having count(*)>=2;

use sakila;
select customer_id, count(*)
from rental
-- where count(*)>=40
group by customer_id
having count(*)>=40
order by 2 desc;

describe payment;
select *
from payment;

select count(customer_id),
count(distinct customer_id)
from payment;

describe rental;

select max(datediff(return_date,rental_date))
from rental;