/* Write a query to print highest and lowest salary emp in each department */


use "Ankit_Bansal"


delete from employee;


create table employee 
(
emp_name varchar(10),
dep_id int,
salary int
);


insert into employee values 
 ('Siva',1,30000)
,('Ravi',2,40000)
,('Prasad',1,50000)
,('Sai',2,20000);


Select * From employee
order by dep_id


--Solution--


--Solution 01


with cte as(
Select dep_id
,MIN(salary) as min_sal
,MAX(salary) as max_sal
from employee
group by dep_id)

Select e.*, min_sal, max_sal
from employee e
inner join cte 
on e.dep_id = cte.dep_id;




--Solution 2


with cte as(
select *
,ROW_NUMBER() Over(partition by dep_id order by salary desc) as rank_desc
,ROW_NUMBER() Over(Partition by dep_id order by salary)		 as rank_asc
from employee)
Select dep_id
,min(case when rank_desc=1 then emp_name  end) as max_sal_emp
,min(case when rank_asc =1 then emp_name  end) as min_sal_emp
from cte
group by dep_id;




									--End--