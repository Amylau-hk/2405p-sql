create database Bootcamp_exercise1;
use Bootcamp_exercise1;

create table regions (
	region_id int primary key,
    region_name varchar(25)
);

create table countries (
	country_id char(2) primary key,
    country_name varchar(40),
    region_id int,
    foreign key (region_id) references regions (region_id)
);

create table locations (
	location_id int primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2),
    foreign key (country_id) references countries (country_id)
);

create table departments (
	department_id int primary key,
    department_name varchar(30),
    manager_id int,
    location_id int,
    foreign key (location_id) references locations (location_id)
);

create table jobs (
	job_id varchar(10) primary key,
    job_title varchar(35),
    min_salary int,
    max_salary int
);

create table job_history (
	employee_id int,
    start_date date,
    end_date date,
    job_id varchar(10),
    department_id int,
    primary key(employee_id, start_date),
    foreign key (job_id) references jobs (job_id),
    foreign key (department_id) references departments (department_id)
);

create table employees (
	employee_id int primary key,
    first_name varchar(20),
    last_name varchar(25),
    email varchar(25),
    phone_number varchar(20),
    hire_date date,
    job_id varchar(10),
    salary int,
    commission_pct int,
    manager_id int,
    department_id int,
    foreign key (employee_id) references job_history(employee_id),
    foreign key (job_id) references jobs (job_id),
    foreign key (department_id) references departments (department_id)
);

insert into regions values (1, 'Europe');
insert into regions values (2, 'North America');
insert into regions values (3, 'Asia');
insert into regions values (4, 'South America');
insert into regions values (5, 'Africa');

insert into countries values ('DE', 'Germany', 1);
insert into countries values ('IT', 'Italy', 1);
insert into countries values ('JP', 'Japan', 3);
insert into countries values ('US', 'United State', 2);
insert into countries values ('TW', 'Taiwan', 3);
insert into countries values ('CN', 'China', 3);

insert into locations values (1000, '1297 Via COla di Rie', '989', 'Roma', null, 'IT');
insert into locations values (1100, '93091 Calle della Te', '10934', 'Venice', null, 'IT');
insert into locations values (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo JP', null);
insert into locations values (1400, '2014 Jabberwocky', '26192', 'Southlake', 'Texas', 'US');

insert into departments values (10, 'Administration', 200, 1100);
insert into departments values (20, 'Marketing', 201, 1200);
insert into departments values (30, 'Purchasing', 202, 1400);

insert into jobs values ('ST_CLERK', 'Clerk', 5000, 30000);
insert into jobs values ('MK_REP', 'Marketing Representative', 9000, 50000);
insert into jobs values ('IT_PROG', 'Programmer', 10000, 100000); 

insert into job_history values (102, '1993-01-13', '1998-07-24', 'IT_PROG', 20);
insert into job_history values (101, '1989-09-21', '1993-10-27', 'MK_REP', 10);
insert into job_history values (101, '1993-10-28', '1997-03-15', 'MK_REP', 30);
insert into job_history values (100, '1996-02-17', '1999-12-19', 'ST_CLERK', 30);
insert into job_history values (103, '1998-03-24', '1999-12-31', 'MK_REP', 20);

insert into employees values (100, 'Steven', 'King', 'SKING', '515-1234567', '1987-06-17', 'ST_CLERK', 24000, 0, 109, 10);
insert into employees values (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515-1234568', '1987-06-18', 'MK_REP', 17000, 0, 103, 20);
insert into employees values (102, 'Lex', 'De Haan', 'LDEHAAN', '515-1234569', '1987-06-19', 'IT_PROG', 17000, 0, 108, 30);
insert into employees values (103, 'Alexander', 'Hunold', 'AHUNOLD', '590-4234567', '1987-06-20', 'MK_REP', 9000, 0, 105, 20);

select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from locations l inner join countries c on l.country_id = c.country_id;

select e.first_name, e.last_name, e.department_id
from employees e;

select e.first_name, e.last_name, e.job_id, e.department_id
from employees e 
where e.department_id = 20;

select e_staff.employee_id, e_staff.last_name
from employees e_staff inner join employees e_manager on e_staff.employee_id = e_manager.manager_id;

select first_name, last_name, hire_date
from employees e
where hire_date > (
select hire_date 
from employees e
where first_name = 'Lex' and last_name = 'De Haan');

select department_name, count(1) as number_of_employees
from employees e inner join departments d on e.department_id = d.department_id
group by d.department_id;

select jh.employee_id, j.job_title, datediff(jh.end_date, jh.start_date) as number_of_day
from job_history jh inner join jobs j
where department_id = 30;

select department_name, manager_name, city, country_name
from 	

