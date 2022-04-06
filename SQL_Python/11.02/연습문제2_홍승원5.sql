-- (1) 성이 L로 시작하는 모든 배우와 고객의 이름과 성을 찾는 복합 쿼리 작성
select first_name, last_name
from actor
where last_name like 'L%'
union
select first_name, last_name
from customer
where last_name like 'L%';

-- (2) (1)번 결과를 last_name열을 기준으로 정렬
select first_name, last_name
from actor
where last_name like 'L%'
union
select first_name, last_name
from customer
where last_name like 'L%'
order by last_name;