use mydata;

alter table womenreviews
drop MyUnknownColumn;
commit;

select * from womenreviews;
-- a) Division별 평균 평점 계산
select `division name`, avg(Rating) avg_rate
from womenreviews;
desc womenreviews;
alter table womenreviews rename column `division name` to division;
alter table womenreviews rename column `Department Name` to department;
select division, avg(Rating) avg_rate
from womenreviews
group by 1 order by 2 desc;

select department, avg(Rating) avg_rate
from womenreviews
group by 1 order by 2 desc;

select distinct rating
from womenreviews;

select * from womenreviews;

-- 연령별 분석

select case when age between 0 and 9 then '0009'
when age between 10 and 19 then '1019'
when age between 20 and 29 then '2029'
when age between 30 and 39 then '3039'
when age between 40 and 49 then '4049'
when age between 50 and 59 then '5059'
when age between 60 and 69 then '6069'
when age between 70 and 79 then '7079'
when age between 80 and 89 then '8089'
when age between 90 and 99 then '9099' end ageband,
age
from womenreviews;

select floor(29/10)*10 ageband;

-- trend 3점 이하의 리뷰의 연령 분포

select floor(age/10)*10 ageband, count(*) cnt
from womenreviews
where department='trend' and rating <= 3
group by 1 order by 2 desc;

select floor(age/10)*10 ageband, count(*) cnt
from womenreviews
where department='trend'
group by 1 order by 2 desc;

select *
from womenreviews
where department = 'trend' and rating <= 3
and age between 50 and 59 limit 10;
