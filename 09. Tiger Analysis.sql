/* 
There are adult and child in the table and they are going for a fair and they have a ride on some jhola, 
so one adult can go with one child and in last one adult will be alone. 
*/



Use "Ankit_Bansal"


create table family 
(person varchar(5)
,type varchar(10)
,age int);


insert into family values 
 ('A1','Adult',54)
,('A2','Adult',53)
,('A3','Adult',52)
,('A4','Adult',58)
,('A5','Adult',54)
,('C1','Child',20)
,('C2','Child',19)
,('C3','Child',22)
,('C4','Child',15);


Select * from family;


--Solution: 


with cte_adult as
(select *, ROW_NUMBER() Over(order by person) as rn 
	from family
	where type = 'Adult')

, cte_child as
(Select *, ROW_NUMBER() over(order by person) as rn 
	from family
	where type = 'Child')

Select a.person,c.person
from cte_adult a
left join cte_child c 
on a.rn = c.rn;  



							--End--