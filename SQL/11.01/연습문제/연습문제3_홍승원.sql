--  (1) 도서번호가 1인 도서의 이름
select bookname
from book
where bookid=1;
--  (2) 가격이 20,000원 이상인 도서의 이름
select bookname
from book
where price >=20000;
--  (3) 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
select	sum(saleprice) as '박지성의 총 구매액'
from orders
where custid=1;
--  (4) 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)
select count(bookid) as '박지성이 구매한 도서의 수'
from orders
where custid=1;
