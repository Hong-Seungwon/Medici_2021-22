create database pythondb;
use pythondb;
drop table if exists pelicana_crawling;

create table pelicana_crawling(
	id int auto_increment primary key,
    store varchar(50),
    sido varchar(20),
    gungu varchar(20),
    address varchar(50),
    phone varchar(20),
    regdate timestamp null default current_timestamp()
);

insert into pelicana_crawling
(store, sido, gungu, address, phone)
values('1',null,null, null,null);

select * from pelicana_crawling;

truncate pelicana_crawling;