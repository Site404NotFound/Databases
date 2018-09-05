-- Aggregate functions work on many rows
-- They add or average or do whatever they are going to do across many rows
-- Which rows get included

-- GROUP BY will group rows into sets to which operations are applied

SELECT student_name, AVG(test_score) FROM student GROUP BY student_name;

SELECT student_name, AVG(test_score)
-- Selects student name and the average test_score for the group of records under that name
-- AVG requires a GROUP BY statement

FROM student GROUP BY student_name;
-- Just like before but adds how to group for the AVG function.


SELECT C.title, COUNT (P.id) AS 'CertCount'
FROM bsg_cert C
INNER JOIN bsg_cert_people CP ON CP.cid = C.id
INNER JOIN bsg_people P ON P.id = CP.pid
GROUP BY C.title;
-- This will count person within each certification title
-- In other words it will tell us how many unique people have each certification

SELECT C.title, COUNT (P.id) AS 'CertCount'
-- Selected the title and the count of person ids in the groups we specify later

GROUP BY C.title;
-- Says that the groups will be made based  on certification title
