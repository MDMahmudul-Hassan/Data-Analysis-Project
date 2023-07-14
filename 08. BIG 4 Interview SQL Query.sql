/*
	Write a query to fetch the record of brand whose amount is increasing every year.

	# Solution for MS SQL Server.
*/



drop table brands;

create table brands
(
    Year    int,
    Brand   varchar(20),
    Amount  int
);

insert into brands
values 
	(2018,'Apple',45000),
	(2019, 'Apple',35000),
	(2020, 'Apple',75000),
	(2018, 'Samsung',15000),
	(2019, 'Samsung',20000),
	(2020, 'Samsung',25000),
	(2018, 'Nokia', 21000),
	(2019, 'Nokia', 17000),
	(2020, 'Nokia', 14000);

-->> Solution: 

Select * from brands


with cte as
	(select * 
	, (case when 
	amount < lead(amount,1,amount+1)
	Over(Partition by brand order by year)
	then 1
	else 0
	end ) as flag
	from brands)
select * 
from brands 
where brand not in (select brand from cte where flag = 0)



								--<<THE END>>--
