-- 날짜 : 2026/05/04
-- 이름 : 양지웅
-- 내용 : 1장 데이터베이스 개요 및 설치

# MySQL 접속 (콘솔환경)
#> mysql -u root -p;
#> -u: user, 사용자 계정
#> -p: password, 비밀번호

# 데이터베이스 생성, 제거
CREATE DATABASE mydb;
DROP DATABASE mydb;		-- 실행 단축키 : ctrl + enter

# 데이터베이스 목록 조회
SHOW DATABASES;

# 작업 데이터베이스 선택
USE mydb;
USE studydb;

---------------------------------------------------
# 일반 관리자 생성, 권한 부여, 반영
CREATE USER 'admin'@'%' IDENTIFIED BY '1234'; -- 유저 생성, %는 외부접속 IP를 의미
GRANT ALL PRIVILEGES ON MYDB.* TO 'admin'@'%'; -- admin 에게 mydb의 모든권한(CRUD) 부여
FLUSH PRIVILEGES; -- admin 계정권한 반영

# 비밀번호 변경
ALTER USER 'admin'@'%' IDENTIFIED BY 'abcd';

# 계정 삭제
DROP USER 'admin'@'%';

