
--- Use Database

use employees;

--- Select Statemnet

SELECT 
    *
FROM
    employees;
    
--- Order By

SELECT 
    *
FROM
    employees
ORDER BY hire_date;

--- Group By
 
SELECT 
    first_name
FROM
    employees
GROUP BY first_name; 

---

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;

----------------------

SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary >= 80000
GROUP BY salary
ORDER BY salary;

--- Group By with Having Clause

SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name DESC;

----------------------

SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

--- With Condition Where and Having

SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING name_count < 200
ORDER BY first_name DESC;

----------------------

SELECT 
    emp_no, COUNT(emp_no) AS emp_count
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING emp_count > 1
ORDER BY emp_no;

--- Use of Limit

SELECT 
    *
FROM
    departments
LIMIT 100;

--- Insert Values in Table

insert into employees
(
	emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    hire_date
)
values
( 	999901,
	'1986-04-21',
    'john',
    'smith',
    'M',
    '2011-01-01'
);

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

insert into employees
(	emp_no,
	birth_date,
	first_name,
	last_name,
	gender,
	hire_date
    )
values
(	999903,
	'1998-12-01',
    'Sami',
    'perth',
    'M',
    '2012-01-01'
);

insert into dept_emp
(		emp_no,
	dept_no,
    from_date,
    to_date
)
values
(
999903,
'd005',
'1997-10-01',
'9999-01-01'
);

--- Create Table and Insert Values from Other table

CREATE TABLE department_dup (
    dept_no VARCHAR(255),
    dept_name VARCHAR(255),
    PRIMARY KEY (dept_no)
);

insert into department_dup
( 	dept_no,
	dept_name
)
select * from departments;

SELECT 
    *
FROM
    department_dup;
    
---  Update statement

UPDATE employees 
SET 
    first_name = 'stella',
    last_name = 'parkinson',
    birth_date = '1990-02-28',
    gender = 'f'
WHERE
    emp_no = 999903;
    
select * from employees order by emp_no desc limit 1;
select * from department_dup;
insert into department_dup
( 	dept_no,
	dept_name
)
select * from departments;
select * from department_dup;

commit;
UPDATE department_dup 
SET 
    dept_name = 'Data';

SELECT 
    *
FROM
    department_dup;

rollback;

--- Delete Statement

DELETE FROM department_dup 
WHERE
    dept_name = 'Data';

insert into department_dup
( 	dept_no,
	dept_name
)
select * from departments;
commit;
update department_dup
set dept_name= 'Data';
rollback;
select * from department_dup;
update department_dup set dept_name = 'Data Analysis' where dept_no = 'd008';
select * from department_dup;
select * from departments;
delete from department_dup where dept_no = 'd009';

--- Aggregate Functions

select count(distinct dept_no) as dept_emp from departments;
select sum(salary) as Total_money from salaries where from_date > '1997-01-01';
select max(emp_no) from employees;
select min(emp_no) from employees;
select avg(salary) as avg_salary from salaries where from_date ='1997-01-01';
select round(avg(salary),2) as avg_salary from salaries where from_date ='1997-01-01';

select * from department_dup;
alter table department_dup change column dept_name dept_name varchar(255) NULL;
insert into department_dup(dept_no) values('do10'), ('d011');
alter table department_dup add column dept_manager varchar(255) Null after dept_name;
select * from department_dup order by  dept_no;

--- Use of IFNULL  and COALESCE 

commit;
select dept_no,
IFNULL(dept_name , 'Departmnet name not provided') as dept_name from  department_dup;
select dept_no,
coalesce(dept_name , 'Departmnet name not provided') as dept_name from  department_dup;

select 	dept_no,
        ifnull(dept_name , 'Department name is not provide'),
		coalesce(dept_manager, dept_name, 'N/A') as dept_manager
		from department_dup order by dept_no asc;
SELECT

    dept_no,

    dept_name,

    COALESCE(dept_no, dept_name) AS dept_info

