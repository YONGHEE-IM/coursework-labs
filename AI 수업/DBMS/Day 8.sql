DROP DATABASE IF EXISTS i1;

CREATE DATABASE i1;

USE i1;

# 회원 -> 아이디, 비밀번호, 이름
CREATE TABLE `member`(
	loginId VARCHAR(30),
	loginPw VARCHAR(30),
	nickname VARCHAR(30)
);

SELECT * FROM `member`;

# 테스트 데이터 1, user1, pass1, 김철수
# 테스트 데이터 2, user2, pass2, 이현철

INSERT INTO `member`
SET loginId = 'user1',
loginPw = 'pass1',
nickname = '김철수';

INSERT INTO `memeber`
SET loginId = 'user2',
loginPw = 'pass2',
nickname = '이현철';

# 랜덤 유저 만들기
INSERT INTO `member`
SELECT CONCAT('user_', SUBSTR(UUID(), 1, 8)), 'pass3', '익명' FROM `member`;

SELECT SQL_NO_CACHE *
FROM `member`
WHERE nickname = '이현철';

# loginId에 인덱스 걸기
CREATE INDEX loginId_index ON `member`(loginId);

# 인덱스를 걸기 좋은 컬럼
# pk는 무조건 인덱스가 생성됨
# 중복값이 최대한 적은 (없는게 가장 좋음) 컬럼 선택
# where에 자주 언급되는 컬럼
# 삽입, 삭제가 거의 일어나지 않는 테이블

# SQL 전문가, DB 전문가
# 개발자들도 테이블 검색 하니까 인덕스 개념을 알아두고 사용하자.

DESCRIBE `member`;

# 조인 > 서브쿼리 -> 조인은 인덱스 타고, 서브쿼리는 안탄다.

EXPLAIN SELECT SQL_NO_CACHE *
FROM `member`
WHERE loginid = 'user2';

EXPLAIN SELECT SQL_NO_CACHE *
FROM `member`
WHERE nickname '이현철':

# 트랜잭션 예제

# 트랜잭션이란? - 하나의 업무단위를 뜻함. 하나의 업무에 사용되는 다수의 query는 모두 성공하거나 모두 실패해야한다는 뜻.

# 데이터의 무결성을 보장하기 위함.

DROP DATABASE IF EXISTS t1;
CREATE DATABASE t1;
USE t1;

CREATE TABLE ACCOUNT(
accountNo INT PRIMARY KEY AUTO_INCREMENT,
amount INT NOT NULL
);

DELETE FROM ACCOUNT;

INSERT INTO ACCOUNT SET amount = 20000;
INSERT INTO ACCOUNT SET amount = 10000;

SELECT \* FROM ACCOUNT;

SELECT @@autocommit;
SET autocommit = 1;

# 1 -> 2로 10000원 계좌 이체 #트랜잭션 시작

START TRANSACTION;

# 1의 계좌에 10000원 감소
UPDATE ACCOUNT
SET amount = amount - 10000
WHERE accountNo = 1;

SELECT \* FROM ACCOUNT;

# 만일 여기서 어떤 이유로 작업이 중단된다면

# 1의 계좌에서 10000원이 감소된 상태로 처리가 끝내게 되고, 2는 10000원을 받지 못하게 된다.

ROLLBACK; #만일 여기서 문제가 생기면 start transaction 부분으로 모든 작업을 되돌린다.

SELECT \* FROM ACCOUNT;

# 2의 계좌에 20000원 증가
UPDATE ACCOUNT
SET amount = amount + 10000
WHERE accountN0 = 2;

COMMIT; #여기까지 문제 없이 진행되면 start transaction ~ commit 사이에 있는 모든 내용을 DB에 반영한다. 
# 그렇지 않고 도중에 작업이 중단되면 중단된 시점에 처음으로 ROLLBACK을 수행한다.

SELECT \* FROM ACCOUNT;

################################

# 트랜잭션 시작 2
START TRANSACTION;

# 세이브 포인트1
SAVEPOINT svpt1;

#
UPDATE `account`
SET amount = 2
WHERE accountNo = 2;

# 세이브 포인트2
SAVEPOINT svpt2;

UPDATE `account`
SET amount = 1
WHERE accountNo = 1;

# 세이브 포인트3
SAVEPOINT svpt3;

SELECT \* FROM ACCOUNT;

ROLLBACK TO svpt1;

ROLLBACK TO svpt2;

ROLLBACK TO svpt3;

COMMIT;





