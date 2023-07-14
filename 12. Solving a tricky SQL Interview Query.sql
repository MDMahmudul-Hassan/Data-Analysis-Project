/*
	Solving a tricky SQL interview Query.
*/

drop table account_balance;

create table account_balance
(
    account_no          varchar(20),
    transaction_date    date,
    debit_credit        varchar(10),
    transaction_amount  decimal
);

INSERT INTO account_balance 
VALUES	
	('acc_1', CONVERT(date,'2022-01-20'), 'credit', 100),
	('acc_1', CONVERT(date,'2022-01-21'), 'credit', 500),
	('acc_1', CONVERT(date,'2022-01-22'), 'credit', 300),
	('acc_1', CONVERT(date,'2022-01-23'), 'credit', 200),
	('acc_2', CONVERT(date,'2022-01-20'), 'credit', 500),
	('acc_2', CONVERT(date,'2022-01-21'), 'credit', 1100),
	('acc_2', CONVERT(date,'2022-01-22'), 'debit', 1000),
	('acc_4', CONVERT(date,'2022-01-20'), 'credit', 1500),
	('acc_4', CONVERT(date,'2022-01-21'), 'debit', 500),
	('acc_5', CONVERT(date,'2022-01-20'), 'credit', 900);


select * from account_balance;



-- Solution:


with cte as
        (select account_no, transaction_date
            , case when debit_credit = 'debit'
                       then transaction_amount * -1 else transaction_amount end as trns_amt
         from account_balance),
    final_data as
        (select *
         , sum(trns_amt) over (partition by account_no order by transaction_date
                              range between unbounded preceding and unbounded following) as final_balance
         , sum(trns_amt) over (partition by account_no order by transaction_date) as current_balance
         , case when sum(trns_amt) over (partition by account_no order by transaction_date) >= 1000
                    then 1 else 0 end as flag
         from cte)
select account_no, min(transaction_date) as transaction_date
from final_data
where final_balance >= 1000
and flag = 1
group by account_no 



													
													
													
													
													
													--<<THE END>>--