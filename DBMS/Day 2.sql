# 예약어 reserved : 내장된 문법
# 예약어를 치면 sqlyog가 다르게 표시해준다

SHOW DATABASES; # 데이터베이스 조회

# 백틱(`)으로 감싸면 고유명사 취급 -> 예약어로 취급하지 않는다. 
CREATE DATABASE `member`; # member db 생성 

# 어떤 DB가 있는지 조회
SHOW DATABASES; 

# DB 생성
CREATE DATABASE b1; 

# DB 삭제
DROP DATABASE IF EXISTS b1; # b1 존재한다면 

# 어떤 DB를 쓸건지 선택 필요
USE `b1`;

# 어던 테이블을 가지고 있는지 조회 
SHOW TABLES;

SELECT * FROM `user`; # user라는 테이블 조회 
SELECT * FROM `help_category`;

# 테이블 생성 (데이터 타입 필수값)
CREATE TABLE `wktable`(
    title VARCHAR(100) # 100개의 문자를 담는다
    , `name` TEXT 
);

# 테이블 삭제
DROP TABLE `wktable`; # 테이블 자체를 삭제 (테이블은 안남는다.)
TRUNCATE TABLE `wktable`; # 데이터 초기화 (테이블은 남는다.)

# 테이블 조회
SELECT * FROM `wktable`;
SELECT * FROM `wktable` LIMIT 0, 5; # 가져오는 행의 개수 제한 

# 테이블 컬럼 데이터 추가
INSERT INTO `wktable` 
SET `title` = '제목1'
    ,`name` = '홍길동';
  
INSERT INTO `wktable`
SET `title` = '제목2'
    , `name` = '영희';

# 데이터 수정
UPDATE `wktable`
SET `title` = '수정 제목'
WHERE `title` = '제목2';

# 데이터 삭제
DELETE FROM `wktable`; # 해당 테이블의 데이터 전부 삭제

DELETE FROM `wktable`
WHERE `title` = '제목2'; # 조건에 부합하는 행 데이터 삭제

SELECT * FROM `wktable`;

SHOW TABLES; 


# 전체 데이터베이스 리스팅
SHOW DATABASES;

# `mysql` 데이터 베이스 선택
USE `mysql`;

# 테이블 리스팅
SHOW TABLES;

# `db` 테이블의 구조 확인
DESCRIBE `db`

# 기존에 `board` 데이터베이스가 존재 한다면 삭제
DROP DATABASE IF EXISTS `board`;

# 새 데이터베이스(`board`) 생성
CREATE DATABASE `board`;

# 데이터베이스 추가 되었는지 확인
SHOW DATABASES;

# `board` 데이터 베이스 선택
USE `board`;

# 테이블 확인
SHOW TABLES;

# 게시물 테이블(`article`)을 만듭니다.
CREATE TABLE `article`(
    `title` CHAR(100)
    ,`body` TEXT
);

# 잘 추가되었는지 확인
SHOW TABLES;

# 제목은 '제목1', 내용은 '내용1'인 데이터 하나 추가 
INSERT INTO `article`
SET `title` = '제목1'
    , `body` = '내용1';

# 제목 조회
SELECT `title` FROM `article`;

# 내용 조회
SELECT `body` FROM `article`;

# 제목, 내용 칼럼 데이터 조회
SELECT `title`, `body`
FROM `article`;

# 내용, 제목 칼럼 데이터 조회
SELECT `body`, `title`
FROM `article`;

# 모든 데이터 조회
SELECT * FROM `article`;

# 제목1, 내용1 데이터 추가
INSERT INTO `article`
SET `title` = '제목1'
    , `body` = '내용1';

# 제목2, 내용2 데이터 추가
INSERT INTO `article`
SET `title` = '제목2'
    , `body` = '내용2';

# 데이터 조회
SELECT * FROM `article`;

# 제목 데이터 aaa로 수정(모두 수정됨..)
UPDATE `article`
SET `title` = 'aaa';

# `body`가 내용2인 것만 조회
SELECT * FROM `article`
WHERE `body` = '내용2';

# 내용2만 새로운내용2 로 수정
UPDATE `article` 
SET `body` = '새로운 내용2'
WHERE `body` = '내용2';

# 데이터 조회
SELECT * FROM `article`;

# 데이터 삭제 (모든 데이터가 삭제...)
DELETE FROM `article`;

# 다시 
# 제목1, 내용1 데이터 추가
INSERT INTO `article`
SET `title` = '제목1'
    , `body` = '내용1';

# 제목2, 내용2 데이터 추가
INSERT INTO `article`
SET `title` = '제목2'
    , `body` = '내용2';

# 제목이 제목1인 것만 삭제
DELETE FROM `article` 
WHERE `title` = '제목1';




















