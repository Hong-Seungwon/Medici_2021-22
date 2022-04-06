-- (1) 주문하지 않은 고객의 이름(부속질의 사용)
select name
from customer
where custid not in(select custid
from orders);

-- (2) 주문 금액의 총액과 주문의 평균 금액
select sum(saleprice), avg(saleprice)
from orders;

-- (3) 고객의 이름과 고객별 구매액
select c.name, sum(o.saleprice)
from orders o
	inner join customer c
    on o.custid=c.custid
group by c.name
order by c.name; 

-- (4) 고객의 이름과 고객이 구매한 도서 목록
select c.name, b.bookname
from orders o
	inner join customer c
    on o.custid=c.custid
    inner join book b
    on o.bookid=b.bookid;
    
-- (5) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
select max(b.price-o.saleprice)
from orders o
	inner join book b
	on o.bookid=b.bookid;  

-- (6) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
select c.name
from customer c
	inner join orders o
    on c.custid=o.custid
group by c.name
having avg(o.saleprice) > (
	select avg(o1.saleprice)
	from orders o1);