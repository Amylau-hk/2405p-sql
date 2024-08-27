-- comment
-- database -> table (row x column)
create database db_bc2405p;

-- login
use db_bc2405p;

-- Table name is per database
create table customers (
	id int,
    name varchar(50),
    email varchar(50)
);

-- insert into table_name (column_name1, ....) values (column1_value, ....);
-- must be match the corresponding position the name with values
insert into customers (id, name, email) values (1, 'John Lau', 'john@gmail.com');
insert into customers (id, name, email) values (2, 'Peter Wong', 'peter@gmail.com');

-- "*" means all columns
-- "where" means coditions on columns
select * from customers;
select * from customers where id = 2;
select * from customers where id = 1 or id = 2;
select * from customers where id = 1 and id = 2; -- no data matches this criteria
select name, email from customers where id = 1; -- John, john@gamil.com
-- the column name between "select" and "from" are the values that you wanna show

-- order by
select * from customers order by id; -- asc
select * from customers order by id asc;
select * from customers order by id desc;

-- where (filter), order by (sort)
select * from customers where id = 1 order by id desc;
-- "select", "where", "order by" can process in the same row

create table student (
	id integer, -- int
	name varchar(20),
    weight numeric(5,2), -- 5-2,(integer) 2 (decimal place) -> xxx.xx
    height numeric(5,2) 
 );   
 
insert into student (id, name, weight, height) values (1, 'John Lau', 77.9, 178.2);
insert into student (id, name, weight, height) values (2, 'Peter Wong', 87.9, 188.2);
insert into student (id, name, weight, height) values (3.5, 'Jenny Wong', 87.9, 188.2);
insert into student (id, name, weight, height) values (3.4, 'Tom Wong', 87.9, 188.2);

insert into student (id, name, weight, height) values (5, 10, 87.9, 188.2);
insert into student (id, name, weight, height) values (6, 'Sally Wong', 87.555, 188.2);

select * from student;
-- create table -> datetime, integer, numeric(x, x), varchar(x)


-- you can skip some column(s) when you execute insert statement
insert into student (id, name, weight) values (7, 'Benny Wong', 65.7);
 select * from student;
 
 -- If you dont specify the columns name, then you have to put all column values
 insert into student values (8, 'Stephen Wong', null, 174.3);
 
 -- DDL (Data Definition Language): create table, add/drop column, modify column definition
 -- DML (Data Manipulation Language): insert row, update columm, delete row, truncate table(delete all data)

-- +, -, *, /, % 
 select weight + height as ABC, weight, height, id, name from student;
 select s.weight + s.height as DEF, s.* from student s where s.weight > 65.5 order by name;
 
 -- >, <, >=, <=, <> / !=, =
 select * from student where id <> 6 and id <> 8;
 
 -- not in
 select * from student where id not in (6, 8);
 
 -- in
 select * from student where id in (1,2,3);
 
 select * from student where name ='John Wong';
 
 -- like, not like
 select * from student where name like '%Wong%'; -- Any name with prefix(0 or more characters) and suffix (0 or more character)
 select * from student where name like '%Wong'; -- end with Wong
 
 select * from student where name not like '%Wong';
 
 -- Null check
 select * from student where weight is null or height is null;
 
 -- Functions
 insert into student (id, name, weight, height) values (9, '陳小強', 68.55, 188.6);
 select char_length(s.name) as name_char_lenght, length(s.name) as name_lenght, s.* from student s;
 
 -- substring() -> start from 1
 select upper(s.name), lower(s.name), substring(s.name, 1, 3), trim(s.name), replace(s.name, 'Wong', 'Chan'), s.* from student s;
 
 -- Java: indexOf(), DB: instr() return position
 -- position starts from 1
 -- if not found, return 0
 select instr(s.name, 'Wong'), s.* from student s;
 
 create table orders(
	id integer,
    total_amount numeric(10, 2),
    customer_id integer
 );
 
 select * from orders; -- List<Order>
 insert into orders values (1, 2005.10, 2);
 insert into orders values (2, 10000.9, 2);
 insert into orders values (3, 99.9, 1);
 
 -- sum()
 select sum(o.total_amount) from orders o;
 select avg(o.total_amount) from orders o where customer_id = 2;
 
 -- filter first, and then mmin(), max()
 select min(o.total_amount), max(o.total_amount) from orders o where customer_id = 2;
 select min(o.total_amount), max(o.total_amount) from orders o;

select o.*, 1 as number, 'hello' as string from orders o;
 
 -- why can we put all functions in select statement?
 -- Ans: Aggregation functions -> result must be 1 row
 select min(o.total_amount), max(o.total_amount), sum(o.total_amount), avg(o.total_amount), count(o.total_amount) from orders o;
 
-- o.total_amount -> NOT an aggregation result
select o.total_amount, sum(o.total_amount) from orders o; -- error

-- group by
select * from orders;

-- group by -> select "group key"(Not a must) and agg functions
select o.customer_id, sum(o.total_amount), avg(o.total_amount), min(o.total_amount), max(o.total_amount), count(1) from oders o group by customer_id;
1	99.9	
2	12006.00

select o.customer_id, sum(o.total_amount), o.id from oders o group by customer_id; -- NOT OK, why?

-- Group by + Having
insert into orders values (4, 10000.00, 3);
insert into orders values (5, 20000, 3);

select o.customer_id, avg(o.total_amount) as avg_amount
from orders o where o.customer_id in (2, 3) -- first filter before group by (5 row -> 4 rows) -> result 4 rows x 3 columns
group by o.customer_id -- 2 rows x 2 columns
having avg(o.total_amount) > 10000 -- another filter after group by (result): 1 row x 2 columns
order by avg(o.total_amount) desc
;

