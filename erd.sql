# 날짜 : 2026/05/20
# 이름 : 양지웅
# 내용 : ERD 실습

use shoperd;

# 실습 6-2

insert into customer (custId, `name`, hp, addr, rdate) VALUES
("c101", "김유신", "010-1234-1001", "경남 김해시", "2023-01-01"),
("c102", "김춘추", "010-1234-1002", "경남 경주시", "2023-01-02"),
("c103", "장보고", "010-1234-1003", "전남 완도구", "2023-01-03"),
("c104", "강감찬", "010-1234-1004", "서울시 관악구", "2023-01-04"),
("c105", "이순신", "010-1234-1005", "부산시 금정구", "2023-01-05");
select * from customer;

INSERT INTO Product (prodNo, prodName, stock, price, company) VALUES
(1, '새우깡', 5000, 1500, '농심'),
(2, '초코파이', 2500, 2500, '오리온'),
(3, '포카칩', 3600, 1700, '오리온'),
(4, '양파링', 1250, 1800, '농심'),
(5, '죠리퐁', 2200, NULL, '크라운');
select * from product;

INSERT INTO `Order` (orderId, orderProduct, orderCount, orderDate) VALUES
('c102', 3, 2, '2023-01-01 13:15:10'),
('c101', 4, 1, '2023-01-01 13:15:12'),
('c102', 1, 1, '2023-01-01 13:15:14'),
('c103', 5, 5, '2023-01-01 13:15:16'),
('c105', 2, 1, '2023-01-01 13:15:18');
select * from `order`;

# 실습 6-3
#1
select c.name, b.prodname, a.ordercount, a.orderdate from `order` a
join product b on a.orderproduct = b.prodno
join customer c on a.orderid = c.custid;
#2
select orderno, prodno, prodname, price, ordercount, orderdate
from `order` a join product b on a.orderproduct = b.prodno
join customer c on a.orderid = c.custid
where c.name = "김유신";
#3
select sum(b.price * a.ordercount) "총 주문 금액"
from `order` a join product b on a.orderproduct = b.prodno;

# 실습 6-4
use bankerd;

# 6-5 뱅크
select * from bank_customer;
INSERT INTO bank_customer (c_no, c_name, c_dist, c_phone, c_addr) VALUES
('730423-1000001', '김유신', 1, '010-1234-1001', '경남 김해시'),
('730423-1000002', '김춘추', 1, '010-1234-1002', '경남 경주시'),
('750423-1000003', '장보고', 1, '010-1234-1003', '전남 완도군'),
('102-12-51094', '(주)정보산업', 2, '051-500-1004', '부산시 부산진구'),
('930423-1000005', '이순신', 1, '010-1234-1005', '서울 종로구');

INSERT INTO bank_account (a_no, a_item_dist, a_item_name, a_c_no, a_balance, a_open_date) VALUES
('101-11-1001', 'S1', '자유저축예금', '730423-1000001', 1550000, '2011-04-11'),
('101-11-1002', 'S1', '자유저축예금', '930423-1000005', 260000, '2011-05-12'),
('101-11-1003', 'S1', '자유저축예금', '750423-1000003', 750000, '2011-06-13'),
('101-12-1001', 'S2', '기업전용예금', '102-12-51094', 15000000, '2011-07-14'),
('101-13-1001', 'S3', '정기저축예금', '730423-1000002', 1200000, '2011-08-15');

INSERT INTO bank_transaction (t_a_no, t_dist, t_amount, t_datetime) VALUES
('101-11-1001', 1, 50000, '2023-01-01 13:15:10'),
('101-12-1001', 2, 1000000, '2023-01-02 13:15:12'),
('101-11-1002', 3, 260000, '2023-01-03 13:15:14'),
('101-11-1002', 2, 100000, '2023-01-04 13:15:16'),
('101-11-1003', 3, 75000, '2023-01-05 13:15:18'),
('101-11-1001', 1, 150000, '2023-01-05 13:15:28');

# 실습 6-6
#1
select c_no, c_name, c_phone, a_no, a_item_name, a_balance
from bank_customer c join bank_account a on c.c_no = a.a_c_no;
#2
select t_dist, t_amount, t_datetime
from bank_transaction t join bank_account a on t.t_a_no = a.a_no
join bank_customer c on c.c_no = a.a_c_no
where c.c_name = "이순신";

select c_no, c_name, a_no, a_balance, a_open_date
from bank_transaction t join bank_account a on t.t_a_no = a.a_no
join bank_customer c on c.c_no = a.a_c_no
where c_dist = 1
order by a_balance desc
LIMIT 1;

use collegeerd;

# 실습 6-8
INSERT INTO Student (stdNo, stdName, stdHp, stdYear, stdAddress) VALUES
(20201011, '김유신', '010-1234-1001', 3, '경남 김해시'),
(20201122, '김춘추', '010-1234-1002', 3, '경남 경주시'),
(20210213, '장보고', '010-1234-1003', 2, '전남 완도군'),
(20210324, '강감찬', '010-1234-1004', 2, '서울 관악구'),
(20220415, '이순신', '010-1234-1005', 1, '서울 종로구');

INSERT INTO Lecture (lecNo, lecName, lecCredit, lecTime, lecClass) VALUES
(101, '컴퓨터과학 개론', 2, 40, '본301'),
(102, '프로그래밍 언어', 3, 52, '본302'),
(103, '데이터베이스', 3, 56, '본303'),
(104, '자료구조', 3, 60, '본304'),
(105, '운영체제', 3, 52, '본305');

INSERT INTO Register (regStdNo, regLecNo, regMidScore, regFinalScore, regTotalScore, regGrade) VALUES
(20220415, 101, 60, 30, NULL, NULL),
(20210324, 103, 54, 36, NULL, NULL),
(20201011, 105, 52, 28, NULL, NULL),
(20220415, 102, 38, 40, NULL, NULL),
(20210324, 104, 56, 32, NULL, NULL),
(20210213, 103, 48, 40, NULL, NULL);

#실습 6-9
#1
select stdno, stdname, stdhp, stdyear
from student s left join register r on s.stdno = r.regstdno
where regstdno is null;
#2
select * from register;
update register set regtotalscore = (regmidscore + regfinalscore);
update register set reggrade = CASE
								when regtotalscore >=90 then 'A'
                                when regtotalscore >=80 then 'B'
                                when regtotalscore >=70 then 'C'
                                when regtotalscore >=60 then 'D'
                                ELSE 'F'
							END;

#3
select stdno, stdname, stdyear, lecname, 
	   regmidscore, regfinalscore, regtotalscore, reggrade
from student s join register r on s.stdno = r.regstdno
join lecture l on r.reglecno = l.lecno
where stdyear = 2;

















