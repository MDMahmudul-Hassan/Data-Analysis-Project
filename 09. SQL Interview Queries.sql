/*
	Write a SQL query to convert the given input into the expected output as shown below:


	-- INPUT:
	SRC         DEST        DISTANCE
	Bangalore	Hyderbad	400
	Hyderbad	Bangalore	400
	Mumbai	    Delhi	    400
	Delhi	    Mumbai	    400
	Chennai	    Pune	    400
	Pune        Chennai	    400

	-- EXPECTED OUTPUT:
	SRC         DEST        DISTANCE
	Bangalore	Hyderbad	400
	Mumbai	    Delhi	    400
	Chennai	    Pune	    400

# Solution for MS SQL Server.

*/


drop table src_dest_distance;

create table src_dest_distance
(
    source          varchar(20),
    destination     varchar(20),
    distance        int
);


insert into src_dest_distance 
values 
	 ('Bangalore', 'Hyderbad', 400),
	 ('Hyderbad', 'Bangalore', 400),
	 ('Mumbai', 'Delhi', 400),
	 ('Delhi', 'Mumbai', 400),
	 ('Chennai', 'Pune', 400),
	 ('Pune', 'Chennai', 400);
	 


Select * from src_dest_distance;

--Solution: 


with cte as
	(Select * 
	, ROW_NUMBER() Over(Order by distance) as id
	from src_dest_distance)
Select t1.source,t1.destination,t1.distance
from cte t1
Join cte t2
	on
	 t1.source = t2.destination
	and
	 t1.id < t2.id;


								--<<THE END>>--