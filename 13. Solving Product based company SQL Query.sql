/*
	A table 'billing' consists of following Columns
	customer_id, customer name, billing_id, billing_creation_date, billed_amount
	Display average billing amount for each customer between 2019 to 2021 , assume
	0$ billing amount if nothing is billed for a particular year of that customer


	*Expected output*
	Customer_id		customer_name	avg_billing_amount
	1				A				87.5$
	2				B				150$				
	3				C				183.33$

*/
	



drop table billing;

create table billing
(
      customer_id               int
    , customer_name             varchar(1)
    , billing_id                varchar(5)
    , billing_creation_date     date
    , billed_amount             int
);

INSERT INTO billing 
VALUES 
	(1, 'A', 'id1', CONVERT(date,'10-10-2020',105), 100),
	(1, 'A', 'id2', CONVERT(date,'11-11-2020',105), 150),
	(1, 'A', 'id3', CONVERT(date,'12-11-2021',105), 100),
	(2, 'B', 'id4', CONVERT(date,'10-11-2019',105), 150),
	(2, 'B', 'id5', CONVERT(date,'11-11-2020',105), 200),
	(2, 'B', 'id6', CONVERT(date,'12-11-2021',105), 250),
	(3, 'C', 'id7', CONVERT(date,'01-01-2018',105), 100),
	(3, 'C', 'id8', CONVERT(date,'05-01-2019',105), 250),
	(3, 'C', 'id9', CONVERT(date,'06-01-2021',105), 300);


select * from billing;

with cte as
    (select customer_id,customer_name
    , sum(case when to_char(billing_creation_date,'yyyy') = '2019' then billed_amount else 0 end)::decimal as bill_2019_sum
    , sum(case when to_char(billing_creation_date,'yyyy') = '2020' then billed_amount else 0 end)::decimal as bill_2020_sum
    , sum(case when to_char(billing_creation_date,'yyyy') = '2021' then billed_amount else 0 end)::decimal as bill_2021_sum
    , count(case when to_char(billing_creation_date,'yyyy') = '2019' then billed_amount else null end) as bill_2019_cnt
    , count(case when to_char(billing_creation_date,'yyyy') = '2020' then billed_amount else null end) as bill_2020_cnt
    , count(case when to_char(billing_creation_date,'yyyy') = '2021' then billed_amount else null end) as bill_2021_cnt
    from billing
    group by customer_id,customer_name)
select customer_id, customer_name
, round((bill_2019_sum + bill_2020_sum + bill_2021_sum)/
    (  case when bill_2019_cnt = 0 then 1 else bill_2019_cnt end
     + case when bill_2020_cnt = 0 then 1 else bill_2020_cnt end
     + case when bill_2021_cnt = 0 then 1 else bill_2021_cnt end
    ),2)
from cte
order by 1;



							--<<The End>>--