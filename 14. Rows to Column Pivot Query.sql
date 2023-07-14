/*
QUESTION: Derive the output.
write a query to fetch the results into a desired format.

Solve the problem using PIVOT table.
*/

drop table sales_data;
create table sales_data
    (
        sales_date      date,
        customer_id     varchar(30),
        amount          varchar(30)
    );
insert into sales_data values (convert(datetime, '01-Jan-2021',105), 'Cust-1', '50$');
insert into sales_data values (convert(datetime, '02-Jan-2021',105), 'Cust-1', '50$');
insert into sales_data values (convert(datetime, '03-Jan-2021',105), 'Cust-1', '50$');
insert into sales_data values (convert(datetime, '01-Jan-2021',105), 'Cust-2', '100$');
insert into sales_data values (convert(datetime, '02-Jan-2021',105), 'Cust-2', '100$');
insert into sales_data values (convert(datetime, '03-Jan-2021',105), 'Cust-2', '100$');
insert into sales_data values (convert(datetime, '01-Feb-2021',105), 'Cust-2', '-100$');
insert into sales_data values (convert(datetime, '02-Feb-2021',105), 'Cust-2', '-100$');
insert into sales_data values (convert(datetime, '03-Feb-2021',105), 'Cust-2', '-100$');
insert into sales_data values (convert(datetime, '01-Mar-2021',105), 'Cust-3', '1$');
insert into sales_data values (convert(datetime, '01-Apr-2021',105), 'Cust-3', '1$');
insert into sales_data values (convert(datetime, '01-May-2021',105), 'Cust-3', '1$');
insert into sales_data values (convert(datetime, '01-Jun-2021',105), 'Cust-3', '1$');
insert into sales_data values (convert(datetime, '01-Jul-2021',105), 'Cust-3', '-1$');
insert into sales_data values (convert(datetime, '01-Aug-2021',105), 'Cust-3', '-1$');
insert into sales_data values (convert(datetime, '01-Sep-2021',105), 'Cust-3', '-1$');
insert into sales_data values (convert(datetime, '01-Oct-2021',105), 'Cust-3', '-1$');
insert into sales_data values (convert(datetime, '01-Nov-2021',105), 'Cust-3', '-1$');
insert into sales_data values (convert(datetime, '01-Dec-2021',105), 'Cust-3', '-1$');

select * from sales_data;


-- SOLUTIONS:

Different parts of the query:
1) Aggregate the sales amount for each customer per month:
    - Build the base SQL query:
        - Remove $ symbol
        - Transform sales_date to fetch only the month and year.
2) Aggregate the sales amount per month irrespective of the customer.
3) Aggregate the sales amount per each customer irrespective of the month.
4) Transform final output:
    - Replace negative sign with parenthesis.
    - Suffix amount with $ symbol.





with sales as
		(select customer_id as Customer
		, date_format(sales_date, '%b-%y') as sales_date
		, replace(amount, '$', '') as amount
		from sales_data),
    sales_per_cust as
		(select Customer
		, sum(case when sales_date = 'Jan-21' then amount else 0 end) as Jan_21
		, sum(case when sales_date = 'Feb-21' then amount else 0 end) as Feb_21
		, sum(case when sales_date = 'Mar-21' then amount else 0 end) as Mar_21
		, sum(case when sales_date = 'Apr-21' then amount else 0 end) as Apr_21
		, sum(case when sales_date = 'May-21' then amount else 0 end) as May_21
		, sum(case when sales_date = 'Jun-21' then amount else 0 end) as Jun_21
		, sum(case when sales_date = 'Jul-21' then amount else 0 end) as Jul_21
		, sum(case when sales_date = 'Aug-21' then amount else 0 end) as Aug_21
		, sum(case when sales_date = 'Sep-21' then amount else 0 end) as Sep_21
		, sum(case when sales_date = 'Oct-21' then amount else 0 end) as Oct_21
		, sum(case when sales_date = 'Nov-21' then amount else 0 end) as Nov_21
		, sum(case when sales_date = 'Dec-21' then amount else 0 end) as Dec_21
		, sum(amount) as Total
		from sales s
		group by Customer),
	sales_per_month as
		(select 'Total' as Customer
		, sum(case when sales_date = 'Jan-21' then amount else 0 end) as Jan_21
		, sum(case when sales_date = 'Feb-21' then amount else 0 end) as Feb_21
		, sum(case when sales_date = 'Mar-21' then amount else 0 end) as Mar_21
		, sum(case when sales_date = 'Apr-21' then amount else 0 end) as Apr_21
		, sum(case when sales_date = 'May-21' then amount else 0 end) as May_21
		, sum(case when sales_date = 'Jun-21' then amount else 0 end) as Jun_21
		, sum(case when sales_date = 'Jul-21' then amount else 0 end) as Jul_21
		, sum(case when sales_date = 'Aug-21' then amount else 0 end) as Aug_21
		, sum(case when sales_date = 'Sep-21' then amount else 0 end) as Sep_21
		, sum(case when sales_date = 'Oct-21' then amount else 0 end) as Oct_21
		, sum(case when sales_date = 'Nov-21' then amount else 0 end) as Nov_21
		, sum(case when sales_date = 'Dec-21' then amount else 0 end) as Dec_21
		, '' as Total
		from sales s),
	final_data as
		(select * from sales_per_cust
		UNION
		select * from sales_per_month)
select Customer
, case when Jan_21 < 0 then concat('(', Jan_21 * -1 , ')$') else concat(Jan_21, '$') end as "Jan-21"
, case when Feb_21 < 0 then concat('(', Feb_21 * -1 , ')$') else concat(Feb_21, '$') end as "Feb-21"
, case when Mar_21 < 0 then concat('(', Mar_21 * -1 , ')$') else concat(Mar_21, '$') end as "Mar-21"
, case when Apr_21 < 0 then concat('(', Apr_21 * -1 , ')$') else concat(Apr_21, '$') end as "Apr-21"
, case when May_21 < 0 then concat('(', May_21 * -1 , ')$') else concat(May_21, '$') end as "May-21"
, case when Jun_21 < 0 then concat('(', Jun_21 * -1 , ')$') else concat(Jun_21, '$') end as "Jun-21"
, case when Jul_21 < 0 then concat('(', Jul_21 * -1 , ')$') else concat(Jul_21, '$') end as "Jul-21"
, case when Aug_21 < 0 then concat('(', Aug_21 * -1 , ')$') else concat(Aug_21, '$') end as "Aug-21"
, case when Sep_21 < 0 then concat('(', Sep_21 * -1 , ')$') else concat(Sep_21, '$') end as "Sep-21"
, case when Oct_21 < 0 then concat('(', Oct_21 * -1 , ')$') else concat(Oct_21, '$') end as "Oct-21"
, case when Nov_21 < 0 then concat('(', Nov_21 * -1 , ')$') else concat(Nov_21, '$') end as "Nov-21"
, case when Dec_21 < 0 then concat('(', Dec_21 * -1 , ')$') else concat(Dec_21, '$') end as "Dec-21"
, case when Total = '' then ''
	   when Total < 0 then concat('(', Total * -1 , ')$')
	   else concat(Total, '$') end as "Total"
from final_data;




													--<<THE END>>--