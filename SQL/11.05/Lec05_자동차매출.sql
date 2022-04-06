use sakila;

select count(*)
from rental;

select * from rental
into outfile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/rental.csv"
fields terminated by ','
lines terminated by '\n';

create database mydata;
use mydata;

create database instacart;
use instacart;

-- 자동차 매출
-- 1)-1 일별 매출액 조회
    select orderDate, sum(priceEach * quantityOrdered) price
from orders
	inner join orderdetails
    on orders.orderNumber=orderdetails.orderNumber
    group by 1
    order by 1;


select orderDate, priceEach * quantityOrdered price
from orders
	inner join orderdetails
    on orders.orderNumber=orderdetails.orderNumber;

 
desc orders;

-- 1)-2 월별 매출액 조회
    select substr(orderDate,1,7) MM, sum(priceEach * quantityOrdered) price
from orders
	inner join orderdetails
    on orders.orderNumber=orderdetails.orderNumber
    group by 1
    order by 1;
    
    select substr('2003-05-07',1,7);
    
-- 1)-3 연도별 매출액 조회
select substr(orderDate,1,4) YY, sum(priceEach * quantityOrdered) price
from orders
	inner join orderdetails
    on orders.orderNumber=orderdetails.orderNumber
    group by 1
    order by 1;

select substr('2003-05-07',1,4);

-- 2)-1 구매자 수, 구매 건수(일자별, 월별, 연도별)
-- 일자별
select orderDate, count(distinct customerNumber) num_purchaser,
count(orderNumber) num_orders
from orders
group by 1 order by 1;

-- 월별
select substr(orderDate,1,7) 'YY-MM', count(distinct customerNumber) num_purchaser,
count(orderNumber) num_orders
from orders
group by 1 order by 1;

-- 연도별
select substr(orderDate,1,4) YY, count(distinct customerNumber) num_purchaser,
count(orderNumber) num_orders
from orders
group by 1 order by 1;

-- 3)-1 인당 매출액 (연도별)
select substr(orderDate,1,4) YY, count(distinct customerNumber) num_purchaser,
sum(priceEach * quantityOrdered) sales, 
sum(priceEach * quantityOrdered)/count(distinct customerNumber) AMV
from orders
	inner join orderdetails
    on orders.orderNumber=orderdetails.orderNumber
group by 1 order by 1;


select substr(orderDate,1,4) YY, count(distinct customerNumber) num_purchaser, sum(priceEach * quantityOrdered) sales
from orders
	inner join orderdetails
    on orders.orderNumber=orderdetails.orderNumber
group by 1 order by 1;



-- 3)-2 건당 구매 금액 (연도별)
select substr(orderDate,1,4) YY, count(distinct orders.orderNumber) num_purchaser,
sum(priceEach * quantityOrdered) sales, 
sum(priceEach * quantityOrdered)/count(distinct orders.orderNumber) ATV
from orders
	inner join orderdetails
    on orders.orderNumber=orderdetails.orderNumber
group by 1 order by 1;


-- 4) 그룹별 구매 지표 구하기
-- 1. 국가별, 도시별 매출액
select c.country, c.city, sum(priceEach*quantityOrdered) sales
from orders a
	inner join orderdetails b
    on a.orderNumber=b.orderNumber
    inner join customers c
    on a.customerNumber=c.customerNumber
group by 1,2;

select case when country in('USA', 'Canada') then 'North America'
else 'Others' end county_grp
from customers;

select c.country, c.city, sum(priceEach*quantityOrdered) sales
from orders a
	inner join orderdetails b
    on a.orderNumber=b.orderNumber
    inner join customers c
    on a.customerNumber=c.customerNumber
group by 1,2 order by 3 desc;

-- 2. 북미 vs 미북미 매출액 비교
select case when country in('USA', 'Canada') then 'North America'
else 'Others' end county_grp,
sum(priceEach*quantityOrdered) sales
from orders a
	inner join orderdetails b
    on a.orderNumber=b.orderNumber
    inner join customers c
    on a.customerNumber=c.customerNumber
group by 1 order by 2 desc;


-- 3. 매출 Top 5	국가 및 매출
create table stat as
select c.country, sum(priceEach*quantityOrdered) sales
from orders a
	inner join orderdetails b
    on a.orderNumber=b.orderNumber
    inner join customers c
    on a.customerNumber=c.customerNumber
group by 1 order by 2 desc;

select country, sales, dense_rank() over(order by sales desc) rnk
from stat;

create table stat_rnk as
select country, sales, dense_rank() over(order by sales desc) rnk
from stat;
select * 
from stat_rnk
where rnk between 1 and 5;

-- 4. 국가별 product 및 매출
select c.country, sum(d.buyPrice) sales
from orders a
	inner join orderdetails b
    on a.orderNumber=b.orderNumber
    inner join customers c
    on a.customerNumber=c.customerNumber
    inner join products d
    on b.productCode=d.productCode
group by 1 order by 2 desc;

-- 5) 재구매율
select a.customerNumber, a.orderdate, b.customerNumber, b.orderdate
from orders a
	inner join orders b
    on a.customerNumber=b.customerNumber and substr(a.orderdate,1,4)=substr(b.orderdate,1,4) -1;

-- 6) Best Seller
create table product_sales as
select d.productname, sum(priceEach*quantityordered) sales
from orders a
	inner join customers b
    on a.customerNumber=b.customerNumber
    inner join orderdetails c
    on a.orderNumber=c.orderNumber
    inner join products d
    on c.productCode=d.productCode
where b.country='USA'
group by 1;

select *
from (select *, row_number() over(order by sales desc) rnk
from product_sales) A
where rnk<=5
order by rnk;

-- 7) Churn Rate(%)
create table churn_list as
select case when diff >= 90 then 'churn' else 'non-churn' end churn_type,
customernumber
from(select customernumber, mx_order,'2005-06-01' end_point, datediff('2005-06-01',mx_order) diff
from(select customernumber,max(orderdate) mx_order
from orders
group by 1) base) base;

select d.churn_type, c.productline, count(distinct b.customernumber) bu
from orderdetails a
	inner join orders b
    on a.orderNumber=b.orderNumber
    inner join products c
    on a.productCode=c.productCode
    inner join churn_list d
    on b.customerNumber=d.customernumber
group by 1,2 order by 1,3 desc;
