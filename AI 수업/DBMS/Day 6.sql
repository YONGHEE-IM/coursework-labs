DROP DATABASE mall;

CREATE DATABASE mall;

USE mall;

CREATE TABLE t_shopping(
id INT(5) PRIMARY KEY AUTO_INCREMENT,
userId CHAR(30) NOT NULL,
userPw CHAR(30) NOT NULL,
userName CHAR(30) NOT NULL,
address CHAR(50) NOT NULL,
pname CHAR(50) NOT NULL,
price INT(5) NOT NULL
);


INSERT INTO t_shopping
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '운동화',
price = 1000000;

INSERT INTO t_shopping
SET userId = 'user2',
userPw = 'pass2',
userName = '설현',
address = '서울',
pname = '코트',
price = 100000;

INSERT INTO t_shopping
SET userId = 'user3',
userPw = 'pass3',
userName = '원빈',
address = '대전',
pname = '반바지',
price = 30000;

INSERT INTO t_shopping
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
address = '대구',
pname = '스커트',
price = 15000;

INSERT INTO t_shopping
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
address = '부산',
pname = '코트',
price = 100000;

INSERT INTO t_shopping
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
address = '울산',
pname = '티셔츠',
price = 9000;

INSERT INTO t_shopping
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
address = '울산',
pname = '운동화',
price = 200000;

INSERT INTO t_shopping
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '코트',
price = 100000;

INSERT INTO t_shopping
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
address = '울산',
pname = '스커트',
price = 15000;

INSERT INTO t_shopping
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '운동화',
price = 1000000;

INSERT INTO t_shopping
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
address = '부산',
pname = '모자',
price = 30000;

SELECT * FROM `t_shopping`;
DESCRIBE `t_shopping`;

SELECT * FROM `t_shopping`
GROUP BY `userName`;

SELECT userName, COUNT(userName)
FROM `t_shopping`
GROUP BY `userName`;

SELECT *, COUNT(userId), SUM(price)
FROM `t_shopping`
GROUP BY `userId`;

SELECT SUM(price)
FROM `t_shopping`
WHERE `userId` = 'user1';

SELECT *, COUNT(userId), SUM(price)
FROM `t_shopping`
GROUP BY `userId`
HAVING SUM(price) > 100000;


############################################################

# a6 DB 삭제/생성/선택
DROP DATABASE IF EXISTS a6;
CREATE DATABASE a6;
USE a6;

# 부서(홍보, 기획)
# 주의 : INT(10)이 10바이트라는 강사의 설명은 잘못 되었습니다. 그냥 INT라고 쓰시면 됩니다.
CREATE TABLE dept (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    `name` CHAR(100) NOT NULL UNIQUE
);

INSERT INTO dept
SET regDate = NOW(),
`name` = '홍보';

INSERT INTO dept
SET regDate = NOW(),
`name` = '기획';

# 사원(홍길동/홍보/5000만원, 홍길순/홍보/6000만원, 임꺽정/기획/4000만원)
# 주의 : INT(10)이 10바이트라는 강사의 설명은 잘못 되었습니다. 그냥 INT라고 쓰시면 됩니다.
CREATE TABLE emp (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    `name` CHAR(100) NOT NULL,
    deptId INT UNSIGNED NOT NULL,
    salary INT UNSIGNED NOT NULL
);

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길동',
deptId = 1,
salary = 5000;

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길순',
deptId = 1,
salary = 6000;

INSERT INTO emp
SET regDate = NOW(),
`name` = '임꺽정',
deptId = 2,
salary = 4000;

# 사원 수 출력
SELECT COUNT(*)
FROM emp;

# 가장 큰 사원 번호 출력
SELECT MAX(id)
FROM emp;

# 가장 고액 연봉
SELECT MAX(salary)
FROM emp;

# 가장 저액 연봉
SELECT MIN(salary)
FROM emp;

# 회사에서 1년 고정 지출(인건비)
SELECT SUM(salary)
FROM emp;

# 부서별, 1년 고정 지출(인건비)
SELECT deptId, SUM(salary)
FROM emp
GROUP BY deptId;

# 부서별, 최고연봉
SELECT deptId, MAX(salary)
FROM emp
GROUP BY deptId;

# 부서별, 최저연봉
SELECT deptId, MIN(salary)
FROM emp
GROUP BY deptId;

# 부서별, 평균연봉
SELECT deptId, AVG(salary)
FROM emp
GROUP BY deptId;

# 부서별, 부서명, 사원리스트, 평균연봉, 최고연봉, 최소연봉, 사원수
## V1(조인 안한 버전)
SELECT E.deptId AS 부서번호,
GROUP_CONCAT(E.name) AS 사원리스트,
TRUNCATE(AVG(E.salary), 0) AS 평균연봉,
MAX(E.salary) AS 최고연봉,
MIN(E.salary) AS 최소연봉,
COUNT(*) AS 사원수
FROM emp AS E
GROUP BY E.deptId;

## V2(조인해서 부서명까지 나오는 버전)
SELECT D.name AS 부서,
GROUP_CONCAT(E.name) AS 사원리스트,
TRUNCATE(AVG(E.salary), 0) AS 평균연봉,
MAX(E.salary) AS 최고연봉,
MIN(E.salary) AS 최소연봉,
COUNT(*) AS 사원수
FROM emp AS E
INNER JOIN dept AS D
ON E.deptId = D.id
GROUP BY E.deptId;

## V3(V2에서 평균연봉이 5000이상인 부서로 추리기)
SELECT D.name AS 부서,
GROUP_CONCAT(E.name) AS 사원리스트,
TRUNCATE(AVG(E.salary), 0) AS 평균연봉,
MAX(E.salary) AS 최고연봉,
MIN(E.salary) AS 최소연봉,
COUNT(*) AS 사원수
FROM emp AS E
INNER JOIN dept AS D
ON E.deptId = D.id
GROUP BY E.deptId
HAVING `평균연봉` >= 5000;

## V4(V3에서 HAVING 없이 서브쿼리로 수행)
### HINT, UNION을 이용한 서브쿼리
# SELECT *
# FROM (
#     SELECT 1 AS id
#     UNION
#     SELECT 2
#     UNION
#     SELECT 3
# ) AS A

SELECT *
FROM (
    SELECT D.name AS `부서명`,
    GROUP_CONCAT(E.`name`) AS `사원리스트`,
    TRUNCATE(AVG(E.salary), 0) AS `평균연봉`,
    MAX(E.salary) AS `최고연봉`,
    MIN(E.salary) AS `최소연봉`,
    COUNT(*) AS `사원수`
    FROM emp AS E
    INNER JOIN dept AS D
    ON E.deptId = D.id
    WHERE 1
    GROUP BY E.deptId
) AS D
WHERE D.`평균연봉` >= 5000;




