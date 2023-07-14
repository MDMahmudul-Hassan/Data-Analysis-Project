/*
	Solving 03 SQL Queries.
*/


-->> SQL Problem 01: 
	 --Print meaningful comments 
	 -- Write an SQL query to display the correct message (meaningful message) from input comments_and_translation table.



-- drop table comments_and_translations;


create table comments_and_translations
(
	id				int,
	comment			varchar(100),
	translation		varchar(100)
);

insert into comments_and_translations 
values
(1, 'very good', null),
(2, 'good', null),
(3, 'bad', null),
(4, 'ordinary', null),
(5, 'cdcdcdcd', 'very bad'),
(6, 'excellent', null),
(7, 'ababab', 'not satisfied'),
(8, 'satisfied', null),
(9, 'aabbaabb', 'extraordinary'),
(10, 'ccddccbb', 'medium');
commit;



-->> Method 01: 



Select * 
From comments_and_translations

Select Case when translation is null 
	Then comment
	else translation
	end as Output
From comments_and_translations;


-->> Method 02: 


Select coalesce(translation,comment) as Output
From comments_and_translations;




-->> SQL Problem 02:
	  --Derive desired output
	  --Using the Source and Target table, write a query to arrive at the Output table as shown in below image. Provide the solution without using subqueries.





--DROP TABLE source;


CREATE TABLE source
    (
        id      int,
        name    varchar(1)
    );

--DROP TABLE target;


CREATE TABLE target
    (
        id      int,
        name    varchar(1)
    );

INSERT INTO source VALUES (1, 'A');
INSERT INTO source VALUES (2, 'B');
INSERT INTO source VALUES (3, 'C');
INSERT INTO source VALUES (4, 'D');

INSERT INTO target VALUES (1, 'A');
INSERT INTO target VALUES (2, 'B');
INSERT INTO target VALUES (4, 'X');
INSERT INTO target VALUES (5, 'F');

COMMIT;


Select *
from source;

Select *
From target;



Select s.id	, 'Mismatch' as Comment
from source s
join target t 
on
	t.id=s.id
and	
	s.name <> t.name

	union

Select s.id, 'New In Source' as Comment
From source s
Left Join target t
on	
	t.id = s.id
Where
	t.id is null

	union

Select t.id, 'New In Target' as Comment
from source s
Right Join target t
on
	t.id=s.id
where
	s.id is Null;





-->> SQL Problem 03:
	  -- IPL Matches
	  -- There are 10 IPL team. write an sql query such that each team play with every other team just once.
	  -- Also write another query such that each team plays with every other team twice.



-- drop table teams;


create table teams
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');
commit;


Select *
from teams;


-- write an sql query such that each team play with every other team just once.



with matches as 
	(Select ROW_NUMBER() over(order by team_name) as ID, team_code,team_name
	from teams)
select team.team_name as Team, opponent.team_name as Opponent 
from matches team
join matches opponent 
on
	team.id < opponent.id;




-- write another query such that each team plays with every other team twice.


with matches as 
	(Select ROW_NUMBER() over(order by team_name) as ID, team_code,team_name
	from teams)
select team.team_name as Team, opponent.team_name as Opponent 
from matches team
join matches opponent 
on
	team.id <> opponent.id;




--<< THE END>>--



