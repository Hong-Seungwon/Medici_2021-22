-- (1) JOHN이라는 이름의 배우가 출연한 모든 영화의 제목을 반환하는 쿼리를 생성
select f.title
from film f
	inner join film_actor fa
    on f.film_id=fa.film_id
    inner join actor a
    on fa.actor_id=a.actor_id
where a.first_name like 'JOHN';
-- (2) 같은 도시에 있는 주소를 반환하는 쿼리를 생성 이때 address테이블을 셀프 조인해야 하며 각행에는 두개의 서로 다른 주소가 포함되어야 한다.
