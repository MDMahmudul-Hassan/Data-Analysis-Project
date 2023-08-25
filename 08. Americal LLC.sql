/* 
If Criteria1 and Criterai2 both are Y and a minimum of 2 team members, 
should have y then the output should be Y else N.
*/

Use "Ankit_Bansal";

create table Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);


insert into Ameriprise_LLC values 
 ('T1','T1_mbr1','Y','Y')
,('T1','T1_mbr2','Y','Y')
,('T1','T1_mbr3','Y','Y')
,('T1','T1_mbr4','Y','Y')
,('T1','T1_mbr5','Y','N')
,('T2','T2_mbr1','Y','Y')
,('T2','T2_mbr2','Y','N')
,('T2','T2_mbr3','N','Y')
,('T2','T2_mbr4','N','N')
,('T2','T2_mbr5','N','N')
,('T3','T3_mbr1','Y','Y')
,('T3','T3_mbr2','Y','Y')
,('T3','T3_mbr3','N','Y')
,('T3','T3_mbr4','N','Y')
,('T3','T3_mbr5','Y','N');


Select * From Ameriprise_LLC;



--Solution 01:


with qualified_team as(
select teamID, count(1) as no_of_eligible_members
from Ameriprise_LLC
Where Criteria1 = 'Y' and Criteria2 = 'Y'
Group by teamID
Having count(1) > =2)

Select al.*, qt.*
,case when	Criteria1 = 'Y'and 
			Criteria2 = 'Y'and 
			qt.no_of_eligible_members is not null 
			then 'Y' 
			else 'N'
			end as qualified_flag
From Ameriprise_LLC al
left join qualified_team qt on al.teamId = qt.teamID



--Solution 02: 


Select al.*,
case when	Criteria1='Y' and
			Criteria2='Y' and
			sum(case when criteria1='Y' and criteria2='Y'then 1 else 0 end) 
				over(partition by teamid)>=2 then 'Y'
			else 'N'
			end as qualified_flag			
from Ameriprise_LLC al



									--End--
