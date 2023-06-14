/*This project was completed while taking a SQL course through Udemy. I worked with an employment/HR data set to answer varies questions and created a Tableau dashboard to show the analysis results.*/

/*Provides a breakdown between the male and female employees working in the company each year, starting from 1990.*/
select *
from t_employees
limit 10;

select *
from t_dept_emp
limit 10;

select *
from t_departments
limit 10;

select e.gender, left(d.from_date, 4) as 'year', count(e.emp_no) as 'number_of_employees'
from t_employees as e
join t_dept_emp as d
on e.emp_no = d.emp_no
where left(d.from_date, 4) >= '1990'
group by year, e.gender;

/*Compare the number of male managers to the number of female managers from different departments for each year, starting from 1990.*/
select *
from t_dept_manager
limit 10;

select *
from t_departments
limit 10;

select m.emp_no, b.yr, d.dept_name, emp.gender, 
       case when b.yr>=left(c.from_date,4) and b.yr<=left(c.to_date,4) then 1
       else 0
       end as 'active'
from (select left(a.hire_date, 4) as 'yr'
      from t_employees as e
      group by yr
      having yr>='1990'
      order by yr) as b
cross join t_dept_manager as m
join t_departments as d
on c.dept_no = d.dept_no
join t_employees as emp
on emp.emp_no =m.emp_no
order by m.emp_no;

/*Compare the average salary of female versus male employees in the entire company until year 2002*/
select *
from t_salaries
limit 10;

select dp.dept_name, c.emp_no, c.gender, round(avg(c.salary),0) as 'avg_salary', c.yr
from (select a.emp_no, a.salary, b.gender, left(a.from_date, 4) as 'yr'
      from t_salaries as s
      join t_employees as e
      on a.emp_no = b.emp_no) as c
join t_dept_emp as d
on c.emp_no = d.emp_no
join t_departments as dp
on dp.dept_no = d.dept_no
where c.yr <= 2002
group by d.dept_no, c.gender, c.yr
order by d.dept_no, c.gender, c.yr;

/*Compare the highest salary of female managers and male managers by department*/
select e.gender, dp.dept_name, max(s.salary) as 'avg_salary'
from t_employees as e
join t_dept_manager as d
on e.emp_no = d.emp_no
join t_departments as dp
on d.dept_no = dp.dept_no
join t_salaries as s
on e.emp_no = dp.emp_no
group by e.gender,dp.dept_name;
