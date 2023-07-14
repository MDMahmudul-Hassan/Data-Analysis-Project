/*
	Write SQL Query to find the average distance between the locations?

	-- INPUT:
	SRC       DEST    DISTANCE
	A	      B	      21
	B	      A	      28
	A	      B	      19
	C	      D	      15
	C	      D	      17
	D	      C	      16.5
	D	      C	      18

	-- EXPECTED OUTPUT:
	SRC       DEST    DISTANCE
	A	      B	      22.66
	C	      D	      16.62

# Solution for MS SQL Server. 



*/


drop table src_dest_dist;


create table src_dest_dist
(
    src         varchar(20),
    dest        varchar(20),
    distance    float
);

insert into src_dest_dist
values 
 ('A', 'B', 21),
 ('B', 'A', 28),
 ('A', 'B', 19),
 ('C', 'D', 15),
 ('C', 'D', 17),
 ('D', 'C', 16.5),
 ('D', 'C', 18);


select * from src_dest_dist;


-->> Solution : 

with cte as 
	(select src,dest
	,SUM(distance) as tot_dist, count(1) as no_of_routes
	,ROW_NUMBER() Over(order by src) as id
	from src_dest_dist
	group by src,dest)
select t1.src,t1.dest
, round(((t1.tot_dist + t2.tot_dist) / (t1.no_of_routes + t2.no_of_routes)),2) as avg_distance
from cte t1
join cte t2
	on
	 t1.src = t2.dest 
	and
	 t1.id < t2.id;



											--<<THE END>>--