-- INSERT 문
-- 신규 데이터를 저장하기 위해 사용하는 문법
INSERT INTO employees(
	`name`
	, birth
	, gender
	, hire_at
	, fire_at
	, sup_id
	, created_at
	, updated_at
	, deleted_at
)
VALUES(
	'정의욱'
	, '2000-07-01'
	, 'M'
	, '2025-10-31'
	, NULL
	, NULL
	, NOW()
	, NOW()
	, NULL
);

-- 생성일이 가장 최근인 것
-- 그냥 내 이름으로 찾기
-- 입사일이 오늘 기준
-- 생일
-- 가장 큰 PK로 찾기
SELECT *
FROM employees
WHERE
	`name` = '정의욱'
	AND birth = '2000-07-01'
	AND hire_at = '2025-10-31'
;

-- salaries에 내 연봉 추가
INSERT INTO salaries(
	emp_id
	,salary
	,start_at
	-- ,end_at
	-- ,created_at
	-- ,updated_at
	-- ,deleted_at
)
VALUES(
	100005
	,33333333
	,'2000-07-01'
	-- ,NULL
	-- ,NOW()
	-- ,NOW()
	-- ,NULL
);
-- 테이블에 기본값이 설정되어 있는 부분은 비워놓아도 괜찮다.

-- 업그레이드 SELECT INSERT
-- SELECT INSERT를 이용하여 salaries에 내 연봉 추가
INSERT INTO salaries (
	emp_id
	,salary
	,start_at
)
SELECT 
	emp_id
	,33333333
	,created_at
FROM employees
WHERE
	`name` = '정의욱'
	AND birth = '2000-07-01'
	AND hire_at = '2025-10-31'
;