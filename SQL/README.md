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
* 숫자 함수
- ABS(숫자)
  숫자의 절댓값을 계산 
  ABS(-4.5) => 4.5

- CEIL(숫자)
  숫자보다 크거나 같은 최소의 정수 
  CEIL(4.1) => 5
  
- FLOOR(숫자)
  숫자보다 작거나 같은 최소의 정수 
  FLOOR(4.1) => 4

- ROUND(숫자, m)
  숫자의 반올림, m은 반올림 기준 자릿수
  ROUND(5.36, 1) => 5.40
  
- LOG(n, 숫자)
  숫자의 자연로그 값을 반환
  LOG(10) => 2.30259
  
- POWER(숫자, n)
  숫자의 n제곱 값을 계산
  POWER(2, 3) => 8
  
- SQRT(숫자)
  숫자의 제곱근 값을 계산(숫자는 양수)
  SQRT(9.0) => 3.0
  
- SIGN(숫자)
  숫자가 음수면 -1, 0이면 0, 양수면 1 
  SIGN(3.45) => 1

* 문자 함수
- CONCAT(s1,s2) 
  두 문자열을 연결
  CONCAT('마당', '서점') => '마당 서점'

- LOWER(s)  
  대상 문자열을 모두 소문자로 변환
  LOWER('MR. SCOTT') => 'mr. scott'
  
- LPAD(s,n,c) 
  대상 문자열의 왼쪽부터 지정한 자리수까지 지정한 문자로 채움
  LPAD('Page 1', 10, '*') => '****Page 1'

- REPLACE(s1,s2,s3)
  대상 문자열의 지정한 문자를 원하는 문자로 변경
  REPLACE('JACK & JUE', 'J', 'BL') => 'BLACK & BLUE'

- RPAD(s,n,c)
  대상 문자열의 오른쪽부터 지정한 자리수까지 지정한 문자로 채움
  RPAD('AbC', 5, '*') => 'AbC**'

- SUBSTR(s,n,k)
  대상 문자열의 지정된 자리에서부터 지정된 길이만큼 잘라서 반환
  SUBSTR('ABCDEFG', 3, 4) => 'CDEF'

- TRIM(c FROM s)
  대상 문자열의 양쪽에서 지정된 문자를 삭제(문자열만 넣으면 기본값으로 공백 제거)
  TRIM('=' FROM '==BROWNING==') => 'BROWNING'

- UPPER(s)
 대상 문자열을 모두 대문자로 변환
 UPPER('mr. scott') => 'MR. SCOTT'
 
- ASCII(c)
  대상 알파벳 문자의 아스키 코드 값을 반환
  ASCII('D') => 68  
  
- LENGTH(s)
  대상 문자열의 Byte 반환, 알파벳 1byte, 한글 3byte (UTF8)
  LENGTH('CANDIDE') => 7

- CHAR_LENGTH(s)
  문자열의 문자 수를 반환
  CHAR_LENGTH('데이터') => 3


  
 


```
