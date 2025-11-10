-- 1
SELECT `name`, hire_at
FROM employees
;

-- 2
SELECT emp_id
FROM department_emps 
WHERE dept_code = 'D005' AND end_at IS NULL
;

-- 3
SELECT *
FROM employees
WHERE hire_at >= '1995-01-01'
ORDER BY hire_at ASC
;

-- 4
SELECT 
	dept_name, COUNT(depe.dept_code) len_code
FROM departments dep
	JOIN department_emps depe
		ON depe.dept_code = dep.dept_code
		AND depe.end_at IS NULL
GROUP BY depe.dept_code
ORDER BY len_code DESC
;

-- 5
SELECT
	emp.emp_id, emp.`name`, sub_sal.salary
FROM employees emp
	JOIN (
		SELECT sal.emp_id, sal.salary
		FROM salaries sal
		WHERE sal.end_at IS NULL
	) sub_sal
		ON	emp.emp_id = sub_sal.emp_id
		AND emp.fire_at IS NULL
;

-- 6
SELECT 
	emp.`name`
	,dept_name
FROM employees emp
	JOIN department_emps depe
		ON depe.emp_id = emp.emp_id
		AND emp.fire_at IS NULL
		AND depe.end_at IS NULL 
	JOIN departments dep
		ON dep.dept_code = depe.dept_code
;

-- 7
SELECT 
	dept_name
	,emp.`name`
FROM departments dep
	JOIN department_managers depm
		ON dep.dept_code = depm.dept_code
		AND dep.dept_name = '마케팅부'
		AND depm.end_at IS NULL
	JOIN employees emp
		ON emp.emp_id = depm.emp_id
		AND emp.fire_at IS NULL
;
	
-- 8
SELECT
	emp.`name`
	,emp.gender
	,tit.title
FROM titles tit
	JOIN title_emps tite
		ON tite.title_code = tit.title_code
		AND tite.end_at IS null
	JOIN employees emp
		ON emp.emp_id = tite.emp_id
		AND emp.fire_at IS NULL
;

-- 9
SELECT 
	emp.emp_id
	,sub_sal.salary
FROM employees emp
	JOIN (
		SELECT sal.emp_id
			,sal.salary
		FROM salaries sal
		WHERE 
			sal.end_at IS null
		ORDER BY sal.salary DESC
		LIMIT 5 OFFSET 0
	) sub_sal
		ON sub_sal.emp_id = emp.emp_id
		AND emp.fire_at IS NULL
;
	
-- 10
SELECT 
	dept_code
	,avg(sal.salary) AS avg_sal
FROM department_emps depe
	JOIN salaries sal
		ON sal.emp_id = depe.emp_id
		AND sal.end_at IS NULL
		AND depe.end_at IS NULL
GROUP BY dept_code
	HAVING avg_sal >= 60000
;

-- 11
usersCREATE DATABASE test;

CREATE TABLE users(
	userid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,username VARCHAR(30) NOT NULL
	,authflg CHAR(1) DEFAULT '0'
	,birthday DATE NOT NULL
	,created_at DATETIME DEFAULT CURRENT_TIMESTAMP()
)
;

-- 12
INSERT INTO users(
	username
	,birthday
)
VALUES(
	'그린'
	,'2024-01-26'
);

-- 13
UPDATE users
SET
	username = '테스터'
	,AuthFlg = '1'
	,birthday = '2007-03-01'
WHERE 
	userid = 1
;

-- 14
DELETE FROM users
WHERE
	userid = 1
;

-- 15
ALTER TABLE users
ADD COLUMN 
	addr VARCHAR(100) NOT NULL DEFAULT '-'
;

-- 16
DROP TABLE users;

-- 17
-- users테이블 생성
CREATE TABLE users(
	userid BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,username VARCHAR(30) NOT NULL
	,authflg CHAR(1) DEFAULT '0'
	,birthday DATE NOT NULL
	,created_at DATETIME DEFAULT CURRENT_TIMESTAMP()
);
-- users에 레코드 생성
INSERT INTO users(
	username
	,birthday
)
VALUES(
	'green'
	,'2024-01-26'
);
-- rankmanagemnet 테이블 생성
CREATE TABLE rankmanagement(
	rankid BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,userid BIGINT UNSIGNED NOT NULL
	,rankname VARCHAR(20) NOT NULL
);
-- rankmanagemnet에 FK부여
ALTER TABLE rankmanagement
	ADD CONSTRAINT fk_rankmanagement_userid
	FOREIGN KEY (userid)
	REFERENCES users(userid)
;
-- rankmanagemnet에 레코드 생성
INSERT INTO rankmanagement(
	userid
	,rankname
)
VALUES(
	1
	,'manager'
);

-- 유저명, 생일, 랭크명 출력
SELECT 
	username
	,birthday
	,rankname
FROM users
 JOIN rankmanagement
 	ON users.userid = rankmanagement.userid
;