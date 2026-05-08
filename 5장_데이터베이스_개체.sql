# 날짜 : 2026/05/08
# 이름 : 양지웅
# 내용 : 5장 데이터베이스 개체

# 실습 5-1
SHOW INDEX FROM USER1;
SHOW INDEX FROM USER2;
SHOW INDEX FROM USER3;
SELECT * FROM USER3;

# 실습 5-2 인덱스 생성
CREATE INDEX idx_user1_userid ON User1(userid);
analyze TABLE user1;

# 실습 5-3 인덱스 삭제
DROP INDEX idx_user1_userid ON User1;

# 실습 5-4
SELECT * FROM User1; -- Result View
CREATE VIEW vw_user1 AS (SELECT name, hp, age FROM user1);
SELECT * FROM vw_user1;

CREATE VIEW vw_user4_age_under30 AS (SELECT * FROM User4 WHERE age < 30);

CREATE VIEW vw_Employee_with_sales AS (
	SELECT
		a.empno AS 직원번호,
        b.name AS 직원이름,
        b.job 직급,
        c.dname 부서명,
        a.year 매출년도,
        a.month 월,
        a.price 매출액
	FROM Sale a
    JOIN Employee b ON a.empno = b.empno
    JOIN Dept c ON b.depno = c.depno
);
SELECT * FROM vw_Employee_with_sales;

# 실습 5-5
SELECT * FROM vw_user1;
SELECT * FROM vw_user4_age_under30;

# 실습 5-6
DROP VIEW vw_user1;
DROP VIEW vw_user4_age_under30;

# 실습 5-7
DELIMITER $$
	CREATE PROCEDURE proc_test1()
    BEGIN
		SELECT * FROM Employee;
        SELECT * FROM Dept;
	END $$
	DELIMITER ;

CALL proc_test1();	-- 프로시저 호출

# 실습 5-8 매개변수를 갖는 프로시저 생성 및 실행
DELIMITER $$
	CREATE PROCEDURE proc_test2(IN _userName VARCHAR(10))
    BEGIN
		SELECT * FROM Employee WHERE name=_userName;
	END $$
    DELIMITER ;
    
CALL proc_test2('김유신');

DELIMITER $$
	CREATE PROCEDURE proc_test3(IN _job VARCHAR(10), IN _depno TINYINT)
	BEGIN
	 SELECT * FROM Employee WHERE job=_job AND depno=_depno;
	END $$
	DELIMITER ;
    
CALL proc_test3('차장', 101);

DELIMITER $$
	CREATE PROCEDURE proc_test4(IN _job VARCHAR(10), OUT _count INT)
	BEGIN
	 SELECT COUNT(*) INTO _count FROM Employee WHERE job=_job;
	END $$
	DELIMITER ;
    
CALL proc_test4('대리', @_count);
SELECT CONCAT('_count : ', @_count)

# 실습 5-9
DELIMITER $$
	CREATE PROCEDURE proc_test5(IN _name VARCHAR(10))
    BEGIN
		DECLARE _empno INT;
        SELECT empno into _empno from Employee where name = _name;
        SELECT * FROM sale WHERE empno = _empno;
	END $$
    DELIMITER ;

CALL proc_test5('김유신');

DELIMITER $$
	CREATE PROCEDURE proc_test6()
	BEGIN
		DECLARE num1 INT;
		DECLARE num2 INT;

		SET num1 = 1;
		SET num2 = 2;

		IF (NUM1 > NUM2) THEN
		SELECT 'NUM1이 NUM2보다 크다.' as 결과2;
		ELSE
		SELECT 'NUM1이 NUM2보다 작다.' as 결과2;
		END IF;
	END $$
	DELIMITER ;
    
CALL proc_test6();

# 실습 5-10 커서를 활용한 프로시저
drop procedure proc_test8;

DELIMITER $$
	create procedure proc_test8()
    BEGIN
		# 변수 선언
        DECLARE total INT DEFAULT 0;
        DECLARE v_price INT; -- 변수명이 테이블에 컬럼명과 같으면 오류
        DECLARE endOfRow BOOLEAN DEFAULT false;
        
        # 커서 선언 : 테이블의 특정 컬럼을 포인팅하는 가상개채
        DECLARE saleCursor CURSOR FOR
			SELECT price FROM Sale;
            
		# 반복 조건 : 예외 처리를 위한 endOfRow가 더이상 자료가없다면 TRUE로 바뀌도록 선언
        DECLARE CONTINUE handler
			FOR NOT FOUND SET endOfRow = TRUE;
            
		# 커서 열기
        OPEN saleCursor;
        
        cursor_loop: LOOP
			FETCH saleCursor INTO v_price;
            
            IF endOfRow THEN
				LEAVE cursor_loop;
			END IF;
            
            SET total = total + v_price;
		END LOOP;
        
        SELECT total '전체 합계';
        
        CLOSE saleCursor;
	END $$
    DELIMITER ;

CALL proc_test8();

# 실습 5-11
-- root로 접속해서 아래 환경설정 후 다시 함수 생성
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION func_test1(_empno INT) RETURNS INT
	BEGIN
		DECLARE total INT;
		SELECT SUM(price) INTO total FROM Sale WHERE empno = _empno;
		RETURN total;
	END $$
	DELIMITER ;

SELECT func_test1(1001); -- 함수는 SELECT, 프로시저는 CALL

DELIMITER $$
	CREATE FUNCTION func_test2(_price INT) RETURNS DOUBLE
	BEGIN
		DECLARE bonus DOUBLE;

		IF (_price >= 100000) THEN
			SET bonus = _price * 0.1;
		ELSE
			SET bonus = _price * 0.05;
		END IF;

		RETURN bonus;
	END $$
	DELIMITER ;

-- 함수 호출 및 조회 부분
SELECT 
    empno,
    year,
    month,
    price,
    func_test2(price) AS bonus
FROM Sale;
