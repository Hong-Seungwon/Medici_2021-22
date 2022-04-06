-- (1) 모든 배우의 배우 ID, 이름 및 성을 검색, 성 기준으로 정렬한 다음 이름 기준으로 정렬
select actor_id, first_name, last_name
from actor
order by last_name, first_name;

-- (2) 성이 ‘WILLIAMS’ 또는 ‘DAVIS’인 모든 배우의 배우 ID, 이름과 성을 검색
select actor_id, first_name, last_name
from actor
where last_name='WILLIAMS' or last_name='DAVIS';

-- (3) rental 테이블에서 2005년 7월 5일 영화를 대여한 고객의 ID를 반환하는 쿼리를 작성 (rental.rental_date 열을 사용하고 , date() 함수로 시간 요소를 무시할 수 있음), 각 고객 ID는 하나의 행을 포함
select customer_id
from rental
where date(rental.rental_date)='2005-07-05';

-- (4) 다음 결과를 참고하여 이 다중 테이블 쿼리의 <#> 부분을 채우세요
select c.email, r.return_date
from customer c
    inner join rental r
    on c.customer_id=r.customer_id
where date(r.rental_date)='2005-06-14'
order by r.return_date desc;