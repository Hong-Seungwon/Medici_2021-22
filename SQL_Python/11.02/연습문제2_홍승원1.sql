-- (1) 박지성이 구매한 도서의 출판사 수
desc book;
desc customer;
desc orders;

select count('publisher')
from book
where bookid in(select bookid
				from orders
                where custid in(select custid
								from customer
                                where custid=1));

-- (2) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select bookname, price, b.price-o.saleprice
from orders o
	inner join customer c
    on o.custid=c.custid
    inner join book b
    on  o.bookid=b.bookid
    where o.custid=1;

-- (3) 박지성이 구매하지 않은 도서의 이름
select bookname
from book
where bookid not in(select bookid
				from orders
                where custid in(select custid
								from customer
                                where name='박지성'));