FROM

    department_dup

ORDER BY dept_no ASC;

select dept_no,
ifnull(dept_name, 'N/A') as dept_name
from department_dup
order by dept_no Asc;

select * from department_dup;

--- Drop Statemant

Alter table department_dup
drop column dept_manager;

Alter table department_dup
DROP primary key;

--- change Column 

Alter table department_dup
change column dept_no dept_no char(4) null,
change column dept_name dept_name varchar(40) null;
insert into department_dup(dept_name) values ('Public Relations');
select * from department_dup;


DROP TABLE IF EXISTS dept_manager_dup;

-------------------

CREATE TABLE dept_manager_dup (
emp_no int(11) NOT NULL,
dept_no char(4) NULL,
from_date date NOT NULL,
to_date date NULL
);
INSERT INTO dept_manager_dup
select * from dept_manager;
INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES              (999904, '2017-01-01'),
					(999905, '2017-01-01'),
					(999906, '2017-01-01'),
					(999907, '2017-01-01');
DELETE FROM dept_manager_dup
WHERE
dept_no = 'd001';

create table manager_duplicta 
(
emp_no int(4) not null,
emp_name varchar(255),
emp_number int(12),
emp_salary int(50)
);
insert into  manager_duplicta( emp_no, emp_name, emp_number,emp_salary)
values(0001, 'sana', 123123, 120000);

-------------------

select* from  manager_duplicta;
drop table manager_duplicta;

select * from dept_manager_dup
order by dept_no;

select * from department_dup
order by dept_no;

--- use of joins

select m.dept_no, m.emp_no, d.dept_name
from  dept_manager_dup m
inner join
department_dup d
on m.dept_no = d.dept_no
order by dept_no;

------------------

select e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
from 
employees e
join dept_manager d on e.emp_no = d.emp_no
order by e.emp_no desc;

-------------------------

select m.dept_no, m.emp_no, d.dept_name
from  dept_manager_dup m
left join department_dup d on d.dept_no = m.emp_no
order by d.dept_no;

----------------------

select * from dept_manager_dup;

-----------------------

select e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
from employees e
left join dept_manager m on e.emp_no = m.emp_no
where last_name = 'Markovitch'
order by dept_no desc;

---------------------------

select m.dept_no, m.emp_no, d.dept_name
from  dept_manager_dup m
right join department_dup d on d.dept_no = m.emp_no
order by d.dept_no;


select e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
from employees e, dept_manager d
where e.emp_no = d.emp_no
order by e.emp_no;



set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

select e.first_name ,e.last_name, t.title, e.hire_date 
from  employees e 
join titles as t on e.emp_no = t.emp_no
where first_name = 'Margareta'and last_name = 'Markovitch';

--- Cross Join

select dm.*, d.* 
from dept_manager dm 
cross join departments d
order by dm.emp_no , d.dept_no;

select dm.*, d.* 
from dept_manager dm, departments d
order by dm.emp_no , d.dept_no;

select dm.*, d.* 
from dept_manager dm 
join departments d
order by dm.emp_no , d.dept_no;

select e.*, d.* 
from dept_manager dm 
cross join departments d
join employees e on dm.emp_no = e.emp_no
order by dm.emp_no , d.dept_no;

SELECT 
    d.*, dm.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

select e.*, d.*
from employees e 
cross join departments d
where e.emp_no <= 10010
order by e.emp_no , d.dept_name;

SELECT 
e.gender , AVG(salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;
 
 select e.first_name, e.last_name, t.title, d.dept_name, e.hire_date, dm.from_date
 
 from dept_manager dm
 join employees e on e.emp_no = dm.emp_no
 join titles t on t.emp_no = dm.emp_no
 join departments d on dm.dept_no = d.dept_no
 where t.title = 'Manager'
 order by e.emp_no;
 
 ---------------------------------
 
 select e.gender , count(dm.emp_no) as gender_count
 from employees e
 join dept_manager dm
 on e.emp_no = dm.emp_no
 group by e.gender;
 
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
---------------------------------            
           
SELECT 
    e.*
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm
        WHERE
            dm.from_date > '1990-01-01'
                AND dm.from_date > '1995-01-01');
                
