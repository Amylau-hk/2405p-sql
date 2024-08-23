use db_bc2405p;

-- create table -> datetime, integer, numeric(x, x), varchar(x)
-- 2 tables (one to many)
-- where, group by, having, order by 
create table expense_list(
	expense_date datetime,
    expense_voucher integer,
    expense_amount numeric(10,2),
    expense_items varchar(1000)
);

insert into expense_list values ('2024-08-01 09:24:23', 20240801, 2500.7, 'Transportation');
select * from expense_list;
insert into expense_list values ('2024-08-02 10:33:40', 20240802, 45.7, 'Stationery');
insert into expense_list values ('2024-08-02 17:30:40', 20240803, 100.9, 'Transportation');
insert into expense_list values ('2024-08-09 12:22:30', 20240804, 7.7, 'Stationery');
insert into expense_list values ('2024-08-15 09:43:40', 20240805, 1900, 'Entertainment');
insert into expense_list values ('2024-08-30 18:23:40', 20240806, 100000, 'Rent');
select * from expense_list;

select exp.expense_items, sum(exp.expense_amount) from expense_list exp 
where exp.expense_voucher in (20240802, 20240803, 20240804, 20240806) 
group by exp.expense_items
having sum(exp.expense_amount) > 100
order by sum(exp.expense_amount) desc;

