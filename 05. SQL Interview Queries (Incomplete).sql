/*

** SQL Interview Queries **

Using the above table schema, please write the following queries. To test your queries, you can use some dummy data.

1.Calculate the average rating given by students to each teacher for each session created. Also, provide the batch name for which session was conducted.

2.Find the attendance percentage  for each session for each batch. Also mention the batch name and users name who has conduct that session

3.What is the average marks scored by each student in all the tests the student had appeared?

4.A student is passed when he scores 40 percent of total marks in a test. Find out how many students passed in each test. Also mention the batch name for that test.

5.A student can be transferred from one batch to another batch. If he is transferred from batch a to batch b. batch b’s active=true and batch a’s active=false in student_batch_maps.
 At a time, one student can be active in one batch only. One Student can not be transferred more than four times. Calculate each students attendance percentage for all the sessions created for his past batch. Consider only those sessions for which he was active in that past batch.

6. What is the average percentage of marks scored by each student in all the tests the student had appeared?

7. A student is passed when he scores 40 percent of total marks in a test. Find out how many percentage of students have passed in each test. Also mention the batch name for that test.

8. A student can be transferred from one batch to another batch. If he is transferred from batch a to batch b. batch b’s active=true and batch a’s active=false in student_batch_maps.
    At a time, one student can be active in one batch only. One Student can not be transferred more than four times.
    Calculate each students attendance percentage for all the sessions.

Note - Data is not provided for these tables, you can insert some dummy data if required.


*/


Drop tables and sequence:

use	[SQL Interview Queries.]



DROP SEQUENCE instructor_batch_maps_id_seq;
DROP SEQUENCE sessions_id_seq;
DROP SEQUENCE tests_id_seq;
DROP SEQUENCE student_batch_maps_id_seq;
DROP SEQUENCE users_id_seq;
DROP SEQUENCE batch_id_seq;


-- 1. Calculate the average rating given by students to each teacher for each session created. Also, provide the batch name for which session was conducted.

DROP TABLE users;

CREATE SEQUENCE users_id_seq;

CREATE TABLE users (
  id INTEGER PRIMARY KEY NOT NULL IDENTITY(1,1),
  name VARCHAR(50) NOT NULL,
  active BIT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE()
);


