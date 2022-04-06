-- (1) 모든 액션 영화(Category.name = ‘Action’)을 찾기 위해 film 테이블의 조건에 
-- category테이블에 대한 비상관 서브 쿼리를 사용하는 쿼리 작성
select f.title
from film f, film_category fc, category c
where f.film_id=fc.film_id and 
fc.category_id=c.category_id and
c.name='Action';

-- (2) 위의 쿼리를 Category와 film_category 테이블에 대해 상관 서브쿼리를 사용해서 동일한 결과를 얻도록 수정
select f.title
from film f
	inner join film_category fc
    on f.film_id=fc.film_id
    inner join category c
    on fc.category_id=c.category_id
where c.name='Action';

-- (3) 각 배우의 레벨을 보여주기 위해서 다음 쿼리를 사용해서 film_actor테이블에 대해 서브쿼리와 조인하는 쿼리를 작성( film_actor 테이블에 대한 서브쿼리를 그룹화를 사용해서 
-- actor_id 별로 각 배우의 행의 수를 계산해야 하며 카운팅한 수는 min_roles/max_rols열과 비교하여 각 배우가 어느 레벨에 속하는지를 확인)
select actors.first_name, actors.last_name, alevel.level
from (select a.first_name first_name, a.last_name last_name, count(fa.film_id) roles
	from actor a
	inner join film_actor fa
	on a.actor_id = fa.actor_id
group by a.actor_id) actors
inner join
(SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles)alevel
on actors.roles between alevel.min_roles and alevel.max_roles;