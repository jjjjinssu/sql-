


-- 트랜잭션
CREATE TABLE employees (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER(8,2)
);

INSERT INTO employees VALUES (1, 'Alice', 5000);
INSERT INTO employees VALUES (2, 'Bob', 6000);
INSERT INTO employees VALUES (3, 'Charlie', 7000);

-- 급여 총합 조회
SELECT  SUM(SALARY)  FROM  HR.EMPLOYEES ;

COMMIT; -- 변경사항을 완전히 DB에 반영


-- 트랜잭션 시작 트랙잭션=> 커밋하기 전에는 롤백취소 가능.
BEGIN
	 --모든 사월드의 급여를 1000씩 올려줄거다
	UPDATE EMPLOYEES 
	SET SALARY = SALARY + 1000;

-- 급여 총합 조회
	SELECT  SUM(SALARY)  FROM  EMPLOYEES ;

	ROLLBACK;
	SELECT  SUM(SALARY)  FROM  EMPLOYEES;
END;	

-- 내 돈이 빠짐
UPDATE account
SET balance = balance - 1000
WHERE USER _NAME = '김철수';

ROLLBACK;

--WHERE 조건절
SELECT 
	EMP_NO, EMP_NM,ADDR,SEX_CD
FROM TB_EMP 
WHERE SEX_CD =2
;

-- where 절로 pk 동등조건을 걸면
-- 무조건 단일행이 조회된다.
SELECT 
EMP_NO ,EMP_NM, ADDR, SEX_CD
FROM TB_EMP te 
WHERE  EMP_NO =10000003
;

-- 비교 연산자 (90 년대생만 조회)
SELECT 
	EMP_NO ,EMP_NM , 
	BIRTH_DE ,TEL_NO 
FROM  TB_EMP 
WHERE BIRTH_DE  >='19900101'
	AND BIRTH_DE <='19991231'
;

--BETWEEN 연산자 A and B

SELECT 
	EMP_NO ,EMP_NM , 
	BIRTH_DE ,TEL_NO 
FROM  TB_EMP 
WHERE BIRTH_DE  BETWEEN '19900101' AND'19991231'
;

--OR 연산
SELECT
	EMP_NO,EMP_NM, DEPT_CD
FROM TB_EMP 
WHERE DEPT_CD = '100004'
 OR  DEPT_CD  = '100006'
 ;
 
-- IN 연산자 => 비교

SELECT
	EMP_NO,EMP_NM, DEPT_CD
FROM TB_EMP 
WHERE DEPT_CD IN ('100004','100006')
 ;
 
-- NOT IN 연산       --NOT = !  ~ ~ 가 아니다.
SELECT
	EMP_NO,EMP_NM, DEPT_CD
FROM TB_EMP 
WHERE DEPT_CD NOT IN ('100004','100006')
 ;

-- LIKE 연산자
-- 검색! ! ! !에서 주로사용
-- 와일드 카드 매핑 (% : 0 글자이상, : 딱 1글자)
SELECT 
	EMP_NO ,EMP_NM 
FROM TB_EMP 
WHERE  EMP_NM LIKE '%심'
;

SELECT 
	EMP_NO , EMP_NM ,ADDR
FROM TB_EMP 
WHERE ADDR LIKE '%용인%'

SELECT 
	EMP_NO ,EMP_NM 
FROM TB_EMP 
WHERE  EMP_NM LIKE '%이'
;

--  _ 는 딱 한글자 해당하는거

SELECT 
	EMP_NO ,EMP_NM 
FROM TB_EMP 
WHERE  EMP_NM LIKE '%이__'
;

--성씨가 김씨이면서 부서가 100003, 100004, 100006 번중에  //이면서 = AND 
--하나이면서
-- 90년대인 사원의 사번 , 이름 생일 부서코드를 조회
SELECT 
	EMP_NO ,EMP_NM ,BIRTH_DE ,DEPT_CD 
FROM TB_EMP 
WHERE   EMP_NM LIKE '김%'
AND DEPT_CD  IN('100003','100004','100006')
AND BIRTH_DE BETWEEN  '19900101' AND '19991231'

;
SELECT 
EMP_NO,
EMP_NM,
DIRECT_MANAGER_EMP_NO
FROM TB_EMP
WHERE DIRECT_MANAGER_EMP_NO  IS NOT NULL   --표기법 IS NOT NULL 
;


-- 연산자 우선 순위
-- NOT > AND > OR 
SELECT 
	EMP_NO,
	EMP_NM,
	ADDR
FROM TB_EMP 
WHERE 1=1
	AND EMP_NM  LIKE '김%'
	AND (ADDR LIKE '%수원%' OR ADDR LIKE '%일산%')
	
	-- AND 와 OR 이 동시에 있으면
	-- AND 를 먼저 묶어주고 계산한 다음에
	--OR을 계산해준다 SQL 문제에 나옴.

	
	/*
	 * 
	 * 트랜잭션의 개념과 ACID
acid 외우기.
원자성 A - 전부가 아니면 의미가 없다.
다.
일관성 C - 트랙잭션이 완료되면 데이터베이스의 일관성이 유지된다.
격리성 I - 내꺼야 다른놈이 못건들이게 !! 동시에 수행될때 트랜잭션이 서로 영향을 미치지 않는다.
지속성 D - 트랙잰션이 완료되면 영구적으로 반영된다.

WHERE 필터링 -> 검색
SELECT
FROM
WHERE condition

NOT NULL  ( X  )
IS NOT NULL ( 0 )

NULL +연산 = > NULL
EX) NULL +50 = > NULL

NULL 에 어떠한 사칙연산을 해도 NULL로 나온다.
	 * 
	 * 
	 * 
