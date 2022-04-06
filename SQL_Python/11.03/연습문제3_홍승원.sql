-- (1) 다음 내장 함수의 결과를 적으시오.
select ABS(-15); -- 15
select CEIL(15.7); -- 16
select COS(3.14159); -- -0.9999999999964793
select FLOOR(15.7); -- 15
select LOG(10.100); -- 2.312535423847214
select MOD(11,4); -- 3
select POWER(3,2); -- 9
select ROUND(15.7); -- 16
select SIGN(-15); -- -1
select TRUNC(15.7); -- x
select CHAR(67 USING utf8); -- C
select CONCAT('HAPPY', 'Birthday'); -- HAPPYBirthday
select LOWER('Birthday'); -- birthday
select LPAD('Page', 15, '*.'); -- *.*.*.*.*.*Page
select REPLACE('JACK', 'J', 'BL'); -- BLACK
select RPAD('Page', 15, '*.'); -- Page*.*.*.*.*.*
select SUBSTR('ABCDEFG', 3, 4); -- CDEF
select TRIM(LEADING 0 FROM '00AA00'); -- AA00
select UPPER('Birthday'); -- BIRTHDAY
select ASCII('A'); -- 65
select LENGTH('Birthday'); -- 8
select ADDDATE('2019-02-14', INTERVAl 10 DAY); -- 2019-02-24
select LAST_DAY(SYSDATE()); -- 2021-11-30
select NOW(); -- 2021-11-03 14:19:59
select DATE_FORMAT(SYSDATE(), '%Y'); -- 2021
select CONCAT(123); -- 123
select STR_TO_DATE('12 05 2014', '%d %m %Y'); -- 2014-05-12
select CAST('12.3' AS DECIMAL(3,1)); -- 12.3
select IF(1=1, 'aa', 'bb'); -- aa
select IFNULL(123, 456); -- 123
select IFNULL(NULL, 456); -- 456

-- (2)-1 Mybook 테이블을 생성하고 NULL에 관한 다음 SQL 문에 답하시오. 
--  질의의 결과를 보면서 NULL에 대한 개념을 정리해보시오

CREATE TABLE Mybook (
  bookid INTEGER,
  price INTEGER 
);
-- Mybook 데이터 생성
INSERT INTO Mybook VALUES(1, 10000);
INSERT INTO Mybook VALUES(2, 20000);
INSERT INTO Mybook VALUES(3, NULL);
COMMIT;

select * from mybook;
select bookid, ifnull(price,0) from mybook;
select * from mybook where price is null;
select * from mybook where price='';
select bookid, price+100 from mybook;
select sum(price), avg(price), count(*) from mybook where bookid>=4;
select count(*), count(price) from mybook;
select sum(price), avg(price) from mybook;

-- (2)-2 MySQL의 행번호를 처리하는 다음의 SQL 문에 답하시요. 데이터는 마당서점 데이터베이스를 이용
select * from book;

select *, @RNUM:=@RUM+1 as ROWNUM 
from book, (select @RNUM:=0) R
where @RNUM<5;

select *, @RNUM:=@RUM+1 as ROWNUM 
from book, (select @RNUM:=1) R
where @RNUM<=5;

select *, @RNUM:=@RUM+1 as ROWNUM 
from (select * from book order by price) b, 
(select @RNUM:=0) R
where @RNUM<5;

select *, @RNUM:=@RUM+1 as ROWNUM 
from (select * from book where @RNUM<=5) b, 
(select @RNUM:=0) R
order by price;

select *, @RNUM:=@RUM+1 as ROWNUM 
from (select * from book where @RNUM<=5 order by price) b, 
(select @RNUM:=0) R;

-- (3) 부속질의에 관한 다음 SQL 문을 수행해보고 어떤 질의에 대한 답인지 설명하시오
 select custid, (select address
				from customer cs
                where cs.custid=od.custid)"address",
					sum(saleprice)"total"
from orders od
group by od.custid; 
-- 1	영국 맨체스타	39000
-- 2	대한민국 서울	15000
-- 3	대한민국 강원도	31000
-- 4	미국 클리블랜드	33000

select cs.name, s
from (select custid, avg(saleprice)s
		from orders 
        group by custid) od, customer cs
where cs.custid=od.custid;
-- 박지성	13000.0000 
-- 김연아	7500.0000
-- 장미란	10333.3333
-- 추신수	16500.0000

select sum(saleprice)"total"
from orders od
where exists (select *
				from customer cs
                where custid <=3 and cs.custid = od.custid); -- 85000
                
