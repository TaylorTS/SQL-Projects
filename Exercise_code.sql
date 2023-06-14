/*find the avg salary of the male and female employees in each department*/
with cte as (
	select a.emp_no, b.dept_name
    from dept_emp as a
    join departments as b
    on a.dept_no = b.dept_no)

select cte.dept_name, c.gender, avg(c.salary) as 'average_salary'
from cte
join (select a.emp_no, a.salary, b.gender
		from salaries as a
		join employees as b
		on a.emp_no = b.emp_no) as c
on cte.emp_no = c.emp_no
group by c.gender, cte.dept_name
order by cte.dept_name, c.gender
limit 10;

/*find the lowest and highest dept_no*/
select min(dept_no) as 'smallest', max(dept_no) as 'largest'
from dept_emp;

/*all employees that have been hired in 2000*/
select emp_no, first_name, last_name, hire_date
from employees
where left(hire_date, 4) = '2000'
limit 10;

select a.emp_no, a.first_name, a.last_name, b.title
from employees as a
join titles as b
on a.emp_no = b.emp_no
where b.title like '%Engineer%'
limit 10;

select count(1) as 'number of engineers'
from employees as a
join titles as b
on a.emp_no = b.emp_no;

select b.title, count(1) as 'number'
from employees as a
join titles as b
on a.emp_no = b.emp_no
group by b.title;
