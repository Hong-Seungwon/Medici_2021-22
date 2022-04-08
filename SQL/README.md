# SQL Study 
## 데이터 조작어(DML)
```
* SELECT 기본 문법
SELECT [ALL┃DISTINCT] 속성 이름(들)
FROM 	      테이블 이름(들)
[WHERE        검색 조건(들)]
[GROUP BY    속성 이름]
[HAVING       검색 조건(들)]
[ORDER BY    속성 이름 [ASC┃DESC]]
--------------------------------------------------------------------------------
[ ] : 대괄호 안의 SQL 예약어들은 선택적으로 사용한다.
| : 선택 가능한 문법들 중 한 개를 사용할 수 있다.


* WHERE절 조건 연산자
비교 : =, <>, <, <=, >, >=
범위 : BETWEEN
집합 : IN, NOT IN
패턴 : LIKE
NULL : IS NULL, IS NOT NULL
복합조건 : AND, OR, NOT

* GROUP BY <속성>
GROUP BY로 투플을 그룹으로 묶은 후 SELECT 절에는 GROUP BY에서 사용한 <속성>과 집계함수만 나올 수 있다.

* HAVING <검색조건(들)>
WHERE 절과 HAVING 절이 같이 포함된 SQL 문은 검색조건이 모호해질 수 있다.
HAVING 절은 1. 반드시 GROUP BY 절과 같이 작성해야 하고 2. WHERE 절보다 뒤에 나와야 한다.
그리고 3. <검색조건(들)>에는 SUM, AVG, MAX, MIN, COUNT와 같은 집계함수가 와야 한다.

* JOIN 문법
- 내부 조인(INNER JOIN)
1.  SELECT <속성들>
    FROM 테이블1, 테이블2
    WHERE <조인 조건> AND <검색 조건>
2.  SELECT <속성들>
    FROM 테이블1 INNER JOIN 테이블2 ON <조인 조건>
    WHERE <검색 조건>
    
- 동등 조인(EQUI JOIN)
    SELECT <속성들>
    FROM 테이블1, 테이블2
    WHERE <공통 컬럼> = <공통 컬럼>
    
- 외부 조인(OUTER JOIN)
    SELECT <속성들>
    FROM 테이블1 {LEFT |RIGHT |FULL [OUTER]} JOIN 테이블2 ON <조인 조건>
    WHERE <검색 조건>
```
## 데이터 정의어(DDL)
```
* CREATE 문
1. 테이블 구성, 속성과 속성에 관한 제약 정의, 기본키 및 외래키를 정의하는 명령
2. PRIMARY KEY : 기본키를 정할 때 사용
3. FOREIGN KEY : 외래키를 지정할 때 사용
4. ON UPDATE와 ON DELETE : 외래키 속성의 수정과 투플 삭제 시 동작을 나타냄

* CREATE 기본 문법
CREATE TABLE 테이블 이름
 ( {속성이름 데이터 타입 [NOT NULL | UNIQUE | DEFAULT 기본값 | CHECK 체크조건]}
    [PRIMARY KEY 속성 이름(들)]
    {[FOREIGN KEY 속성 이름 REFERENCES 테이블 이름(속성 이름)] [ON DELETE [CASCADE┃SET NULL]})

* ALTER 문
1. 테이블의 속성과 속성에 관한 제약을 변경하며, 기본키 및 외래키를 변경
2. ADD, DROP은 속성을 추가하거나 제거할 때 사용
3. MODIFY는 속성의 기본값을 설정하거나 삭제할 때 사용

* ALTER 기본 문법
ALTER TABLE 테이블 이름
[ADD 속성이름 데이터 타입]
[DROP COLUMN 속성 이름]
[MODIFY 속성이름 데이터 타입]
[MODIFY 속성이름 [NULL┃NOT NULL]]
[ADD PRIMARY KEY(속성 이름)]
[[ADD┃DROP] 제약 이름]
	
* DROP 문
1. 테이블을 삭제하는 명령
2. 테이블의 구조와 데이터를 모두 삭제하므로 사용에 주의해야 함(데이터만 삭제하려면 DELETE 문을 사용함)

*DROP 기본 문법
DROP TABLE 테이블이름
```
## 데이터 조작어(DCL)
```
* INSERT 문
테이블에 새로운 튜플을 삽입하는 명령

* INSERT 기본 문법
INSERT INTO 테이블 이름[(속성 리스트)] 
VALUES(값 리스트);
       
* UPDATE 문
특정 속성 값을 수정하는 명령

* UPDATE 기본 문법
UPDATE 테이블 이름
SET 속성 이름1=값1[, 속성 이름2=값2, ...]
[WHERE <검색 조건>];

* DELETE 문
테이블에 있는 기존 튜플을 삭제하는 명령

* DELETE 기본 문법
DELETE FROM 테이블 이름
[WHERE 검색 조건];
```

## SQL 내장 함수
```
1. 숫자 함수
2. 문자 함수
3. 날짜·시간 함수  
4. 변환 함수
5. 정보 함수
6. NULL 관련 함수
7. 집계 함수
8. 윈도우 함수(분석 함수)
```

