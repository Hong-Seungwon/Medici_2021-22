CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
CREATE TABLE IF NOT EXISTS testTbl (id INT, txt VARCHAR(10));
INSERT INTO testTbl VALUES(1, '레드벨벳');
INSERT INTO testTbl VALUES(2, '잇지');
INSERT INTO testTbl VALUES(3, '블랙핑크');

delimiter //
create trigger testTrg
after delete on testTbl for each row
begin
	set @msg = '가수 그룹이 삭제됨';
end //
delimiter ;

show triggers;

select * from testtbl;
set @msg='';
select @msg;
insert into testtbl values(4, '마마무');
insert into testtbl values(5, 'ddd');
insert into testtbl values(6, 'aaa');
set SQL_SAFE_UPDATES=0;
delete from testtbl where id=4;
USE sqlDB;
CREATE TABLE backup_userTbl
( userID  CHAR(8) NOT NULL PRIMARY KEY, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  addr	  CHAR(2) NOT NULL, 
  mobile1	CHAR(3), 
  mobile2   CHAR(8), 
  height    SMALLINT,  
  mDate    DATE,
  modType  CHAR(2), -- 변경된 타입. '수정' 또는 '삭제'
  modDate  DATE, -- 변경된 날짜
  modUser  VARCHAR(256) -- 변경한 사용자
);
desc backup_userTbl;

delimiter //
create trigger backupUserTbl_DeleteTrg
after delete on userTbl for each row
begin
	insert into backup_userTbl values(
    OLD.userid, OLD.name, OLD.birthYear,
    OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate,
    '삭제', curdate(), current_user());
end //
delimiter ;

delimiter //
create trigger backupUserTbl_UpdateTrg
after update on userTbl for each row
begin
	insert into backup_userTbl values(
    OLD.userid, OLD.name, OLD.birthYear,
    OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate,
    '수정', curdate(), current_user());
end //
delimiter ;

show triggers;

select * from usertbl;
update usertbl set height=height * 1.1;
select * from backup_userTbl;
use sys;
select * from user;