----------------------------------

SELECT 
    e.*
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            t.emp_no
        FROM
            titles t
        WHERE
			t.title = 'Assistant Engineer');
            
----------------------------
 
DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);

INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;
    
---------------------------
    
    select * from emp_manager;
    
SELECT Distinct
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
   CREATE OR REPLACE VIEW V_dept_name_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
    -----------------------------
    
    CREATE OR REPLACE VIEW v_avg_salary AS
    SELECT 
        AVG(s.salary) AS avg_salary
    FROM
        salaries s
            INNER JOIN
        dept_manager dm ON s.emp_no = dm.emp_no;
    
   SELECT 
    *
FROM
    v_avg_salary;
    
--- Creating procedures


    drop procedure if exists select_employees ;
    
DELIMITER $$
create procedure select_employees()
begin
      select *from employees
      limit 1000;
end $$
DELIMITER ;

call employees.select_employees();

call select_employees();
    
    
DELIMITER $$
create procedure avg_salary()
begin 
select avg(salary) 
from salaries;
end$$
DELIMITER ;

drop procedure select_employees;

-------------------

drop procedure if exists  P_salary;
delimiter $$ 
create procedure P_salary(in p_emp_no integer)
begin
select e.first_name, e.last_name, s.from_date , s.to_date
from employees e 
inner join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end$$
delimiter ;

-----------------------------

drop procedure if exists  emp_average_salary;
delimiter $$ 
create procedure emp_average_salary(in p_emp_no integer)
begin
select e.first_name, e.last_name, avg(salary)
from employees e 
inner join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end$$
delimiter ;

call emp_average_salary(11200);

------------------------

drop procedure if exists  p_avg_salary_out;
delimiter $$
create procedure p_avg_salary_out(in p_emo_no integer, out p_avg_salary decimal(10,2))
begin
select avg(salary) into p_avg_salary
from employees e
inner join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emo_no;
end$$
delimiter ;

----------------------

set @v_avg_salary = 0;
call p_avg_salary_out (11300 ,  @v_avg_salary);
select @v_avg_salary;

call emp_average_salary(11300);
set @v_emp_no = 0;
call p_avg_salary_out(11300, @v_emp_no);
select @v_emp_no;

-------------------------

drop procedure if exists emp_info;
delimiter $$
create procedure emp_info(in p_emp_first_name VARCHAR(255) , in p_emp_last_name varchar(255) , out p_emp_info decimal(10,2))
begin
select avg(salary) into p_emp_info
from employees e
inner join salaries s on e.emp_no = s.emp_no;
end$$ 
delimiter ;

set @v_emp_no = 0;
call emp_info('Aruna', 'Journel', @v_emp_no);
select @v_emp_no;

-------------------------------

drop function if exists f_max_salary;
delimiter $$
create function f_max_salary(p_emp_first_name Varchar(90), p_emp_last_name Varchar(90)) returns decimal(10,2)
DETERMINISTIC NO SQL READS SQL DATA
begin 
declare v_max_from_date date;
declare v_max_salary decimal(10,2);

select 
max(from_date) into v_max_from_date from salaries s join employees e on e.emp_no = s.emp_no
where
e.first_name = p_emp_first_name and  e.last_name = p_emp_last_name;
select 
s.salary into v_max_salary from employees e 
join salaries s on e.emp_no =  s.emp_no
where e.first_name = p_emp_first_name and  e.last_name = p_emp_last_name
and s.from_date = v_max_from_date;

return v_max_salary;
end$$
delimiter ;
select f_max_salary('Aruna', 'Journel');

