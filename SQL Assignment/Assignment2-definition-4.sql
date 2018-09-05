-- Author: James Hippler (ONID# 932807333)
-- Course: CS 340-400 Introduction to Databases
-- Homework: SQL Assignment
-- Due: Sunday, November 05, 2017

-- For part one of this assignment you are to make a database with the following specifications and run the following queries
-- Table creation queries should immedatley follow the drop table queries, this is to facilitate testing on my end

DROP TABLE IF EXISTS `works_on`;
DROP TABLE IF EXISTS `project`;
DROP TABLE IF EXISTS `client`;
DROP TABLE IF EXISTS `employee`;

-- Create a table called client with the following properties:
-- id - an auto incrementing integer which is the primary key
-- first_name - a varchar with a maximum length of 255 characters, cannot be null
-- last_name - a varchar with a maximum length of 255 characters, cannot be null
-- dob - a date type (you can read about it here http://dev.mysql.com/doc/refman/5.0/en/datetime.html)
-- the combination of the first_name and last_name must be unique in this table

-- client table creation query replaces this text
CREATE TABLE client (
  id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  dob DATE,
  CONSTRAINT full_name UNIQUE (first_name, last_name),
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Create a table called employee with the following properties:
-- id - an auto incrementing integer which is the primary key
-- first_name - a varchar of maximum length 255, cannot be null
-- last_name - a varchar of maximum length 255, cannot be null
-- dob - a date type
-- date_joined - a date type
-- the combination of the first_name and last_name must be unique in this table

-- employee table creation query replaces this text
CREATE TABLE employee (
  id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  dob DATE,
  date_joined DATE,
  CONSTRAINT full_name UNIQUE (first_name, last_name),
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Create a table called project with the following properties:
-- id - an auto incrementing integer which is the primary key
-- cid - an integer which is a foreign key reference to the client table
-- name - a varchar of maximum length 255, cannot be null
-- notes - a text type
-- the name of the project should be unique in this table

-- project table creation query replaces this text
CREATE TABLE project (
  id INT NOT NULL AUTO_INCREMENT,
  cid INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  notes TEXT,
  CONSTRAINT project_name UNIQUE (name),
  PRIMARY KEY (id),
  FOREIGN KEY (cid) REFERENCES client (id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Create a table called works_on with the following properties, this is a table representing a many-to-many relationship
-- between employees and projects:
-- eid - an integer which is a foreign key reference to employee
-- pid - an integer which is a foreign key reference to project
-- start_date - a date type
-- The primary key is a combination of eid and pid

-- works_on table creation query replaces this text
CREATE TABLE works_on (
  eid INT NOT NULL,
  pid INT NOT NULL,
  start_date DATE,
  FOREIGN KEY (eid) REFERENCES employee (id),
  FOREIGN KEY (pid) REFERENCES project (id),
  PRIMARY KEY (eid, pid)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- insert the following into the client table:

-- first_name: Sara
-- last_name: Smith
-- dob: 1/2/1970
INSERT INTO client (first_name, last_name, dob)
VALUES ('Sara', 'Smith', DATE '1970-01-02');

-- first_name: David
-- last_name: Atkins
-- dob: 11/18/1979
INSERT INTO client (first_name, last_name, dob)
VALUES ('David', 'Atkins', DATE '1979-11-18');

-- first_name: Daniel
-- last_name: Jensen
-- dob: 3/2/1985
INSERT INTO client (first_name, last_name, dob)
VALUES ('Daniel', 'Jensen', DATE '1985-03-02');

-- insert the following into the employee table:

-- first_name: Adam
-- last_name: Lowd
-- dob: 1/2/1975
-- date_joined: 1/1/2009
INSERT INTO employee (first_name, last_name, dob, date_joined)
VALUES ('Adam', 'Lowd', DATE '1975-01-02', DATE '2009-01-01');

-- first_name: Michael
-- last_name: Fern
-- dob: 10/18/1980
-- date_joined: 6/5/2013
INSERT INTO employee (first_name, last_name, dob, date_joined)
VALUES ('Michael', 'Fern', DATE '1980-10-18', DATE '2013-06-05');

-- first_name: Deena
-- last_name: Young
-- dob: 3/21/1984
-- date_joined: 11/10/2013
INSERT INTO employee (first_name, last_name, dob, date_joined)
VALUES ('Deena', 'Young', DATE '1984-03-21', DATE '2013-11-10');

-- insert the following project instances into the project table (you should use a subquery to set up foriegn key referecnes, no hard coded numbers):

-- cid - reference to first_name: Sara last_name: Smith
-- name - Diamond
-- notes - Should be done by Jan 2017

INSERT INTO project (cid, name, notes)
VALUES (
  (SELECT id from client WHERE first_name='Sara' && last_name='Smith'),
  'Diamond',
  'Should be done by Jan 2017'
);

-- cid - reference to first_name: David last_name: Atkins
-- name - Eclipse
-- notes - NULL
INSERT INTO project (cid, name)
VALUES (
  (SELECT id from client WHERE first_name='David' && last_name='Atkins'),
  'Eclipse'
);

-- cid - reference to first_name: Daniel last_name: Jensen
-- name - Moon
-- notes - NULL
INSERT INTO project (cid, name) VALUES (
  (SELECT id from client WHERE first_name='Daniel' && last_name='Jensen'),
  'Moon'
);

-- insert the following into the works_on table using subqueries to look up data as needed:

-- employee: Adam Lowd
-- project: Diamond
-- start_date: 1/1/2012
INSERT INTO works_on (eid, pid, start_date)
VALUES (
  (SELECT id FROM employee WHERE first_name='Adam' && last_name='Lowd'),
  (SELECT id FROM project WHERE name='Diamond'),
  DATE '2012-01-01'
);

-- employee: Michael Fern
-- project: Eclipse
-- start_date: 8/8/2013
INSERT INTO works_on (eid, pid, start_date)
VALUES (
  (SELECT id FROM employee WHERE first_name='Michael' && last_name='Fern'),
  (SELECT id FROM project WHERE name='Eclipse'),
  DATE '2013-08-08'
);

-- employee: Michael Fern
-- project: Moon
-- start_date: 9/11/2014
INSERT INTO works_on (eid, pid, start_date)
VALUES (
  (SELECT id FROM employee WHERE first_name='Michael' && last_name='Fern'),
  (SELECT id FROM project WHERE name='Moon'),
  DATE '2014-09-11'
);

-- MYSQL IMPORT RESULTS (Cloud9 Environment)--
-- mysql> source /home/ubuntu/workspace/Assignment2-definition-4.sql;
-- Query OK, 0 rows affected (0.01 sec)
--
-- Query OK, 0 rows affected (0.01 sec)
--
-- Query OK, 0 rows affected (0.00 sec)
--
-- Query OK, 0 rows affected (0.00 sec)
--
-- Query OK, 0 rows affected (0.01 sec)
--
-- Query OK, 0 rows affected (0.01 sec)
--
-- Query OK, 0 rows affected (0.00 sec)
--
-- Query OK, 0 rows affected (0.02 sec)
--
-- Query OK, 1 row affected (0.00 sec)
--
-- Query OK, 1 row affected (0.00 sec)
--
-- Query OK, 1 row affected (0.00 sec)
--
-- Query OK, 1 row affected (0.01 sec)
--
-- Query OK, 1 row affected (0.00 sec)
--
-- Query OK, 1 row affected (0.01 sec)
--
-- Query OK, 1 row affected (0.00 sec)
--
-- Query OK, 1 row affected (0.00 sec)
--
-- Query OK, 1 row affected (0.00 sec)
--
-- Query OK, 1 row affected (0.01 sec)
--
-- Query OK, 1 row affected (0.00 sec)
--
-- Query OK, 1 row affected (0.01 sec)
--
-- mysql> show tables;
-- +---------------------+
-- | Tables_in_workplace |
-- +---------------------+
-- | client              |
-- | employee            |
-- | project             |
-- | works_on            |
-- +---------------------+
-- 4 rows in set (0.00 sec)
--
-- mysql> desc client;
-- +------------+--------------+------+-----+---------+----------------+
-- | Field      | Type         | Null | Key | Default | Extra          |
-- +------------+--------------+------+-----+---------+----------------+
-- | id         | int(11)      | NO   | PRI | NULL    | auto_increment |
-- | first_name | varchar(255) | NO   | MUL | NULL    |                |
-- | last_name  | varchar(255) | NO   |     | NULL    |                |
-- | dob        | date         | YES  |     | NULL    |                |
-- +------------+--------------+------+-----+---------+----------------+
-- 4 rows in set (0.00 sec)
--
-- mysql> desc employee;
-- +-------------+--------------+------+-----+---------+----------------+
-- | Field       | Type         | Null | Key | Default | Extra          |
-- +-------------+--------------+------+-----+---------+----------------+
-- | id          | int(11)      | NO   | PRI | NULL    | auto_increment |
-- | first_name  | varchar(255) | NO   | MUL | NULL    |                |
-- | last_name   | varchar(255) | NO   |     | NULL    |                |
-- | dob         | date         | YES  |     | NULL    |                |
-- | date_joined | date         | YES  |     | NULL    |                |
-- +-------------+--------------+------+-----+---------+----------------+
-- 5 rows in set (0.00 sec)
--
-- mysql> desc project;
-- +-------+--------------+------+-----+---------+----------------+
-- | Field | Type         | Null | Key | Default | Extra          |
-- +-------+--------------+------+-----+---------+----------------+
-- | id    | int(11)      | NO   | PRI | NULL    | auto_increment |
-- | cid   | int(11)      | NO   | MUL | NULL    |                |
-- | name  | varchar(255) | NO   | UNI | NULL    |                |
-- | notes | text         | YES  |     | NULL    |                |
-- +-------+--------------+------+-----+---------+----------------+
-- 4 rows in set (0.00 sec)
--
-- mysql> desc works_on;
-- +------------+---------+------+-----+---------+-------+
-- | Field      | Type    | Null | Key | Default | Extra |
-- +------------+---------+------+-----+---------+-------+
-- | eid        | int(11) | NO   | PRI | NULL    |       |
-- | pid        | int(11) | NO   | PRI | NULL    |       |
-- | start_date | date    | YES  |     | NULL    |       |
-- +------------+---------+------+-----+---------+-------+
-- 3 rows in set (0.00 sec)
--
-- mysql> SELECT * FROM client;
-- +----+------------+-----------+------------+
-- | id | first_name | last_name | dob        |
-- +----+------------+-----------+------------+
-- | 10 | Sara       | Smith     | 1970-01-02 |
-- | 11 | David      | Atkins    | 1979-11-18 |
-- | 12 | Daniel     | Jensen    | 1985-03-02 |
-- +----+------------+-----------+------------+
-- 3 rows in set (0.00 sec)
--
-- mysql> SELECT * FROM employee;
-- +----+------------+-----------+------------+-------------+
-- | id | first_name | last_name | dob        | date_joined |
-- +----+------------+-----------+------------+-------------+
-- | 10 | Adam       | Lowd      | 1975-01-02 | 2009-01-01  |
-- | 11 | Michael    | Fern      | 1980-10-18 | 2013-06-05  |
-- | 12 | Deena      | Young     | 1984-03-21 | 2013-11-10  |
-- +----+------------+-----------+------------+-------------+
-- 3 rows in set (0.00 sec)
--
-- mysql> SELECT * FROM project;
-- +----+-----+---------+----------------------------+
-- | id | cid | name    | notes                      |
-- +----+-----+---------+----------------------------+
-- | 10 |  10 | Diamond | Should be done by Jan 2017 |
-- | 11 |  11 | Eclipse | NULL                       |
-- | 12 |  12 | Moon    | NULL                       |
-- +----+-----+---------+----------------------------+
-- 3 rows in set (0.00 sec)
--
-- mysql> SELECT * FROM works_on;
-- +-----+-----+------------+
-- | eid | pid | start_date |
-- +-----+-----+------------+
-- |  10 |  10 | 2012-01-01 |
-- |  11 |  11 | 2013-08-08 |
-- |  11 |  12 | 2014-09-11 |
-- +-----+-----+------------+
-- 3 rows in set (0.00 sec)
