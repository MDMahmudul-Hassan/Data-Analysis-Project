/*
	Practicing Complex SQL Queries
*/

-->> Queries 01: Write a SQL Query to fetch all the duplicate records in a table.

--drop table users;

create table users
(
	user_id int primary key,
	user_name varchar(30) not null,
	email varchar(50)
);

insert into users 
	values
	(1, 'Sumit', 'sumit@gmail.com'),
	(2, 'Reshma', 'reshma@gmail.com'),
	(3, 'Farhana', 'farhana@gmail.com'),
	(4, 'Robin', 'robin@gmail.com'),
	(5, 'Robin', 'robin@gmail.com');

select * from users;


SELECT user_id, user_name, email
FROM (
    SELECT *, 
	ROW_NUMBER() OVER(PARTITION BY user_name ORDER BY user_id) AS rn
    FROM users
	) AS x
WHERE x.rn > 1
ORDER BY user_id;



-->> Queries 02: Write a SQL query to fetch the second last record from employee table.



Select User_id, User_name, email
From(
	Select * 
	, ROW_NUMBER() Over(Order by User_id desc) as rn
	from users
	) As x
Where x.rn = 2;




-->> Queries 03: Write a SQL query to display only the details of employees who either earn the highest salary or the lowest salary in each department from the employee table.



--drop table employee;

create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

select * from employee;


Select x.*
From employee e
join	(
		Select *
		,max(Salary) over(partition by dept_name) as max_salary
		,min(salary) over(partition by dept_name) as min_salary
		from employee
		) x
ON 
		e.emp_id = x.emp_id
and
		(e.salary = x.max_salary or e.salary = x.min_salary)
Order by x.dept_name, x.salary;



-->> Queries 04: From the doctors table, fetch the details of doctors who work in the same hospital but in different specialty.



--drop table doctors;

create table doctors
(
id int primary key,
name varchar(50) not null,
speciality varchar(100),
hospital varchar(50),
city varchar(50),
consultation_fee int
);

insert into doctors values
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

select * from doctors;


Select d1.*
From doctors d1
Join doctors d2
on	d1.id <> d2.id 
and	d1.hospital = d2.hospital
and	d1.speciality <> d2.speciality;




-->> Queries 05: From the login_details table, fetch the users who logged in consecutively 3 or more times.



--drop table login_details;

create table login_details
(
	login_id int primary key,
	user_name varchar(50) not null,
	login_date date
);


INSERT INTO login_details 
VALUES 
	(101, 'Michael', GETDATE()),
	(102, 'James', GETDATE()),
	(103, 'Stewart', DATEADD(DAY, 1, GETDATE())),
	(104, 'Stewart', DATEADD(DAY, 1, GETDATE())),
	(105, 'Stewart', DATEADD(DAY, 1, GETDATE())),
	(106, 'Michael', DATEADD(DAY, 2, GETDATE())),
	(107, 'Michael', DATEADD(DAY, 2, GETDATE())),
	(108, 'Stewart', DATEADD(DAY, 3, GETDATE())),
	(109, 'Stewart', DATEADD(DAY, 3, GETDATE())),
	(110, 'James', DATEADD(DAY, 4, GETDATE())),
	(111, 'James', DATEADD(DAY, 4, GETDATE())),
	(112, 'James', DATEADD(DAY, 5, GETDATE())),
	(113, 'James', DATEADD(DAY, 6, GETDATE()));


select * from login_details;



Select distinct user_name
From(
	Select *, 
	case when user_name = lead(user_name) over (order by login_id)
		 and  user_name = lead(user_name, 2) over (order by login_id)
		 then user_name
		 else null
	end repeated_users
	from login_details
	) x
Where x.repeated_users is not null;




-->> Queries 06: From the students table, write a SQL query to interchange the adjacent student names.



--drop table students;


create table students
(
	id int primary key,
	student_name varchar(50) not null
);

insert into students values
(1, 'James'),
(2, 'Michael'),
(3, 'George'),
(4, 'Stewart'),
(5, 'Robin');

select * from students;



Select id, student_name
,case when id%2 <> 0 then lead (student_name, 1,student_name) over (order by id)
when id%2 =0 then LAG(Student_name) Over(order by id) end as new_student_name
from students;



-->> Queries 07: From the weather table, fetch all the records when London had extremely cold temperature for 3 consecutive days or more.



--drop table weather;


create table weather
(
	id int,
	city varchar(50),
	temperature int,
	day date
);

INSERT INTO weather 
VALUES
	(1, 'London', -1, CONVERT(DATE, '2021-01-01')),
	(2, 'London', -2, CONVERT(DATE, '2021-01-02')),
	(3, 'London', 4, CONVERT(DATE, '2021-01-03')),
	(4, 'London', 1, CONVERT(DATE, '2021-01-04')),
	(5, 'London', -2, CONVERT(DATE, '2021-01-05')),
	(6, 'London', -5, CONVERT(DATE, '2021-01-06')),
	(7, 'London', -7, CONVERT(DATE, '2021-01-07')),
	(8, 'London', 5, CONVERT(DATE, '2021-01-08'));


select * from weather;


select id, city, temperature, day
from (
    select *,
        case when temperature < 0
              and lead(temperature) over(order by day) < 0
              and lead(temperature,2) over(order by day) < 0
        then 'Y'
        when temperature < 0
              and lead(temperature) over(order by day) < 0
              and lag(temperature) over(order by day) < 0
        then 'Y'
        when temperature < 0
              and lag(temperature) over(order by day) < 0
              and lag(temperature,2) over(order by day) < 0
        then 'Y'
        end as flag
    from weather) x
where x.flag = 'Y';



-->> Queries 08: Find the top 2 accounts with the maximum number of unique patients on a monthly basis.



--drop table patient_logs;

create table patient_logs
(
  account_id int,
  date date,
  patient_id int
);

INSERT INTO patient_logs
VALUES
	(1, CONVERT(DATE, '02-01-2020', 105), 100),
	(1, CONVERT(DATE, '27-01-2020', 105), 200),
	(2, CONVERT(DATE, '01-01-2020', 105), 300),
	(2, CONVERT(DATE, '21-01-2020', 105), 400),
	(2, CONVERT(DATE, '21-01-2020', 105), 300),
	(2, CONVERT(DATE, '01-01-2020', 105), 500),
	(3, CONVERT(DATE, '20-01-2020', 105), 400),
	(1, CONVERT(DATE, '04-03-2020', 105), 500),
	(3, CONVERT(DATE, '20-01-2020', 105), 450);


select * from patient_logs;


 Select month, account_id, no_of_patients
 from (
		select *,
		rank() over (partition by month order by no_of_patients desc, account_id) as rnk
		from (
				select month, account_id, count(1) as no_of_patients
				from (SELECT DISTINCT DATENAME(month, date) AS month, account_id, patient_id
					  FROM patient_logs
					 ) pl
				group by month, account_id) x
		) temp 
where temp.rnk in (1,2);


															--<< THE END >>--