INSERT INTO users (name, active, created_at, updated_at) VALUES 
	('Rohit', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('James', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('David', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Steven', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Ali', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Rahul', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Jacob', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Maryam', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Shwetha', 0, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Sarah', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	( 'Alex', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	( 'Charles', 0, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Perry', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Emma', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Sophia', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Lucas', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Benjamin', 1, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE())),
	('Hazel', 0, DATEADD(day, -5, GETDATE()), DATEADD(day, -4, GETDATE()));

Select * From users;



-->> SOLUTION 01: <<--




















-- 2. Find the attendance percentage  for each session for each batch. Also mention the batch name and users name who has conduct that session.

CREATE SEQUENCE batch_id_seq;

-- DROP TABLE batches;


CREATE TABLE batches (
  id INTEGER PRIMARY KEY NOT NULL IDENTITY(1,1),
  name VARCHAR(100) UNIQUE NOT NULL,
  active BIT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO batches (name, active, created_at, updated_at) VALUES ('Statistics', 1, DATEADD(day,-10,GETDATE()), DATEADD(day,-6,GETDATE()));
INSERT INTO batches (name, active, created_at, updated_at) VALUES ('Mathematics', 1, DATEADD(day,-10,GETDATE()), DATEADD(day,-6,GETDATE()));
INSERT INTO batches (name, active, created_at, updated_at) VALUES ('Physics', 0, DATEADD(day,-10,GETDATE()), DATEADD(day,-6,GETDATE()));




-->> SOLUTION 02: <<--

Select * From student_batch_maps;
Select * From attendances;
Select * From sessions;


with total_students_per_batch as
		(Select batch_id , count(1)  as Students_Per_Batch 
		From student_batch_maps
		Where active = 1
		Group by batch_id),
		Students_present_per_session as
		(Select session_id, count(1) as attended_students
		from attendances
		group by session_id)
Select 
from 
















-- 3.student_batch_maps  table: this table is a mapping of the student and his batch. deactivated_at is the time when a student is made inactive in a batch.

-- DROP TABLE student_batch_maps;

CREATE SEQUENCE student_batch_maps_id_seq;

CREATE TABLE student_batch_maps 
(
	id INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
	user_id INTEGER NOT NULL FOREIGN KEY REFERENCES users(id),
	batch_id INTEGER NOT NULL FOREIGN KEY REFERENCES batches(id),
	active BIT NOT NULL DEFAULT 1,
	deactivated_at DATETIME NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO student_batch_maps (user_id, batch_id, active, deactivated_at, created_at, updated_at)
VALUES (1, 1, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(2, 1, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(3, 1, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(4, 1, 0, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(5, 2, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(6, 2, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(7, 2, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(8, 2, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(9, 2, 0, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(10, 3, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(11, 3, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(12, 3, 0, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(13, 3, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(14, 3, 1, CURRENT_TIMESTAMP, DATEADD(day, -5, CURRENT_TIMESTAMP), DATEADD(day, -4, CURRENT_TIMESTAMP)),
(4, 2, 1, CURRENT_TIMESTAMP, DATEADD(day, -4, CURRENT_TIMESTAMP), DATEADD(day, -3, CURRENT_TIMESTAMP)),
(9, 3, 0, CURRENT_TIMESTAMP, DATEADD(day, -3, CURRENT_TIMESTAMP), DATEADD(day, -2, CURRENT_TIMESTAMP)),
(9, 1, 1, CURRENT_TIMESTAMP, DATEADD(day, -2, CURRENT_TIMESTAMP), DATEADD(day, -1, CURRENT_TIMESTAMP)),
(12, 1, 1, CURRENT_TIMESTAMP, DATEADD(day, -4, CURRENT_TIMESTAMP), DATEADD(day, -3, CURRENT_TIMESTAMP));





-- 4.instructor_batch_maps  table: this table is a mapping of the instructor and the batch he has been assigned to take class/session.

-- DROP TABLE instructor_batch_maps;

CREATE SEQUENCE instructor_batch_maps_id_seq;

CREATE TABLE instructor_batch_maps (
  id INTEGER PRIMARY KEY NOT NULL IDENTITY(1,1),
  user_id INTEGER REFERENCES users(id),
  batch_id INTEGER REFERENCES batches(id),
  active BIT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO instructor_batch_maps (user_id, batch_id, active, created_at, updated_at)
VALUES (15, 1, 1, DATEADD(DAY, -5, CURRENT_TIMESTAMP), DATEADD(DAY, -4, CURRENT_TIMESTAMP)),
       (16, 2, 1, DATEADD(DAY, -5, CURRENT_TIMESTAMP), DATEADD(DAY, -4, CURRENT_TIMESTAMP)),
       (17, 3, 1, DATEADD(DAY, -5, CURRENT_TIMESTAMP), DATEADD(DAY, -4, CURRENT_TIMESTAMP)),
       (18, 2, 1, DATEADD(DAY, -5, CURRENT_TIMESTAMP), DATEADD(DAY, -4, CURRENT_TIMESTAMP));





-- 5.sessions table: Every day session happens where the teacher takes a session or class of students.

-- DROP TABLE sessions;

CREATE SEQUENCE sessions_id_seq;

CREATE TABLE sessions 
(
  id INTEGER PRIMARY KEY NOT NULL IDENTITY(1,1),
  conducted_by INTEGER NOT NULL REFERENCES users(id),
  batch_id INTEGER NOT NULL REFERENCES batches(id),
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO sessions (conducted_by, batch_id, start_time, end_time, created_at, updated_at)
	VALUES 
		(15, 1, DATEADD(MINUTE, -240, GETDATE()), DATEADD(MINUTE, -180, GETDATE()), GETDATE(), GETDATE()),
		(16, 2, DATEADD(MINUTE, -240, GETDATE()), DATEADD(MINUTE, -180, GETDATE()), GETDATE(), GETDATE()),
		(17, 3, DATEADD(MINUTE, -240, GETDATE()), DATEADD(MINUTE, -180, GETDATE()), GETDATE(), GETDATE()),
		(15, 1, DATEADD(MINUTE, -180, GETDATE()), DATEADD(MINUTE, -120, GETDATE()), GETDATE(), GETDATE()),
		(16, 2, DATEADD(MINUTE, -180, GETDATE()), DATEADD(MINUTE, -120, GETDATE()), GETDATE(), GETDATE()),
		(18, 2, DATEADD(MINUTE, -120, GETDATE()), DATEADD(MINUTE, -60, GETDATE()), GETDATE(), GETDATE());



-- 6. A student is passed when he scores 40 percent of total marks in a test. Find out how many percentage of students have passed in each test. Also mention the batch name for that test.


Drop Table attendances


CREATE TABLE attendances (
  student_id INTEGER NOT NULL REFERENCES users(id),
  session_id INTEGER NOT NULL REFERENCES sessions(id),
  rating FLOAT NOT NULL,
  created_at DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (student_id, session_id)
);

INSERT INTO attendances VALUES (1, 1, 8.5, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (2, 1, 7.5, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (3, 1, 6.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (5, 2, 8.5, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (6, 2, 7.5, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (7, 2, 6.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (8, 2, 6.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (10, 3, 9.5, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (11, 3, 7.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (13, 3, 8.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (14, 3, 6.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (1, 4, 7.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (2, 4, 5.5, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (5, 5, 5.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (5, 6, 6.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (9, 2, 4.0, GETDATE(), GETDATE());
INSERT INTO attendances VALUES (12, 3, 5.0, GETDATE(), GETDATE());

Select * From attendances;


-- 7 .tests table: Test is created by instructor. total_mark is the maximum marks for the test.

-- DROP TABLE tests;

CREATE SEQUENCE tests_id_seq;

CREATE TABLE tests (
   id INTEGER PRIMARY KEY NOT NULL DEFAULT NEXT VALUE FOR tests_id_seq,
   batch_id INTEGER REFERENCES batches(id),
   created_by INTEGER REFERENCES users(id),
   total_mark INTEGER NOT NULL,
   created_at DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
   updated_at DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO tests VALUES (1, 1, 15, 100, GETDATE(), GETDATE());
INSERT INTO tests VALUES (2, 2, 16, 100, GETDATE(), GETDATE());
INSERT INTO tests VALUES (3, 3, 17, 100, GETDATE(), GETDATE());
INSERT INTO tests VALUES (4, 2, 18, 100, GETDATE(), GETDATE());
INSERT INTO tests VALUES (5, 1, 15, 50, GETDATE(), GETDATE());
INSERT INTO tests VALUES (6, 1, 15, 25, GETDATE(), GETDATE());
INSERT INTO tests VALUES (7, 1, 15, 25, GETDATE(), GETDATE());
INSERT INTO tests VALUES (8, 2, 16, 50, GETDATE(), GETDATE());
INSERT INTO tests VALUES (9, 3, 17, 50, GETDATE(), GETDATE());




-- 8.test_scores table: Marks scored by students are added in the test_scores table.

-- DROP TABLE test_scores;

CREATE TABLE test_scores (
  test_id INTEGER REFERENCES tests(id),
  user_id INTEGER REFERENCES users(id),
  score INTEGER NOT NULL,
  created_at DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(test_id, user_id)
);

INSERT INTO test_scores VALUES (1, 1, 80, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (1, 2, 60, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (1, 3, 30, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (2, 5, 80, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (2, 6, 35, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (2, 7, 38, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (2, 8, 90, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (3, 10, 65, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (3, 11, 85, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (3, 13, 95, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (3, 14, 100, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (5, 1, 40, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (5, 2, 35, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (5, 3, 45, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (6, 1, 22, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (6, 2, 12, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (7, 1, 16, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (7, 3, 10, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (8, 5, 15, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (8, 6, 20, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (9, 13, 25, GETDATE(), GETDATE());
INSERT INTO test_scores VALUES (9, 14, 35, GETDATE(), GETDATE());
