-- JOIN문
-- 두개 이상의 테이블을 묶어서 하나의 결과 집합으로 출력

-- INNER JOIN
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력

-- 전 사원의 사번, 이름, 현재 급여를 출력해주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	 JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
ORDER BY emp.emp_id ASC	
;

-- 재직중인 사원의 사번, 이름, 생일, 부서명
SELECT 
	emp.emp_id
	,emp.`name`
	,emp.birth
	,dep.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
WHERE depe.end_at IS NULL
;

-- LEFT JOIN
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	LEFT JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;

-- 두개 이상의 쿼리의 결과를 합쳐서 출력
-- UNION			(중복 레코드 제거)
-- UNION ALL	(중복 레코드 제거 안함)
SELECT * FROM employees WHERE emp_id IN(1, 3)
UNION
SELECT * FROM employees WHERE emp_id IN(3, 6)
;

-- SELF JOIN
SELECT
	emp.emp_id AS junior_id
	,emp.`name` AS junior_name
	,supemp.emp_id AS supervisor_id
	,supemp.`name` AS supervisor_name
FROM employees emp
	JOIN employees supemp
		ON emp.sup_id = supemp.emp_id
WHERE
	emp.emp_id IS NOT NULL
;


-- Join문 예제
-- 현재 부서명이 D001인 사원들의 평균 연봉
SELECT
	dep.dept_name
-- 	,salary
	,AVG(sal.salary)
FROM salaries sal
	JOIN department_emps depe
		ON sal.emp_id = depe.emp_id
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
WHERE
	sal.end_at IS NULL
	AND depe.end_at IS NULL
	AND depe.dept_code = 'D001'
;

-- 연봉3000만원 이하인 사원들이 각 부서별로 몇명씩 있는가
SELECT 
	dep.dept_name
	,COUNT(depe.dept_code)
FROM salaries sal
	JOIN department_emps depe
		ON sal.emp_id = depe.emp_id
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
WHERE
	sal.end_at IS NULL
	AND depe.end_at IS NULL
	AND sal.salary <= 30000000
GROUP BY depe.dept_code
;
