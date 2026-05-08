# 실습 1-2
USE shop;

CREATE TABLE Customer (
	custid VARCHAR(10) PRIMARY KEY,
    name   VARCHAR(10) NOT NULL,
    hp     CHAR(13) UNIQUE DEFAULT NULL,
    addr   VARCHAR(100) DEFAULT NULL,
    rdate  DATE NOT NULL
);

CREATE TABLE Product (
	prodNo INT PRIMARY KEY,
    prodName VARCHAR(10) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    price INT DEFAULT NULL,
    company VARCHAR(20) NOT NULL
);

CREATE TABLE `Order` (
	orderNo INT PRIMARY KEY AUTO_INCREMENT,
    orderId VARCHAR(10) NOT NULL,
    orderProduct INT NOT NULL,
    orderCount INT NOT NULL DEFAULT 1,
    orderDate DATETIME NOT NULL
);

# 실습 1-3
-- 고객 테이블
INSERT INTO Customer VALUES ('c101', '김유신', '010-1234-1001', '김해시 봉황동', '2022-01-01');
INSERT INTO Customer VALUES ('c102', '김춘추', '010-1234-1002', '경주시 보문동', '2022-01-02');
INSERT INTO Customer VALUES ('c103', '장보고', '010-1234-1003', '완도군 청산면', '2022-01-03');
INSERT INTO Customer VALUES ('c104', '강감찬', '010-1234-1004', '서울시 마포구', '2022-01-04');
INSERT INTO Customer VALUES ('c105', '이성계', NULL, NULL, '2022-01-05');
INSERT INTO Customer VALUES ('c106', '정철', '010-1234-1006', '경기도 용인시', '2022-01-06');
INSERT INTO Customer VALUES ('c107', '허준', NULL, NULL, '2022-01-07');
INSERT INTO Customer VALUES ('c108', '이순신', '010-1234-1008', '서울시 영등포구', '2022-01-08');
INSERT INTO Customer VALUES ('c109', '송상현', '010-1234-1009', '부산시 동래구', '2022-01-09');
INSERT INTO Customer VALUES ('c110', '정약용', '010-1234-1010', '경기도 광주시', '2022-01-10');

-- 제품 테이블
INSERT INTO Product VALUES (1, '새우깡', 5000, 1500, '농심');
INSERT INTO Product VALUES (2, '초코파이', 2500, 2500, '오리온');
INSERT INTO Product VALUES (3, '포카칩', 3600, 1700, '오리온');
INSERT INTO Product VALUES (4, '양파링', 1250, 1800, '농심');
INSERT INTO Product VALUES (5, '죠리퐁', 2200, NULL, '크라운');
INSERT INTO Product VALUES (6, '마카렛트', 3500, 3500, '롯데');
INSERT INTO Product VALUES (7, '뿌셔뿌셔', 1650, 1200, '오뚜기');

-- 주문 테이블
INSERT INTO `Order` VALUES (NULL, 'c102', 3, 2, '2022-07-01 13:15:10');
INSERT INTO `Order` VALUES (NULL, 'c101', 4, 1, '2022-07-01 14:16:11');
INSERT INTO `Order` VALUES (NULL, 'c108', 1, 1, '2022-07-01 17:23:18');
INSERT INTO `Order` VALUES (NULL, 'c109', 6, 5, '2022-07-02 10:46:36');
INSERT INTO `Order` VALUES (NULL, 'c102', 2, 1, '2022-07-03 09:15:37');
INSERT INTO `Order` VALUES (NULL, 'c101', 7, 3, '2022-07-03 12:35:12');
INSERT INTO `Order` VALUES (NULL, 'c110', 1, 2, '2022-07-03 16:55:36');
INSERT INTO `Order` VALUES (NULL, 'c104', 2, 4, '2022-07-04 14:23:23');
INSERT INTO `Order` VALUES (NULL, 'c102', 1, 3, '2022-07-04 21:54:34');
INSERT INTO `Order` VALUES (NULL, 'c107', 6, 1, '2022-07-05 14:21:03');

# 실습 1-4
SELECT * FROM Customer;

# 실습 1-5
SELECT custid, name, hp FROM Customer;

# 실습 1-6
SELECT * FROM Product;

# 실습 1-7
SELECT company FROM Product;

# 실습 1-8
SELECT company FROM Product
GROUP BY company;

# 실습 1-9
SELECT prodName, price FROM Product;

# 실습 1-10
SELECT prodName, price+500 '조정단가'
FROM Product;

# 실습 1-11
SELECT prodName, stock, price FROM Product
WHERE company = '오리온';

# 실습 1-12
SELECT orderProduct, orderCount, orderDate FROM `Order`
WHERE orderId = 'c102';

# 실습 1-13
SELECT orderProduct, orderCount, orderDate FROM `Order`
WHERE orderCount >= 2
AND orderId = 'c102';

# 실습 1-14
SELECT * FROM Product
WHERE price >= 1000 AND price <= 2000;

# 실습 1-15
SELECT custid, name, hp, addr FROM Customer
WHERE name LIKE '김%';

# 실습 1-16
SELECT custid, name, hp, addr FROM Customer
WHERE name LIKE '__';

# 실습 1-17
SELECT * FROM Customer WHERE hp IS NULL;

# 실습 1-18
SELECT * FROM Customer WHERE addr IS NOT NULL;

# 실습 1-19
SELECT * FROM Customer ORDER BY rdate DESC;

# 실습 1-20
SELECT * FROM `Order` WHERE orderCount >=3
ORDER BY orderCount DESC, orderProduct ASC;

# 실습 1-21
select avg(price) from product;

# 실습 1-22
select sum(stock) '재고량 합계' from product where company = '농심';

# 실습 1-23
select count(custid) '고객수' from customer;

# 실습 1-24
select count(distinct company) '제조업체 수' from product;

# 실습 1-25
select orderproduct as '주문 상품번호', sum(ordercount) '총 주문수량'
from `Order` group by orderproduct
order by orderproduct;

# 실습 1-26
select company '제조업체', count(*) '제품수', max(price) '최고가'
from product group by company
order by company;

# 실습 1-27
select company '제조업체', count(*) '제품수', max(price) '최고가'
from product group by company having 제품수 >= 2;

# 실습 1-28
select orderproduct, orderid, sum(orderCount) '총 주문수량'
from `order`
group by orderproduct, orderid
order by orderproduct;

# 실습 1-29
select * from `order`;
select * from `product`;
select a.orderId, b.prodName FROM `order` as a
JOIN product b ON a.orderProduct = b.prodNo
where orderid = 'c102';

# 실습 1-30
select orderid, name, prodName, orderDate from `order` as a
JOIN customer as b ON a.orderId = b.custId
JOIN Product c ON a.orderProduct = c.prodNo
WHERE orderDate LIKE '2022-07-03%';


