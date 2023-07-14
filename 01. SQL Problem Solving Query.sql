/*

Problem Statement :-
Find the distance travelled by each car per day:


Suppose you have a car travelling certain distance and the data is;
presented as follows —

Day 1 - 50 km
Day 2 - 100 km
Day 3 - 200 km

Now the distance is a cumulative sum as in:
	row2 = (kms travelled on that day + rowl kms)
	
	
How should I get the table in the form of kms travelled by the car on
a given day and not the sum of the total distance?


*/


-->> Solution:


create table car_travels
(
    cars                    varchar(40),
    days                    varchar(10),
    cumulative_distance     int
);

insert into car_travels values ('Car1', 'Day1', 50);
insert into car_travels values ('Car1', 'Day2', 100);
insert into car_travels values ('Car1', 'Day3', 200);
insert into car_travels values ('Car2', 'Day1', 0);
insert into car_travels values ('Car3', 'Day1', 0);
insert into car_travels values ('Car3', 'Day2', 50);
insert into car_travels values ('Car3', 'Day3', 50);
insert into car_travels values ('Car3', 'Day4', 100);


Select * from car_travels


Select cars, days 
, (cumulative_distance
	-LAG(cumulative_distance , 1,0) 
	over(partition by cars order by days)) as distance_traveles_per_day
from car_travels;




										<<The End>>