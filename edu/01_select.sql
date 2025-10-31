-- 테이블 전체 컬럼 조회
SELECT *
FROM employees;

-- 특정 컬럼만 지정하여 조회
SELECT
	name
	,birth
	,hire_at
FROM employees;

-- WHERE 절: 특정 컬럼의 값과 일치한 데이터만 조회(필터링)
SELECT *
FROM employees
WHERE
	NAME = '강영화'
;

-- 이름이 강영화 이고, 성별이 M인 사원 조회
SELECT *
FROM employees
WHERE
	NAME = '강영화'
	AND gender = 'M'
;

-- 날짜를 필터링 할 경우 'YYYY-MM-DD'사용
SELECT *
FROM employees
WHERE
	hire_at >= '2023-01-01'
;

-- 아직 재직중인 사원들만 조회 (NULL 조회)
SELECT *
FROM employees
WHERE
	fire_at IS NULL
;

-- 재직중이지 않은 사원들 조회 (NULL이 아닌 것 조회)
SELECT *
FROM employees
WHERE
	fire_at IS NOT NULL
;

-- WHERE 절에서 AND, OR 복합 사용 시 주의(OR을 잘 묶어줘야 함)
-- 입사일이 20250101이후거나, 20000101이전이고,
-- 이미 퇴사한 직원
SELECT *
FROM employees
WHERE
	(
	hire_at >= '2025-01-01'
	OR hire_at <= '2000-01-01'
	)
	AND fire_at IS NULL
;

-- 입사일이 20250101, 20000101사이이면 
-- AND대신 BETWEEN을 사용할 수 있다.
-- 반드시 낮은값을 먼저 적어줘야 함
SELECT *
FROM employees
WHERE
-- 	아래 hire_at는 같은 처리이다.
-- 	hire_at >= '2000-01-01' AND hire_at <= '2025-01-01'
	hire_at BETWEEN '2000-01-01' AND '2025-01-01'
	AND fire_at IS NULL
;

-- IN 연산자 : 지정한 값과 일치한 데이터를 조회
-- 사번이 5, 7, 9, 12인 사원 조회
SELECT *
FROM employees
WHERE
	emp_id = 5
	OR emp_id = 7
	OR emp_id = 9
	OR emp_id = 12
;
SELECT *
FROM employees
WHERE
	emp_id IN(5, 7, 9, 12)
;

-- like 연산자 : 문자열 내용을 조회(대소문자 구별x)
-- % : 굴자수와 상관없이 조회
-- 이름에 '호'가 들어가는 사원 조회
SELECT *
FROM employees
WHERE
	NAME LIKE '%호%'
;
-- 이름이 '호'로 끝나는 사원 조회
SELECT *
FROM employees
WHERE
	NAME LIKE '%호'
;
-- _ : 언더바의 개수만큼이 글자의 개수
-- 이름의 중간에 '호'가 들어가는 사원 조회
SELECT *
FROM employees
WHERE
	NAME LIKE '_호_'
;


-- ORDER BY 절 : 데이터 정렬
-- 	ASC : 오름차순
-- 	DESC : 내림차순
-- 이름은 오름차순, 그 중 생일기준 오름차순 정렬
SELECT *
FROM employees
ORDER BY NAME ASC, birth ASC
;
-- 이름은 오름차순, 그 중 생일기준 내림차순 정렬
SELECT *
FROM employees
ORDER BY NAME asc , birth DESC
;

-- 입사일이 2000년 이후인 사원을
-- 이름, 생일 모두 오름차순으로 정렬해서 조회
SELECT *
FROM employees
WHERE
	hire_at >= '2000-01-01'
ORDER BY 
	NAME asc
	,birth asc
;

-- 여자 사원을 이름, 생일 오름차순으로 정렬
SELECT *
FROM employees
WHERE
	gender = 'F'
ORDER BY 
	NAME asc
	, birth ASC
;

-- DISTINCT 키워드 : 검색 결과에서 중복되는 레코드를 제거
-- 중복된 이름을 가진 사람을 지우고, 오름차순 시킨 처리
SELECT DISTINCT NAME
FROM employees
ORDER BY NAME ASC
;

-- 사원 별 최고 연봉
SELECT
	emp_id
	,MAX(salary) AS max_salary
FROM salaries
GROUP BY emp_id
;
-- 사원 별 최고 연봉이 5000만원 이상인 사원 조회
SELECT
	emp_id
	,MAX(salary) AS max_salary
FROM salaries
GROUP BY emp_id
	HAVING max_salary >= 50000000
;

-- 성별 사원수를 조회해 주세요
SELECT 
	gender
	,COUNT(gender) AS COUNT_gender
FROM employees
GROUP BY gender
;

-- 재직중인 성별 사원수를 조회해 주세요.
SELECT 
	gender
	,COUNT(gender) AS COUNT_gender
FROM employees
WHERE fire_at IS NULL
GROUP BY gender
;

-- 사원번호로 오름차순 정렬해서 10개씩만 조회
SELECT *
FROM employees
WHERE fire_at IS NOT NULL
ORDER BY emp_id asc
LIMIT 10 OFFSET 10
;

SELECT *
FROM employees
ORDER BY emp_id asc
LIMIT 10 OFFSET 10
;

-- 현재 받고있는 급여 중 사원의 연봉 상위 5명 조회해주세요
SELECT 
	*
FROM salaries
WHERE 
	end_at IS NULL
ORDER BY 
	salary desc
LIMIT 
	5
;

-- SELECT문의 기본 구조
SELECT [DISTINCT] [컬럼명]
FROM [테이블명]
WHERE [쿼리조건]
GROUP BY[컬럼명] HAVING [집계함수 조건]
ORDER BY [컬럼명 ASC || 컬럼명 DESC]
LIMIT [n] OFFSET [n]
;