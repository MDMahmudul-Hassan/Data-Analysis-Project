/*
	Remove Duplicates Data From Table
*/

-- drop table if exists Cars

Create Table Cars
(
	ID	int,
	Model	varchar(50),
	Brand	varchar(40),
	Color	varchar(30),
	Make	int
);


insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);


insert into cars values (5, 'Model S', 'Tesla', 'Silver', 2018);
insert into cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);


Select * 
From Cars

-->> Method 01: Delete Using Unique Identifier.

Select model, brand, count(*) as "Total Brand"
From Cars 
Group By model, Brand
having count(*) > 1


Delete From Cars
Where id in 
(
	Select max(id)
	from Cars
	Group by model, brand
	having count(*) > 1
);



-->> Method 02: Using Self Join.

Select c2.id
from Cars c1
join cars c2
on c1.model = c2.model and c1.brand=c2.brand
where c1.id < c2.id

Delete from cars
where id in 
(	
	Select c2.id
	from Cars c1
	join cars c2
	on c1.model = c2.model and c1.brand=c2.brand
	where c1.id < c2.id
);



-->> Method 03: Using Window Function


Select * from (
	Select *
	, ROW_NUMBER() over	(partition by model, brand ORDER BY brand) as rn
	from Cars) x
Where x.rn> 1;


Delete from Cars
Where id in(
	Select ID from (
		Select *
		, ROW_NUMBER() over	(partition by model, brand ORDER BY brand) as rn
		from Cars) x
	Where x.rn> 1
);



-->> Method 04: Using MIN Function. This delete even multiple duplicate records.



Select * 
from Cars
Where id not in 
(
	Select min (id)
	from Cars
	group by model, Brand
);


delete from Cars
Where id not in 
(
	Select min (id)
	from Cars
	group by model, Brand
);




											<<The End>>