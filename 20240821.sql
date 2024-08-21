-- comment
-- database -> table (row x column)
create database db_bc2405p;

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