-- (4)-1 다음 테이블의 정의와 데이터를 사용해서 고객의 총 지물액과 함께 고객 이름을 반환하는 쿼리를 작성하시오. 
-- 해당 고객에 대한 지물 기록이 없는 경우 모든 고객을 포함 한다.
select concat(c.first_name," ", c.last_name) Name, sum(p.amount) Amount
from payment p
	inner join customer c
    on p.customer_id = c.customer_id
group by p.customer_id;

-- (4)-2 다른 외부 조인 유형을 사용하도록 1)쿼리를 재구성하세요. 
-- 예를 들어 외쪽 외부 조인을 사용했다면, 오른쪽 외부 조인을 사용해 보세요. 결과는 1)번과 같아야 한다.
select concat(c.first_name," ", c.last_name) Name, sum(p.amount) Amount
from customer c
	right outer join payment p
    on p.customer_id = c.customer_id
group by p.customer_id;

-- (4)-3 {1, 2, 3, ..., 99, 100} 집합을 생성하는 쿼리를 작성하시오. 
-- 이때 적어도 2개 이상의 from 절 서브쿼리를 가지고 교차 조인을 사용한다.
SELECT ones.num + tens.num + 1 as NUM
 FROM
 (SELECT 0 num UNION ALL
 SELECT 1 num UNION ALL
 SELECT 2 num UNION ALL
 SELECT 3 num UNION ALL
 SELECT 4 num UNION ALL
 SELECT 5 num UNION ALL
 SELECT 6 num UNION ALL
 SELECT 7 num UNION ALL
 SELECT 8 num UNION ALL
 SELECT 9 num) ones
 CROSS JOIN
 (SELECT 0 num UNION ALL
 SELECT 10 num UNION ALL
 SELECT 20 num UNION ALL
 SELECT 30 num UNION ALL
 SELECT 40 num UNION ALL
 SELECT 50 num UNION ALL
 SELECT 60 num UNION ALL
 SELECT 70 num UNION ALL
 SELECT 80 num UNION ALL
 SELECT 90 num) tens
 order by NUM;

-- (5)-1 검색된 case 표현식으로 동일한 결과를 얻을 수 있도록, 단순 case 표현식을 사용하는 다음 쿼리를 다시 작성하시오, 
-- 최대한 when 절을 적게 사용하시오.
SELECT name,
CASE name
WHEN 'English' THEN 'latin1'
WHEN 'Italian' THEN 'latin1'
WHEN 'French' THEN 'latin1'
WHEN 'German' THEN 'latin1'
WHEN 'Japanese' THEN 'utf8'
WHEN 'Mandarin' THEN 'utf8'
ELSE 'Unknown'
END character_set
FROM language;

select name,
case  
when language.name in('English', 'Italian', 'French', 'German') then 'utf8'
when language.name in('Japanese', 'Mandarin') then 'latin1'
else 'Unknown'
end character_set
from language;


-- (5)-2 5개의 열이 있는 하나의 행을 결과 셋에 표시하도록 다음 쿼리를 다시 작성 하시오. 
-- G, PG, PG_13, R, and NC_17.
SELECT rating, count(*)
FROM film
GROUP BY rating;

SELECT
sum(CASE WHEN rating = 'G' THEN 1
 ELSE 0 END) G,
sum(CASE WHEN rating= 'PG' THEN 1
 ELSE 0 END) PG,
sum(CASE WHEN rating = 'PG-13' THEN 1
 ELSE 0 END) 'PG-13',
sum(CASE WHEN rating = 'R' THEN 1
 ELSE 0 END) R,
 sum(CASE WHEN rating = 'NC-17' THEN 1
 ELSE 0 END) 'NC-17'
FROM film;


-- (6)-1 판매가격이 20,000원 이상인 도서의 도서번호, 도서이름, 고객이름, 출판사, 판매가격을 보여주는 highorders 뷰를 생성하시오.
create view highorders as
select b.bookid, b.bookname, c.name, b.publisher, o.saleprice
from book b
	inner join orders o
    on b.bookid=o.bookid
    inner join customer c
    on o.custid=c.custid
    where o.saleprice >= 20000;

select * from highorders;

-- (6)-2 생성한 뷰를 이용하여 판매된 도서의 이름과 고객의 이름을 출력하는 SQL 문을 작성하시오.
select bookname, name
from highorders;

-- (6)-3 highorders 뷰를 변경하고자 한다. 판매가격 속성을 삭제하는 명령을 수행하시오. 삭제 후 (2)번 SQL 문을 다시 수행하시오.
create or replace view highorders(bookid, bookname, name, publisher) as
select b.bookid, b.bookname, c.name, b.publisher
from book b
	inner join orders o
    on b.bookid=o.bookid
    inner join customer c
    on o.custid=c.custid
    where o.saleprice >= 20000;
    
select bookname, name
from highorders;