-- 2 tables (one to many)
-- where, group by, having, order by

-- example: authors and books

select * from customers where name = 'JOHN LAU'; -- case insenstive
select * from customers where UPPER(name) = 'JOHN LAU'; -- if case senstive, we should use upper() or lower()

select * from customers where name like '%HN%'; -- any words start and end with 'HN'
select * from customers where name like 'JO%LAU'; -- start with 'JO' end with 'LAU'
select * from customers where name like '_OHN LAU'; -- '_' any one character
select * from customers where name like '_HN%'; 

select ROUND(o.total_amount, 0), total_amount from orders o;
select ROUND(o.total_amount, 0), o.* from orders o;

select ceil(o.total_amount), floor(o.total_amount), round(o.total_amount, 0), total_amount from orders o;

select power(2, 3) AS result; -- 2^3

select 1, abs(-5) from dual;


-- Date formatting (MYSQL)
select DATE_FORMAT('2023-08-15', '%Y-%m-%d') from dual;
select DATE_FORMAT('2023-08-15', '%Y-%m-%d') + INTERVAL 1 DAY from dual;
select STR_TO_DATE('2024-12-31', '%Y-%m-%d') + INTERVAL 1 DAY from dual;

-- Oracle
select to_date('20240831', 'YYYYMMDD') + 1 from dual;

-- Extract Year or Month or Day (MySQL)
SELECT EXTRACT(YEAR FROM FATE_FORMAT('2023-08-15', '%Y-%M-%D')) FROM DUAL;
SELECT EXTRACT(MONTH FROM FATE_FORMAT('2023-08-15', '%Y-%M-%D')) FROM DUAL;
SELECT EXTRACT(DAY FROM FATE_FORMAT('2023/08/15', '%Y/%M/%D')) FROM DUAL;

RESULT:
2024 2
2023 2
2022 1

SELECT EXTRACT(YEAR FROM tran_date) as YEAR, count(1) as NUMBER_OF_ORDERS
FROM orders
group by EXTRACT(YEAR FROM tran_date)
HAVING count(1) >= 2
;

select * from orders;
alter table orders add column tran_date date; -- DDL

update orders
set tran_date = DATE_FORMAT('2023-08-31', '%y-%m-%d')
where id = 1;

update orders
set tran_date = DATE_FORMAT('2023-08-02', '%y-%m-%d')
where id = 2;

update orders
set tran_date = DATE_FORMAT('2023-08-04', '%y-%m-%d')
where id = 3;

update orders
set tran_date = DATE_FORMAT('2024-02-28', '%y-%m-%d')
where id = 4;

update orders
set tran_date = DATE_FORMAT('2022-08-01', '%y-%m-%d')
where id = 5;

-- COALESCE / IFNULL doesnt update the original data
select ifnull(s.weight, 'N/A'), ifnull(s.height, 'N/A'), s.* from student s;
select COALESCE(s.weight, 'N/A'), COALESCE(s.height, 'N/A'), s.* from student s;

-- < 2000 -> 'S'
-- >= 2000 and < 10000 -> 'M'
-- > 10000 -> 'L'
select CASE
		WHEN o.total_amount < 2000 THEN 'S'
        -- WHEN o.total_amount >= 2000 AND o.total_amount < 10000 THEN 'M'
        WHEN o.total_amount between 2000 and 10000 THEN 'M' -- BETWEEN IS INCLUDE >= 2000 and <= 10000 -> 'M'
        ELSE 'L'
	END AS category
	, o.*
from orders o;

-- between (inclusive)
select * 
from orders 
where tran_date between DATE_FORMAT('2023-08-31', '%y-%m-%d')
and DATE_FORMAT('2023-12-04', '%y-%m-%d');

-- EXISTS (customers, orders)
-- find the customer(s) who has order(s)

insert into customers values (3, 'Jenny Yu', 'jennyyu@hotmail.com'); 
insert into customers values (4, 'Benny Kwok', 'bennykwok@hotmail.com'); 
select * from customers;
select * from orders;

-- "o.customer_id = c.id" -> check if the customer exists in orders
-- Approach 1 (you cannot select columns from order table)
select *
from customers c
where not exists (select 1 from orders o where o.customer_id = c.id); 

-- JOIN tables
-- 4 customers x 6 orders -> 24 rows
select * from customers c inner join orders o; -- on 

-- INNER JOIN is similar to EXISTS
-- Approach 2 (Combine all data together, able to view all data in the table)
select c.*, o.* from customers c inner join orders o on o.customer_id = c.id;

select * from orders;

insert into orders values (6, 9999, 3, DATE_FORMAT('2024-08-04', '%y-%m-%d'));

-- '2024-08'
select concat_ws('-', extract(YEAR from tran_date), extract(MONTH from tran_date))
from orders o;

-- distinct -> remove duplicate result
-- distinct one column
select distinct concat_ws('-', extract(YEAR from tran_date), extract(MONTH from tran_date))
from orders;

-- distinct two column
select distinct concat_ws('-', extract(YEAR from tran_date), extract(MONTH from tran_date)), total_amount
from orders;

select o.*, (select max(total_amount) from orders) from orders o;
select max(total_amount) from orders o;

-- Subquery (NOT SUGGEST) (slow performance)
-- First SQL to execute: select id from customers where name like '%LAU'
-- Sceondly, DBMS executes "select * from where customer_id in ..."
select * from orders
where customer_id = (select id from customers where name like '%LAU');