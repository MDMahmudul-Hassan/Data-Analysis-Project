/*
 STATEMENT: Ungroup the given input data. Display the result as per expected output.

 -->> EXPECTED OUTPUT:
ID    ITEM_NAME
1	  Water Bottle
1	  Water Bottle
2	  Tent
3	  Apple
3	  Apple
3	  Apple
3	  Apple

# Solution for MS SQL Server.

*/

drop table travel_items;

create table travel_items
	(
	id              int,
	item_name       varchar(50),
	total_count     int
	);

insert into travel_items 
values
	(1, 'Water Bottle', 2),
	(2, 'Tent', 1),
	(3, 'Apple', 4);


-->> Solution: 

Select * from travel_items


with cte as
	(
	 select id,item_name, total_count, 1 as level
	 from travel_items
	 Union All
	 Select cte.id, cte.item_name, cte.total_count -1, level+1 as level
	 from cte 
	 join travel_items t 
	 on t.item_name = cte.item_name
	 and t.id = cte.id
	 where cte.total_count > 1
	 )
Select id, item_name
from cte 
order by 1;


								--<<THE END>>--
