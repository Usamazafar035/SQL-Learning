use employees;

----------------- Practice SQL - Final Query Questions ---------------------

--- Exercise 1
--- Find the average salary of the male and female employees in each department. 
--- Answer
SELECT 
    e.gender, AVG(s.salary) AS avg_salary, d.dept_name
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no , e.gender
ORDER BY d.dept_no , avg_salary DESC;

--------------------------

--- Exercise 2
--- Find the lowest department number encountered in the 'dept_emp' table. Then, find the highest
--- department number
--- Amswer

SELECT 
    MIN(dept_no)
FROM
    dept_emp AS lowest_dept_no;
SELECT 
    MAX(dept_no)
FROM
    dept_emp AS highest_dept_no;
    
    ---------------------------------
    
    # Exercise 3
# Obtain a table containing the following three fields for all individuals whose employee number is not
# greater than 10040:
# - employee number
# - the lowest department number among the departments where the employee has worked in (Hint: use
# a subquery to retrieve this value from the 'dept_emp' table)
# - assign '110022' as 'manager' to all individuals whose employee number is lower than or equal to 10020,
# and '110039' to those whose number is between 10021 and 10040 inclusive.
# Use a CASE statement to create the third field. 
--- Amswer

SELECT
    e.emp_no AS employee_number,
    (
        SELECT MIN(de.dept_no)
        FROM dept_emp de
        WHERE de.emp_no = e.emp_no
    ) AS lowest_dept_number,
    CASE
        WHEN e.emp_no <= 10020 THEN '110022'  -- Assign '110022' to employee numbers <= 10020
        WHEN e.emp_no BETWEEN 10021 AND 10040 THEN '110039'  -- Assign '110039' to employee numbers between 10021 and 10040
    END AS manager_assignment
FROM
    employees e
WHERE
    e.emp_no <= 10040
ORDER BY
    e.emp_no;

---------------------

# Exercise 4
# Retrieve a list of all employees that have been hired in 2000. 

SELECT 
    *, YEAR(hire_date) AS Calender_Year
FROM
    employees
WHERE
    YEAR(hire_date) = 2000;
    
---------------------------------
# Exercise 5
# Retrieve a list of all employees from the ‘titles’ table who are engineers.
# Repeat the exercise, this time retrieving a list of all employees from the ‘titles’ table who are senior
# engineers. 

SELECT 
    *
FROM
    titles
WHERE
    title LIKE ('%engineer%');

SELECT 
    *
FROM
    titles
WHERE
    title LIKE ('%senior engineer%');
    
----------------------------------

# Exercise 6
# Create a procedure that asks you to insert an employee number and that will obtain an output containing
# the same number, as well as the number and name of the last department the employee has worked in. 

DROP procedure IF EXISTS last_dept;

DELIMITER $$
CREATE PROCEDURE last_dept (in p_emp_no integer)
BEGIN
SELECT
    e.emp_no, d.dept_no, d.dept_name
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    e.emp_no = p_emp_no
        AND de.from_date = (SELECT
            MAX(from_date)
        FROM
            dept_emp
        WHERE
            emp_no = p_emp_no);
END$$
DELIMITER ;

call employees.last_dept(10010);

------------------------------

SELECT 
    SUM(A.no_of_contract) AS T_No_of_Contracts
FROM
    (SELECT 
        YEAR(from_date) AS cylender_year, COUNT(*) AS no_of_contract
    FROM
        salaries
    WHERE
        salary >= 100000
            AND DATEDIFF(to_date, from_date) > 365
    GROUP BY cylender_year
    ORDER BY cylender_year) AS A;

---- OR
SELECT 
    COUNT(*) AS No_of_contscts
FROM
    salaries
WHERE
    DATEDIFF(to_date, from_date);
    
    -------------------------------
    
# Exercise 8
# Create a trigger that checks if the hire date of an employee is higher than the current date. If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
# Extra challenge: You may try to declare a new variable called 'today' which stores today's data, and then use it in your trigger!
# After creating the trigger, execute the following code to see if it's working properly.

--- Answer

DROP TRIGGER IF EXISTS trig_hire_date;

DELIMITER $$
CREATE TRIGGER trig_hire_date
BEFORE INSERT ON employees
 
FOR EACH ROW
BEGIN 
    DECLARE today date;
    SELECT date_format(sysdate(), '%Y-%m-%d') INTO today;
 
	IF NEW.hire_date > today THEN
		SET NEW.hire_date = today;
	END IF;
END $$
 
DELIMITER ;

-------------------------
  
# Exercise 9
# Define a function that retrieves the largest contract salary value of an employee. Apply it to employee
# number 11356.
# In addition, what is the lowest contract salary value of the same employee? You may want to create a new
# function that to obtain the result. 

select emp_no,  Max(salary) as Largest_conatract
from salaries 
where emp_no = 11356
group by emp_no;

--------- By Function

Drop function if exists Largest_conatract
Delimiter $$
Create Function Largest_conatract (p_emp_no integer) returns decimal(10,2)
DETERMINISTIC
Begin
declare V_highest_salary decimal(10,2);

select max(salary) into V_highest_salary 
from employees e 
join salaries on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
return V_highest_salary; 
end $$
delimiter ;

SELECT Largest_conatract (11356);
 
Drop function if exists Lowest_conatract
Delimiter $$
Create Function Lowest_conatract (p_emp_no integer) returns decimal(10,2)
DETERMINISTIC
Begin
declare V_Lowest_salary decimal(10,2);

select max(salary) into V_Lowest_salary 
from employees e 
join salaries on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
return V_Lowest_salary; 
end $$
delimiter ;

SELECT Lowest_conatract (11356);
 
# Exercise 10
# Based on the previous example, you can now try to create a function that accepts also a second parameter which would be a character sequence. 
# Evaluate if its value is 'min' or 'max' and based on that retrieve either the lowest or the highest salary (using the same logic and code 
# from Exercise 9). If this value is a string value different from ‘min’ or ‘max’, then the output of the function should return 
# the difference between the highest and the lowest salary.

--- Answer

Drop function if exists f_salary;
Delimiter $$
Create Function f_salary (p_emp_no integer, p_min_or_max_salary varchar(255)) returns decimal(10,2)
DETERMINISTIC
Begin
declare v_salary_info decimal(10,2);

select 
case
when p_min_or_max_salary = 'max' then max(s.salary)
when p_min_or_max_salary = 'min' then min(salary)
else max(s.salary) - min(salary)
end as salary_info
into v_salary_info
from employees e 
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
return v_salary_info; 
end $$
delimiter ;

select employees.f_salary(11356, 'min') as min_salary;
select employees.f_salary(11356, 'max') as max_salary;
select employees.f_salary(11356, 'maxxx') as maxx_salary;

 
 