--- session_variable

set @s_var1 = 3;

------- global_ variable

set global max_connections =  1;
set @@global.max_connections = 1;

set global sql_mode = 'okojertyuio';
set session sql_mode = 'okojertyuio';

--- Triggers 

delimiter $$ 
Create trigger insert_salary
before insert on salaries
for each row
begin 



end$$
Delimiter ;

# ----  Creating index

create index i_hire_date on empployees(hire_date);

select * from employees where first_name = 'Georgi' and last_name = 'facello';

create index I_composite on employees(first_name, last_name); 

show index from employees from employees;

select * from salaries where salary > 89000;

create index I_salary on salaries(salary);

--- Case Statements

select 
emp_no,
first_name,
last_name,
case gender
when gender = 'M' then 'Male'
else 'Female'
end as gender
from employees;

select dm.emp_no, e.first_name , e.last_name, max(salary) - min(salary) as salary_diff,
case
when max(salary) - min(salary) > 30000 then 'this salary raise was higher than $30,000'
else 'this salary raise was not higher than $30,000'
end as salary_raise

from dept_manager dm
join employees e
on dm.emp_no = e.emp_no
join salaries s on
s.emp_no = e.emp_no
group by s.emp_no;

--- Window Functions

--- Row_Number

select 
emp_no , salary,
row_number() over(partition by emp_no order by salary desc) as row_no 
from 
salaries;

select 
emp_no , salary,
row_number() over(order by salary desc) as row_no 
from 
salaries;

select dm.emp_no, e.first_name , e.last_name,
row_number() over(order by dm.emp_no asc) as row_no
from dept_manager dm
join employees e on e.emp_no = dm.emp_no;

select *,
row_number() over w as row_no
from employees
window w as (partition by first_name order by last_name);

select * ,
row_number() over w
from employees
window w as (partition by  first_name order by emp_no);

select a.emp_no , a.salary as max_salary from(
select emp_no , salary, row_number() over w as row_no
from salaries 
window w as  (partition by emp_no order by salary desc)) a
where a.row_no = 1;

select a.emp_no , a.salary as min_salary from(
select emp_no , salary, row_number() over w as row_no
from salaries 
window w as  (partition by emp_no order by salary)) a
where a.row_no = 1;

--- Rank

select emp_no , salary, rank() over r as Rank_no
from salaries
where emp_no = 11839
window r as  (partition by emp_no order by salary desc);

--- Dense_Rank

select emp_no , salary, dense_rank() over r as Rank_no
from salaries
where emp_no = 11839
window r as  (partition by emp_no order by salary desc);


select
d.dept_no,
d.dept_name,
dm.emp_no,
rank()  over w as dept_salary_ranking,
s.salary,
s.from_date as salary_from_date,
s.to_date as salary_to_date,
dm.from_date as dept_manager_from_date,
dm.to_date as dept_manager_to_date
from 
dept_manager dm 
join salaries s on dm.emp_no= s.emp_no 
and s.from_date between dm.from_date and dm.to_date
and s.to_date between dm.from_date and dm.to_date
join departments d on dm.dept_no =  d.dept_no
window w as (partition by dm.dept_no order by s.salary);

--- lag() and lead() functions

select 
emp_no,
salary,
lag(salary) over w as previos_salary,
lead(salary) over w as next_salary,
salary - lag(salary) over w  as diff_cur_pre_salary,
lead(salary) over w - salary as diff_cur_next_salary
from salaries
where emp_no = 10001
window w as (order by salary);

--- CTEs

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,
COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;

-------------

WITH cte1 AS (

SELECT AVG(salary) AS avg_salary FROM salaries

),

cte2 AS (
SELECT s.emp_no, MAX(s.salary) AS max_salary
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no
)
SELECT
SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END) AS highest_salaries_below_avg
FROM employees e
JOIN cte2 c2 ON c2.emp_no = e.emp_no
JOIN cte1 c1;



