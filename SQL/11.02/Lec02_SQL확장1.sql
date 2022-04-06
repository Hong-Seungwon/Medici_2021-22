select 10+10;
-- sum(sum(10,10),10)
select bookname
from book
where price=(select 3000+3000);

select max(price)
from book;

select	bookname
from book
where price=35000;

select	bookname
from book
where price=(select max(price)
from book);

-- 도서를 구매한 적이 있는 고객의 이름을 검색
select distinct custid
from orders; -- 1,2,3,4

select name from customer
where custid in(1,2,3,4);

select name from customer
where custid in(select distinct custid from orders);

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름
select *
from book
where publisher='대한미디어';

-- bookid 3,4
select *
from orders
where bookid in (3,4);

-- custid 1
select * 
from customer
where custid=1;

select custid
from orders
where bookid in (select bookid
from book
where publisher='대한미디어');

select * 
from customer
where custid in(1);

select *
from customer
where custid in (select custid
from orders
where bookid in (select bookid
from book
where publisher='대한미디어'));

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서
desc book;
select avg(price), publisher
from book
group by publisher;

select bookname
from book
where price >=13000 and publisher='나무수';

select *
from book b1
where price > (
select avg(price)
from book b2
where b2.publisher = b1.publisher);

use sakila;
desc customer;
select max(customer_id)
from customer; -- 599
select customer_id, first_name, last_name
from customer
where customer_id=599;

select city_id, city from country;
select *from country
where country in('Canada', 'Mexico');

-- 무료 영화를 대여한 적이 없는 모든 고객

desc payment;
select customer_id
from payment
where amount=0;

select first_name, last_name
from customer
where customer_id not in (
select customer_id
from payment
where amount=0);

-- 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름
select name
from Customer
where address like '대한민국%' 
union
select name
from customer
where custid in(select distinct custid
from orders);

use sakila;
desc customer;
desc address;
desc city;
select c.first_name, c.last_name, a.address
from customer c, address a
where c.address_id=a.address;

select c. first_name, c.last_name, a.address, a.postal_code
from customer c
	inner join address a
    on c.address_id=a.address_id
where a.postal_code=52137;

select c. first_name, c.last_name, ct.city
from customer c
	inner join address a
    on c.address_id=a.address_id
    inner join city ct
    on a.city_id=ct.city_id;
    
-- 두 명의 특정 배우가 출연한 영화 제목 모두 검색
desc film_actor;
desc actor;
desc film;
-- Cate McQueen, Cuba Birch
select f.title, a.first_name, a.last_name
from film f
	inner join film_actor fa
    on f.film_id=fa.film_id
    inner join actor a
    on fa.actor_id=a.actor_id
where ((a.first_name='CATE' and a.last_name='MCQUEEN') or
(a.first_name='CUBA' and a.last_name='BIRCH'));


select f.title, a1.first_name, a2.first_name
from film f
	inner join film_actor fa1
    on f.film_id=fa1.film_id
    inner join actor a1
    on fa1.actor_id=a1.actor_id
    inner join film_actor fa2
    on f.film_id=fa2.film_id
    inner join actor a2
    on fa2.actor_id=a2.actor_id
where ((a1.first_name='CATE' and
		a1.last_name='MCQUEEN') and
		(a2.first_name='CUBA' and 
        a2.last_name='BIRCH'));

-- 영화 대여에 지불 금액 기준으로 고객을 그룹화한다.
-- Small Fry 0 ~ 74.99
-- Average Joes 75 ~ 149.99
-- Heavy Hitters 150 ~ 9,999,999.99

select 'Small Fry' name, 0 low_limit, 74.99 high_limit
union
select 'Average Joes' name, 75 low_limit, 149.99 high_limit
union
select 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit;

-- 고객 그룹별 

select customer_id, sum(amount)
from payment
group by customer_id;

select mygroup.name, count(*) 
from (select customer_id, sum(amount) total
from payment
group by customer_id) mypayment
inner join
(select 'Small Fry' name, 0 low_limit, 74.99 high_limit
union
select 'Average Joes' name, 75 low_limit, 149.99 high_limit
union
select 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit)
mygroup
on mypayment.total between mygroup.low_limit and mygroup.high_limit
group by mygroup.name;