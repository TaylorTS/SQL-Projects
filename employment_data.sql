/*find the avg salary of the male and female employees in each department*/
with cte as (
	select emp.emp_no, d.dept_name
    from dept_emp as emp
    join departments as d
    on emp.dept_no = d.dept_no)

select cte.dept_name, c.gender, avg(c.salary) as 'average_salary'
from cte
join (select a.emp_no, a.salary, b.gender
		from salaries as s
		join employees as e
		on s.emp_no = e.emp_no) as c
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

select e.emp_no, e.first_name, e.last_name, t.title
from employees as e
join titles as t
on e.emp_no = t.emp_no
where t.title like '%Engineer%'
limit 10;

select count(1) as 'number of engineers'
from employees as e
join titles as t
on e.emp_no = t.emp_no;

select t.title, count(1) as 'number'
from employees as e
join titles as t
on e.emp_no = t.emp_no
group by t.title;
