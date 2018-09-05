SELECT * FROM bsg_cert, bsg_cert_people;
-- Will Produce a big table of the cross product of thhese two tables
-- Every row from bsg_cert_people will be paired with ever row from bsg_cert

SELECT * FROM bsg_cert,bsg_cert_people WHERE id = cid;
-- We only want rows where id = cid
-- The WHERE clause narrows the search

SELECT P.fname, P.lname, C.title FROM bsg_cert C, bsg_cert_people CP, bsg_cert_people P
WHERE C.id = CP.cid AND CP.pid = P.id;
-- Pair Certifications with people

SELECT P.fname, P.lname, C.title FROM
-- This is familiar but now we are saying what table we are selecting from

FROM bsg_cert C, bsg_cert_people CP, bsg_cert_people P
-- This gives us a huge cross product of the three tables
-- "bsg_cert C" aliases bgs_cert as C so we can type C.title instead of bsg_cert.title

WHERE C.id = CP.cid AND CP.pid = P.id;
-- We only care about lines where the id's all match up
-- Remember the cross product gives us a bunch of meaningless rows


-- What we had above works OK for tables like this
-- You will see it a lot in older databases, but there is a better way
-- Introducing the JOIN
SELECT P.fname, P.Iname, C.title FROM bsg_cert C
INNER JOIN bsg_cert_people CP ON CP.cid = C.id
INNER JOIN bsg_people P ON P.id = CP.pid;

-- It keeps the WHERE selecting only from meaningful data
-- We can do more advanced joins to include things that don't have matching rows
-- Both methods work and you can join many tables
