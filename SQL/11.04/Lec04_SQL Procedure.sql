delimiter $$
create procedure userProc()
begin
	select * from customer;
end $$
delimiter ;

call userProc();

select * from customer where name='김연아';

delimiter $$
create procedure userProc1(in userName varchar(40))
begin
	select * from customer where name=userName;
end $$
delimiter ;
desc customer;
call userProc1('조용필');

desc book;
select * from book;

insert into book(bookid, bookname, publisher, price)
values('12', '스포츠과학', '한국출판사', 23000);

delimiter $$
create procedure InsertBook(
	in myBookID integer,
    in myBookName varchar(40),
    in myPublisher varchar(40),
    in myPrice integer
)
begin
	insert into book(bookid, bookname, publisher, price)
	values(myBookID, myBookName, myPublisher, myPrice);
end $$
delimiter ;

call InsertBook('13', '수학이야기', '한국출판사', 12000);
call InsertBook('14', 'ㅇㅇㅇ', 'ㅇㅇㅇ', 15000);

delimiter $$
create procedure BookInsertOrUpdate(
	in myBookID integer,
    in myBookName varchar(40),
    in myPublisher varchar(40),
    in myPrice integer
)
begin
declare mycount integer;
select count(*) into mycount from book
	where bookname like myBookName;
if mycount!=0 then
	set SQL_SAFE_UPDATES=0;
    update book set price=myPrice
	where bookname like myBookName;
    set SQL_SAFE_UPDATES=1;
    else
	insert into book(bookid, bookname, publisher, price)
	values(myBookID, myBookName, myPublisher, myPrice);
    end if;
end $$
delimiter ;


select count(*) from book
where bookname like '야구의 추억';
select * from book
where bookname like '야구의 추억';
update book set price=7000
where bookname like '야구의 추억';
select * from book;
call BookInsertOrUpdate(14, '야구의 추억', '한국출판사', 13000);
call BookInsertOrUpdate(16, '배구의 추억', '프랑스출판사', 5000);

-- 결과 리턴을 하는 프로시저
-- Book 테이블에 저장된 도서의 평균가격을 반환
delimiter $$
create procedure AveragePrice(out averageVal integer)
begin
	select avg(price) into  averageVal from book where price is not null;
end $$
delimiter ;

show procedure status;
call AveragePrice(@myResult);
select @myResult;

select avg(price) from book where price is not null;
insert into book value(100, 'aaa', 'aaa', null);
select avg(price) from book;

create table if not exists testTBL(
	id int auto_increment primary key,
    txt char(10)
);
desc testtbl;

delimiter $$
create procedure testTBLInsert(
	in txtValue char(10),
    out outValue int
)
begin
	insert into testtbl value(null, txtValue);
	select max(id) into outValue from testtbl;
end $$
delimiter ;

insert into testtbl value(null, '연습이오');
select max(id) from testtbl;
show procedure status;

call testTBLInsert('test test', @myValue);
select concat('현재 입력된 ID :', @myValue) result;

delimiter //  
CREATE PROCEDURE Interest()
BEGIN
  DECLARE myInterest INTEGER DEFAULT 0.0;
  DECLARE Price INTEGER;
  DECLARE endOfRow BOOLEAN DEFAULT FALSE; 
  DECLARE InterestCursor CURSOR FOR 
	SELECT saleprice FROM Orders;
  DECLARE CONTINUE handler 
	FOR NOT FOUND SET endOfRow=TRUE;
  OPEN InterestCursor;
  cursor_loop: LOOP
    FETCH InterestCursor INTO Price;
    IF endOfRow THEN LEAVE cursor_loop; 
    END IF;
    IF Price >= 30000 THEN 
        SET myInterest = myInterest + Price * 0.1;
    ELSE 
        SET myInterest = myInterest + Price * 0.05;
    END IF;
  END LOOP cursor_loop;
  CLOSE InterestCursor;
  SELECT CONCAT(' 전체 이익 금액 = ', myInterest);
END;
//
delimiter ;

call interest();

use sqldb;
desc usertbl;
desc buytbl;
alter table usertbl add grade varchar(5);


select u.userID, u.name, sum(price * amount)
from usertbl u
	left outer join buytbl b
    on u.userid=b.userid
group by u.userid, u.name;

select u.userID, u.name, sum(price * amount) total,
(case when (sum(price*amount)>0) then '우수고객' 
else '유령고객' end) grade
from usertbl u
	left outer join buytbl b
    on u.userid=b.userid
group by u.userid, u.name;

drop procedure if exists gradeProc;
delimiter $$
create procedure gradeProc()
begin
	declare id varchar(10);
    declare hap bigint;
    declare userGrade char(5);
    
    declare endOfRow boolean default false;
    declare userCursor cursor for
		select u.userID, sum(price * amount)
			from usertbl u
			left outer join buytbl b
			on u.userid=b.userid
			group by u.userid, u.name;
            
	declare continue handler
		for not found set endOfRow = true;
        
	open userCursor;
    grade_loop: loop
		fetch userCursor into id, hap;
		if endOfRow then leave grade_loop; end if;
		case when (hap >= 1500) then set userGrade= '최우수고객';
			 when (hap >= 1000) then set userGrade= '우수고객';
			 when (hap > 1) then set userGrade= '일반고객';
			else set userGrade='유령고객'; 
		end case;
		update usertbl set grade=userGrade where userid=id;
	end loop grade_loop;
	close userCursor;
end $$
delimiter ;

select * from usertbl;
call gradeProc();