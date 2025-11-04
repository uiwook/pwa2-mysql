-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,tite.title_code
FROM	employees emp
	JOIN	title_emps tite
		ON emp.emp_id = tite.emp_id
		AND tite.end_at IS NULL
;
-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT
	emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
		AND sal.emp_id = 10010
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,dep.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
		AND depe.end_at IS NULL
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL
ORDER BY salary DESC
LIMIT 10 OFFSET 0
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	dep.dept_name
	,emp.`name`
	,emp.hire_at
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
		AND depm.end_at IS NULL
	JOIN departments dep
		ON depm.dept_code = dep.dept_code
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
-- 현재 각 부장별 이름, 연봉평균
SELECT
	emp.`name`
	,AVG(sal.salary)
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
		AND tite.end_at IS NULL
	JOIN titles tit
		ON tite.title_code = tit.title_code
		AND tit.title = '부장'
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
GROUP BY sal.emp_id
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,depm.dept_code
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을
--		평균연봉 내림차순으로 출력해 주세요.
SELECT
	tit.title
	,CEILING(AVG(sal.salary)) avg_sal
FROM titles tit
	JOIN title_emps tite
		ON tit.title_code = tite.title_code
	JOIN salaries sal
		ON tite.emp_id = sal.emp_id
		AND sal.end_at IS NULL
		AND sal.salary >= 60000000
GROUP BY tite.title_code
ORDER BY avg_sal DESC
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tit.title
	,COUNT(tite.title_code) cnt_emp
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
	JOIN titles tit
		ON tite.title_code = tit.title_code
WHERE
	emp.gender = 'F'
GROUP BY tite.title_code
;