-----------------------------

select sysdate();

SELECT 
    *
FROM
    salaries
WHERE
    to_date > SYSDATE();
    
    select emp_no , salary, max(from_date) , to_date
    from salaries 
    group by emp_no;
    
    ------------------
    
    select s1.emp_no , s.salary, s.from_date, s.to_date
    from salaries s 
    join 
    (select emp_no , salary, max(from_date) as from_date , to_date
    from salaries 
    group by emp_no) s1 on s.emp_no =s1.emp_no
    where s.to_date > SYSDATE()
	and s.from_date = s1.from_date;
    
    select avg(salary) from salaries;
    
    with cte as (select avg(salary) as avg_salary from salaries)
    select 
    sum(case
    when s.salary > avg_salary then 1
    else 0
    end) as no_of_salary_above_avg,
    count(s.salary) as total_no_of_salary
    from salaries s
    join employees e on e.emp_no = s.emp_no and e.gender = 'F'
    cross join cte;
    
    
  ---   Temporary Tables
  
  drop table f_highest_salary;
  create temporary table f_highest_salary
  select e.emp_no, Max(salary) as f_highest_salary
  from employees e 
  join salaries s on e.emp_no = s.emp_no and e.gender ='f'
  group by e.emp_no 
  order by f_highest_salary desc;
    
    select * from f_highest_salary;
    
    drop table male_max_salaries ;
    create temporary table male_max_salary 
    select e.emp_no, max(salary) as m_highest_salary
    from employees e
    join salaries s on e.emp_no = s.emp_no and e.gender = 'M'
    group by e.emp_no
	order by m_highest_salary desc;
    
    select * from male_max_salary;
    
    
    create temporary table dates
    SELECT 
    Now() as current_date_and_time,
    Date_sub(now(), interval 1 month) as one_month_earlier,
	Date_sub(now(), interval -1 year) as one_year_later;
    
SELECT 
    *
FROM
    dates;
    
    with cte as (
    SELECT 
    Now() as current_date_and_time,
    Date_sub(now(), interval 1 month) as one_month_earlier,
	Date_sub(now(), interval -1 year) as one_year_later
    )
    select * from dates union all select * from cte;
    
    --- some Practice Questions
    
use employees_mod;

select year(hire_date) as calender_year , gender, count(emp_no) as no_of_employees
from t_employees 
 group by calender_year, gender
 having calender_year > 1990
 order by calender_year;
 
 SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
        WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1
        ELSE 0
    END AS active
FROM
    (SELECT 
        YEAR(hire_date) AS calendar_year
    FROM
        t_employees
    GROUP BY calendar_year) e
        CROSS JOIN
    t_dept_manager dm
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        JOIN 
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no, calendar_year;

select e.gender , round(avg(s.salary),2) as avg_salary , year(s.from_date) as to_year, d.dept_name
from t_salaries s
join t_employees e on e.emp_no = s.emp_no
join t_dept_emp dm on s.emp_no = dm.emp_no
join t_departments d on dm.dept_no = d.dept_no
group by d.dept_no,e.gender, to_year
having to_year <=2002
order by d.dept_no;

SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no , e.gender , calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;

drop procedure if exists filter_salary;
Delimiter $$
create procedure filter_salary (in p_min_salary float, in p_max_salary float)
begin
select e.gender, d.dept_name, round(avg(s.salary),2) as avg_salary
from t_salaries s
join t_employees e on s.emp_no = e.emp_no
join t_dept_emp de on e.emp_no = de.emp_no
join t_departments d on de.dept_no = d.dept_no
where s.salary between p_min_salary and p_max_salary
group by d.dept_no, e.gender;
end$$
delimiter ;
call filter_salary(50000, 90000);



DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT 
    e.gender, d.dept_name, AVG(s.salary) as avg_salary
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END$$

DELIMITER ;

CALL filter_salary(50000, 90000);
