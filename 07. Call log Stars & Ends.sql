/* Write a query to get start time and end time of each all from below 2 tables. Also create a column of call 
duration in minutes. Please do take into account that there will be multiple calls from one phone number and 
each entry in start table has a corresponding entry in end table. */


Use "Ankit_Bansal"

create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);


insert into call_start_logs values
 ('PN1','2022-01-01 10:20:00')
,('PN1','2022-01-01 16:25:00')
,('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00')
,('PN3','2022-01-02 12:30:00')
,('PN3','2022-01-03 09:20:00');




create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);


insert into call_end_logs values
 ('PN1','2022-01-01 10:45:00')
,('PN1','2022-01-01 17:05:00')
,('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00')
,('PN3','2022-01-02 12:50:00')
,('PN3','2022-01-03 09:40:00');



Select * From call_start_logs;

Select * From call_end_logs;


--Solution


Select A.phone_number, A.rn, A.start_time, B.end_time, DATEDIFF(Minute, Start_time, End_time) as Duration
From 
	(Select * ,ROW_NUMBER() Over(Partition By phone_number Order by Start_time) as rn from call_start_logs) A
	Inner Join
	(Select * ,ROW_NUMBER() Over(Partition By Phone_number Order by End_time) as rn from call_end_logs) B
	On A.phone_number = B.phone_number 
	And A.rn = B.rn



											--End--