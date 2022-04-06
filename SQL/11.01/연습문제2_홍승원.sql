-- (1)  다음 필터 조건에 따라 변환하는 payment ID는 무엇인가?
-- customer_id<>5 and (amount>8 or date(payment_date)='2005-08-23')
select payment_id
from payment
where customer_id <> 5 and (amount>8 or date(payment_date)='2005-08-23');
-- (2) 다음 필터 조건에 따라 변환하는 payment ID는 무엇인가?
-- customer_id=5 and not (amount>6 or date(payment_date)='2005-06-19')
select payment_id
from payment
where customer_id = 5 and not(amount>6 or date(payment_date)='2005-06-19');
-- (3) Payments 테이블에서 금액이 1.98, 7.98, 9.98인 모든 행을 검색하는 쿼리를 작성
select *
from payment
where amount=1.98 or amount=7.98 or amount=9.98;

-- (4) 성의 두번째 위치에 A가 있고 A다음에 W가 있는 모든 고객을 찾는 쿼리를 작성
select first_name, last_name
from customer
where last_name like '_A%' and last_name like '%AW%';