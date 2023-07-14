/*
Write an SQL query to show the second most recent activity of each user.
If the user only has one activity, retum that one.
A user can't perform more than one activity at the same time. Return the result table in any order.


UserActivity table:

Username	Activity	StartDate		EndDate
Amy			Travel		2020-02-12		2020-02-20
Amy			Dancing		2020-02-21		2020-02-23
Amy			Travel		2020-02-24		2020-02-28	
Joe			Travel		2020-02-11		2020-02-18

This table does not contain primary key.
This table Fontains information about the activity performed by each user in a period of time.
A person with username performed an activity from startDate to endDate.
 

Result table:

Username	Activity	StartDate		EndDate
Amy			Dancing		2020-02-21		2020-02-23
Joe			Travel		2020-02-11		2020-02-18

*/



drop table UserActivity;

create table UserActivity
(
	Username varchar(30),
	Activity varchar(30),
	StartDate datetime,
	EndDate	datetime
);


Insert into UserActivity
Values
	('Amy','Travel','2020-02-12','2020-02-20'),
	('Amy','Dancing','2020-02-21','2020-02-23'),
	('Amy','Travel','2020-02-24','2020-02-28'),
	('Joe','Travel','2020-02-11','2020-02-18');



-->>Solution:


Select * from UserActivity;


with cte as
(select * 
,ROW_NUMBER() over(partition by username order by startdate) as rn
, COUNT(*) over(partition by username order by startdate
				range between unbounded preceding and unbounded following) as cnt
from UserActivity)
select username, activity , startdate, EndDate
from cte
where 
	rn = case when 
		cnt = 1 
		then 1 
		else cnt-1 
		end;




														--<<THE END>>--
