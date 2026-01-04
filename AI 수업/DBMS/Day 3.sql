DROP DATABASE IF EXISTS `study_db`;
CREATE DATABASE `study_db`;
USE `study_db`;

SHOW TABLES;

# db 기본단위 : table 
CREATE TABLE `article`(
	`title` CHAR(100)
	, `body` TEXT
);

# alter 테이블 층위에서 수정
ALTER TABLE `article` ADD COLUMN `id` INT;
ALTER TABLE `article` DROP COLUMN `id`;
ALTER TABLE `article` MODIFY `id` VARCHAR(5);
ALTER TABLE `artilce` RENAME TO `writing`;

DESCRIBE `article`;
DESCRIBE `writing`;
SELECT * FROM `article`

## 문제풀이

# 전체 데이터베이스 리스팅
SHOW DATABASES;

# `mysql` 데이터 베이스 선택
USE `mysql`;

# 테이블 리스팅
SHOW TABLES;

# 특정 테이블의 구조
DESCRIBE `column_stats`;

# `test` 데이터 베이스 선택
USE `test`;

# 테이블 리스팅
SHOW TABLES;

# 기존에 a1 데이터베이스가 존재 한다면 삭제
DROP DATABASE IF EXISTS `a1`; 

# 새 데이터베이스(`a1`) 생성
CREATE DATABASE `a1`;

# 데이터베이스(`a1`) 선택
USE `a1`;

# 데이터베이스 추가 되었는지 확인
SHOW DATABASES;

# 테이블 확인
SHOW TABLES;

# 게시물 테이블 article(title, body)을 만듭니다.
# VARCHAR(100) => 문자 100개 저장가능
# text => 문자 많이 저장가능
CREATE TABLE `article`(
	`title` VARCHAR(100)
	, `body` TEXT
);

# 잘 추가되었는지 확인, 리스팅과 구조까지 확인
DESCRIBE `article`;
SELECT * FROM `article`

# 데이터 하나 추가(title = 제목, body = 내용)
INSERT INTO `article`
SET `title` = '제목1'
    , `body` = '내용';

# 데이터 조회(title 만)
SELECT `title` FROM `article`;

# 데이터 조회(title, body)
SELECT `title`, `body` FROM `article`;

# 데이터 조회(body, title)
SELECT `body`, `title` FROM `article`;

# 데이터 조회(*)
SELECT * FROM `article`;

# 데이터 또 하나 추가(title = 제목, body = 내용)
INSERT INTO `article`
SET `title` = '제목'
    , `body` = '내용';

# 데이터 조회(*, 어떤게 2번 게시물인지 알 수 없음)
SELECT * FROM `article`;

# 테이블 구조 수정(id 칼럼 추가, first) first는 칼럼의 순서 최상단으로.
ALTER TABLE `article` ADD COLUMN `id` INT FIRST;

# 데이터 조회(*, id 칼럼의 값은 NULL)
SELECT * FROM `article`;

# 기존 데이터에 id값 추가(id = 1, id IS NULL)
INSERT INTO `article`
SET `id` = 1
WHERE `id` IS NULL;

# 데이터 조회(*, 둘다 수정되어 버림..)
SELECT * FROM `article`;

# 기존 데이터 중 1개만 id를 2로 변경(LIMIT 1)
UPDATE `article` 
SET `id` = 2
LIMIT 1;

# 데이터 조회(*)
SELECT * FROM `article`;

# 데이터 1개 추가(id = 3, title = 제목3, body = 내용3)
INSERT INTO `article`
SET `id` = 3
    , `title` = '제목3'
    , `body` = '내용3'

# 데이터 조회(*)
SELECT * FROM `article`;

# 2번 게시물, 데이터 삭제 => DELETE
DELETE FROM `article`
WHERE `id` = 2;

# 데이터 조회(*)
SELECT * FROM `article`;

# 날짜 칼럼 추가 => regDate DATETIME
ALTER TABLE `article` ADD COLUMN `regDate` DATETIME;

# 테이블 구조 확인
DESCRIBE `article`

# 데이터 조회(*, 날짜 정보가 비어있음)
SELECT * FROM `article`;

# 1번 게시물의 비어있는 날짜정보 채움(regDate = 2018-08-10 15:00:00)
UPDATE `article` 
SET `regDate` = '2018-08-10 15:00:00'
WHERE `id` = 1;

# 데이터 조회(*, 이제 2번 게시물의 날짜 정보만 넣으면 됩니다.)
SELECT * FROM `article`;

# NOW() 함수 실행해보기
SELECT NOW() FROM DUAL;

# 3번 게시물의 비어있는 날짜정보 채움(NOW())
UPDATE `article`
SET `regDate` = NOW()
WHERE `id` = 3;

# 데이터 조회(*)
SELECT * FROM `article`;



# 제약조건 - 칼럼
CREATE TABLE `test`(
    `id` INT
    , `content` TEXT
);
DROP TABLE `test`;

DESCRIBE `test`;
ALTER TABLE `test` MODIFY `id` INT NOT NULL DEFAULT 1;
ALTER TABLE `test` MODIFY `id` INT NOT NULL;
ALTER TABLE `test` MODIFY `id` INT;
ALTER TABLE `test` MODIFY `id` INT UNIQUE;
ALTER TABLE `test` MODIFY `id` INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE `test` MODIFY `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE `test` MODIFY `content` TEXT NOT NULL;

SELECT * FROM `test`;

INSERT INTO `test`
SET `id` = 2 
    ,`content` = '컨텐츠';
    
INSERT INTO `test`
SET `content` = '컨텐츠2'
# int 형식에서 not null 조건이 걸린 경우 default 값은 0이다. 

INSERT INTO `test`
SET `id` = -4;
    
# 함수.연산
SELECT 7 + 10 FROM DUAL; # 더미 테이블 DUAL
SELECT 15*5;
SELECT UPPER('abc');
SELECT * FROM `test`
WHERE `id` = 1-5;

SELECT AVG(`id`);

## 문제2
DROP TABLE `article`;
CREATE TABLE `article`(
    `title` CHAR(100)
    , `body` TEXT
);
INSERT INTO `article`;
SET `title` = '제목1'
    ,`body` = '내용1';
INSERT INTO `article`;
SET `title` = '제목2'
    , `body` = '내용2';
SELECT * FROM `article`;

# 제목2인 데이터 삭제
DELETE FROM `article`
WHERE `title` = '제목2';

# 제목3, 내용3 데이터 두개 추가
INSERT INTO `article`
SET `title` = '제목3'
    , `body` = '내용3';

# 제목3인 게시물 중 두번째 것만 제목을 새제목3으로 수정 (게시물 구분 안됨)
# -> 못하는 의뢰 (정확하게 어떤 게 두번째 글인지 알 수 없음)

# 테이블 구조 확인
DESCRIBE `article`

# 테이블 구조 수정 - 칼럼 추가(ADD), 기존 칼럼 삭제(DROP), 기존 칼럼 내용 변경(MODIFY)

# 데이터 조회(새로 생긴 id 칼럼의 값은 NULL)

# 기존 데이터에 id값 추가

# 기존 데이터 중 1개만 id를 2로 변경
 
# 데이터 조회

# 2번 게시물만 조회

# 2번 게시물, 데이터 삭제 => DELETE

# 데이터 조회

# 1번 게시물 제목을 제목2로 변경 => UPDATE

# 데이터 조회

# 모든 데이터 삭제

# 데이터 조회









