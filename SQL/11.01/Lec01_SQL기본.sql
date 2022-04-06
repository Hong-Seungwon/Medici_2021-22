select * from book;
select bookid, bookname
from book;

select publisher, price, bookname
from book
where bookname like '축구의%';

select * from customer;

select phone from customer
where name='김연아';

use sakila;

select customer_id, first_name
from customer
where last_name ='Smith';

select * from language;

select language_id, last_update, name
from language;

select name from language;

select upper(name), language_id*3.14
from language;
create or replace view vlanguage as
select upper(name) upper_name, 
language_id*3.14 lang_pi_value
from language;
select * from vlanguage;

select title
from film
where rating='G' and rental_duration >=7;

-- G 이고 7일 이상, 이거나 PG-13 3일 이하인 영화
select title, rating, rental_duration
from film
where (rating='G' and rental_duration >=7) 
or (rating='PG-13' and rental_duration <4);

-- 40편 이상의 영화를 대여한 모든 고객
select customer.first_name, customer.last_name, count(*)
from customer
    inner join rental
    on customer.customer_id = rental.customer_id
    group by customer.first_name, customer.last_name
    having count(*) >= 40;
    
-- 2005년 6월14일에 영화를 대여한 모든 고객 목록을 검색
select customer.first_name, customer.last_name, time(rental.rental_date)
from customer 
    inner join rental
    on customer.customer_id = rental.customer_id
where date(rental.rental_date)='2005-06-14'
order by customer.last_name;

