-- (1) 마당서점 도서의 총 개수
select count(bookid)
from book;
-- (2) 마당서점에 도서를 출고하는 출판사의 총 개수
select count(distinct(publisher))
from book;
-- (3) 모든 고객의 이름, 주소
select name, address
from customer;
-- (4) 2014년 7월 4일~7월 7일 사이에 주문 받은 도서의 주문번호
select orderid
from orders
where orderdate between '2014-07-04' and '2014-07-07';
-- (5) 2014년 7월 4일~7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호
select orderid
from orders
where orderdate not between '2014-07-04' and '2014-07-07';
-- (6) 성이 ‘김’ 씨인 고객의 이름과 주소
select name, address
from customer
where name like '김%';
-- (7) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소
select name, address
from customer
where name like '김%아';