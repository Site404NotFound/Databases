-- Author: James Hippler (ONID# 932807333)
-- Course: CS 340-400 Introduction to Databases
-- Homework: SQL Assignment
-- Due: Sunday, November 05, 2017


-- #1 Find all films with maximum length or minimum rental duration (compared to all other films).
-- #In other words let L be the maximum film length, and let R be the minimum rental duration
-- in the table film. You need to find all films that have length L or duration R or both length L and duration R.
-- #You just need to return attribute film id for this query.

SELECT film_id AS 'Film ID' FROM film																				-- Select the film_id from film table (Alias table header)
WHERE length = (
	SELECT MAX(length) FROM film																							-- Select only films with the maximum length value
)
OR																																					-- or select
rental_duration = (
	SELECT MIN(rental_duration) FROM film																			-- Only the films with the minimum rental_duration
)
ORDER BY film_id ASC;  																											-- order the output by film_id in ascending order (not required.  For presentation only)

-- #2 We want to find out how many of each category of film ED CHASE has started in so return a table with
-- category.name and the count of the number of films that ED was in which were in that category
-- order by the category name ascending
-- (Your query should return every category even if ED has been in no films in that category).

SELECT category.name AS 'Film Category', edChaseFilms.filmCount AS 'Ed Chase Film Count' FROM category  -- Return a table with category.name and the count of the number of films that ED was in which were in that category
LEFT JOIN (    																																			-- The LEFT JOIN is necessary to show all categories with a Null Ed Chase Film count (Your query should return every category even if ED has been in no films in that category).
    SELECT category.name AS cat, COUNT(film.film_id) AS filmCount FROM category     -- Select the category name (alias catName) and the count of film_id (alias filmCount) from the category table
    INNER JOIN film_category ON film_category.category_id = category.category_id
    INNER JOIN film ON film.film_id = film_category.film_id             						-- Join matching elements from the film table
    INNER JOIN film_actor ON film_actor.film_id = film.film_id          						-- Match film_actor table with film
    INNER JOIN actor ON actor.actor_id = film_actor.actor_id            						-- Match actor with film_actor
    WHERE actor.first_name = 'ED' AND actor.last_name='CHASE'           						-- Grab only the films with Ed Chase
    GROUP BY cat ASC                                          											-- Group by the Category name in ascending order (A - Z)
)
AS edChaseFilms ON edChaseFilms.cat = category.name;          											-- Join where ed chase is Alias the result as edChase

-- #3 Find the first name, last name and total combined film length of Sci-Fi films for every actor
-- #That is the result should list the names of all of the actors(even if an actor has not been in
-- any Sci-Fi films)and the total length of Sci-Fi films they have been in.

SELECT a.first_name AS 'Actor First Name', 																	-- Select the first name,
a.last_name AS 'Actor Last Name',           																-- Select the last name,
SUM(f.length) AS ' Sci-Fi Film Length' FROM category	 											-- and select the total length of sci-fi film
INNER JOIN film_category AS cat ON cat.category_id = category.category_id   -- Match the film_category and category tables
&& category.name = 'Sci-Fi'                             										-- Using only the sci-fi category
INNER JOIN film AS f ON f.film_id = cat.film_id         										-- Match film table with film_id
INNER JOIN film_actor AS fa ON f.film_id = fa.film_id  											-- Match film_actor table and film_id table
RIGHT JOIN actor AS a ON a.actor_id = fa.actor_id   												-- Result should list the names of all of the actors(even if an actor has not been in any Sci-Fi films)and the total length of Sci-Fi films they have been in.
GROUP BY a.first_name, a.last_name;          																-- Group joins by first and last name

-- #4 Find the first name and last name of all actors who have never been in a Sci-Fi film

SELECT actor.first_name AS 'First Name',          										-- Select the actor's first name
actor.last_name AS 'Actor Last Name'                    										-- Select the actor's last name
FROM actor WHERE actor.actor_id NOT IN (                  									-- Use the NOT IN command to select actors whos id are not associated with Sci-Fi in the category table (https://stackoverflow.com/questions/1519272/mysql-not-in-query)
-- The Selection below is used to get the category name sci-fi so that we can determine which actors are NOT IN sci-fi
    SELECT actor.actor_id FROM actor                    										-- Select the id from the actor table
    INNER JOIN film_actor AS fa ON fa.actor_id = actor.actor_id     				-- Match the fim_actor table with the actor_id table
    INNER JOIN film_category AS fc ON fc.film_id = fa.film_id       				-- Match the film_category and film_actor tables
    INNER JOIN category AS cat ON cat.category_id = fc.category_id  				-- Match the category and film_category tables
    WHERE cat.name = 'Sci-Fi'                                       				-- Select the category Sci-Fi
);

-- #5 Find the film title of all films which feature both KIRSTEN PALTROW and WARREN NOLTE
-- #Order the results by title, descending (use ORDER BY title DESC at the end of the query)
-- #Warning, this is a tricky one and while the syntax is all things you know, you have to think oustide
-- #the box a bit to figure out how to get a table that shows pairs of actors in movies

SELECT film.film_id AS 'Film ID', film.title AS 'Film Title' FROM film      -- Select the film id an title from the film table
INNER JOIN film_actor AS fa1 ON fa1.film_id = film.film_id                  -- Match the film_actor and the film table for the first actor
INNER JOIN actor AS a1 ON a1.actor_id = fa1.actor_id                        -- Match the actor table with the film_actor table for the first actor
-- Rinse and Repeat for the second actor
INNER JOIN film_actor AS fa2 ON fa2.film_id = film.film_id                  -- Match the film_actor and the film table for the second actor
INNER JOIN actor AS a2 ON a2.actor_id = fa2.actor_id                        -- Match the actor table with the film_actor table for the second actor

WHERE a1.last_name = 'NOLTE' && a1.first_name = 'WARREN'                    -- Select occurrences where the first actor's first name is Warren and last Name is Nolte
AND                                                                         -- AND also select
a2.last_name = 'PALTROW' && a2.first_name = 'KIRSTEN'                       -- Select occurrences where the second actor's first name is Kristen and last Name is Paltrow
ORDER BY film.title DESC                                                    -- Order the results by title, descending (use ORDER BY title DESC at the end of the query)



-- MYSQL IMPORT RESULTS (Cloud9 Environment)--
-- mysql> source /home/ubuntu/workspace/Assignment2-selection-4.sql;
-- +---------+
-- | Film ID |
-- +---------+
-- |       2 |
-- |       6 |
-- |       9 |
-- |      17 |
-- |      21 |
-- |      23 |
-- |      25 |
-- |      26 |
-- |      37 |
-- |      46 |
-- |      48 |
-- |      50 |
-- |      60 |
-- |      65 |
-- |      69 |
-- |      71 |
-- |      82 |
-- |      90 |
-- |     101 |
-- |     109 |
-- |     111 |
-- |     114 |
-- |     120 |
-- |     124 |
-- |     126 |
-- |     129 |
-- |     135 |
-- |     137 |
-- |     141 |
-- |     142 |
-- |     148 |
-- |     156 |
-- |     169 |
-- |     175 |
-- |     182 |
-- |     184 |
-- |     185 |
-- |     189 |
-- |     195 |
-- |     205 |
-- |     210 |
-- |     212 |
-- |     214 |
-- |     216 |
-- |     225 |
-- |     233 |
-- |     237 |
-- |     243 |
-- |     247 |
-- |     257 |
-- |     260 |
-- |     269 |
-- |     275 |
-- |     285 |
-- |     292 |
-- |     295 |
-- |     304 |
-- |     306 |
-- |     308 |
-- |     314 |
-- |     321 |
-- |     324 |
-- |     327 |
-- |     344 |
-- |     345 |
-- |     349 |
-- |     350 |
-- |     363 |
-- |     364 |
-- |     366 |
-- |     374 |
-- |     382 |
-- |     386 |
-- |     389 |
-- |     402 |
-- |     409 |
-- |     414 |
-- |     415 |
-- |     426 |
-- |     429 |
-- |     431 |
-- |     434 |
-- |     438 |
-- |     444 |
-- |     448 |
-- |     453 |
-- |     460 |
-- |     461 |
-- |     464 |
-- |     472 |
-- |     480 |
-- |     482 |
-- |     483 |
-- |     484 |
-- |     488 |
-- |     496 |
-- |     499 |
-- |     501 |
-- |     503 |
-- |     517 |
-- |     519 |
-- |     529 |
-- |     531 |
-- |     536 |
-- |     537 |
-- |     542 |
-- |     547 |
-- |     548 |
-- |     551 |
-- |     558 |
-- |     567 |
-- |     574 |
-- |     575 |
-- |     579 |
-- |     580 |
-- |     582 |
-- |     583 |
-- |     589 |
-- |     590 |
-- |     599 |
-- |     606 |
-- |     609 |
-- |     618 |
-- |     619 |
-- |     624 |
-- |     625 |
-- |     643 |
-- |     650 |
-- |     651 |
-- |     652 |
-- |     653 |
-- |     656 |
-- |     659 |
-- |     662 |
-- |     667 |
-- |     669 |
-- |     673 |
-- |     674 |
-- |     678 |
-- |     690 |
-- |     692 |
-- |     698 |
-- |     704 |
-- |     713 |
-- |     715 |
-- |     720 |
-- |     723 |
-- |     728 |
-- |     730 |
-- |     738 |
-- |     746 |
-- |     750 |
-- |     753 |
-- |     763 |
-- |     764 |
-- |     768 |
-- |     771 |
-- |     774 |
-- |     778 |
-- |     791 |
-- |     796 |
-- |     799 |
-- |     816 |
-- |     817 |
-- |     819 |
-- |     820 |
-- |     836 |
-- |     846 |
-- |     848 |
-- |     851 |
-- |     853 |
-- |     857 |
-- |     859 |
-- |     861 |
-- |     865 |
-- |     872 |
-- |     873 |
-- |     876 |
-- |     878 |
-- |     879 |
-- |     889 |
-- |     891 |
-- |     892 |
-- |     895 |
-- |     896 |
-- |     897 |
-- |     901 |
-- |     904 |
-- |     908 |
-- |     909 |
-- |     910 |
-- |     912 |
-- |     913 |
-- |     916 |
-- |     917 |
-- |     919 |
-- |     920 |
-- |     925 |
-- |     932 |
-- |     936 |
-- |     938 |
-- |     946 |
-- |     953 |
-- |     966 |
-- |     973 |
-- |     977 |
-- |     978 |
-- |     984 |
-- |     987 |
-- |     990 |
-- |     991 |
-- |    1000 |
-- +---------+
-- 212 rows in set (0.00 sec)
--
-- +---------------+---------------------+
-- | Film Category | Ed Chase Film Count |
-- +---------------+---------------------+
-- | Action        |                   2 |
-- | Animation     |                NULL |
-- | Children      |                NULL |
-- | Classics      |                   2 |
-- | Comedy        |                NULL |
-- | Documentary   |                   6 |
-- | Drama         |                   3 |
-- | Family        |                NULL |
-- | Foreign       |                   2 |
-- | Games         |                NULL |
-- | Horror        |                NULL |
-- | Music         |                   1 |
-- | New           |                   2 |
-- | Sci-Fi        |                   1 |
-- | Sports        |                   2 |
-- | Travel        |                   1 |
-- +---------------+---------------------+
-- 16 rows in set (0.00 sec)
--
-- +------------------+-----------------+--------------------+
-- | Actor First Name | Actor Last Name | Sci-Fi Film Length |
-- +------------------+-----------------+--------------------+
-- | ADAM             | GRANT           |                 86 |
-- | ADAM             | HOPPER          |                379 |
-- | AL               | GARLAND         |                 74 |
-- | ALAN             | DREYFUSS        |                295 |
-- | ALBERT           | JOHANSSON       |                350 |
-- | ALBERT           | NOLTE           |                411 |
-- | ALEC             | WAYNE           |                379 |
-- | ANGELA           | HUDSON          |                223 |
-- | ANGELA           | WITHERSPOON     |                 75 |
-- | ANGELINA         | ASTAIRE         |                146 |
-- | ANNE             | CRONYN          |                255 |
-- | AUDREY           | BAILEY          |                211 |
-- | AUDREY           | OLIVIER         |               NULL |
-- | BELA             | WALKEN          |                 59 |
-- | BEN              | HARRIS          |                165 |
-- | BEN              | WILLIS          |                397 |
-- | BETTE            | NICHOLSON       |                 70 |
-- | BOB              | FAWCETT         |                154 |
-- | BURT             | DUKAKIS         |                260 |
-- | BURT             | POSEY           |               NULL |
-- | BURT             | TEMPLE          |                113 |
-- | CAMERON          | STREEP          |               NULL |
-- | CAMERON          | WRAY            |                241 |
-- | CAMERON          | ZELLWEGER       |               NULL |
-- | CARMEN           | HUNT            |                157 |
-- | CARY             | MCCONAUGHEY     |                435 |
-- | CATE             | HARRIS          |                141 |
-- | CATE             | MCQUEEN         |                213 |
-- | CHARLIZE         | DENCH           |               NULL |
-- | CHRIS            | BRIDGES         |                266 |
-- | CHRIS            | DEPP            |               NULL |
-- | CHRISTIAN        | AKROYD          |                214 |
-- | CHRISTIAN        | GABLE           |                145 |
-- | CHRISTIAN        | NEESON          |                323 |
-- | CHRISTOPHER      | BERRY           |               NULL |
-- | CHRISTOPHER      | WEST            |                146 |
-- | CUBA             | ALLEN           |                533 |
-- | CUBA             | BIRCH           |               NULL |
-- | CUBA             | OLIVIER         |                425 |
-- | DAN              | HARRIS          |                263 |
-- | DAN              | STREEP          |                 51 |
-- | DAN              | TORN            |                254 |
-- | DARYL            | CRAWFORD        |                390 |
-- | DARYL            | WAHLBERG        |                 75 |
-- | DEBBIE           | AKROYD          |                 73 |
-- | DUSTIN           | TAUTOU          |                 64 |
-- | ED               | CHASE           |                134 |
-- | ED               | GUINESS         |                314 |
-- | ED               | MANSFIELD       |                131 |
-- | ELLEN            | PRESLEY         |               NULL |
-- | ELVIS            | MARX            |                108 |
-- | EMILY            | DEE             |                136 |
-- | EWAN             | GOODING         |                146 |
-- | FAY              | KILMER          |                276 |
-- | FAY              | WINSLET         |                318 |
-- | FAY              | WOOD            |                 51 |
-- | FRANCES          | DAY-LEWIS       |                189 |
-- | FRANCES          | TOMEI           |                149 |
-- | FRED             | COSTNER         |                306 |
-- | GARY             | PENN            |                117 |
-- | GARY             | PHOENIX         |                165 |
-- | GENE             | HOPKINS         |                223 |
-- | GENE             | MCKELLEN        |                232 |
-- | GENE             | WILLIS          |                 64 |
-- | GEOFFREY         | HESTON          |                153 |
-- | GINA             | DEGENERES       |                608 |
-- | GOLDIE           | BRODY           |                486 |
-- | GRACE            | MOSTEL          |                131 |
-- | GREG             | CHAPLIN         |                248 |
-- | GREGORY          | GOODING         |                277 |
-- | GRETA            | KEITEL          |                393 |
-- | GRETA            | MALDEN          |                134 |
-- | GROUCHO          | DUNST           |                227 |
-- | GROUCHO          | SINATRA         |                 91 |
-- | GROUCHO          | WILLIAMS        |               NULL |
-- | HARRISON         | BALE            |                346 |
-- | HARVEY           | HOPE            |                311 |
-- | HELEN            | VOIGHT          |               NULL |
-- | HENRY            | BERRY           |                240 |
-- | HUMPHREY         | GARLAND         |                245 |
-- | HUMPHREY         | WILLIS          |                153 |
-- | IAN              | TANDY           |                240 |
-- | JADA             | RYDER           |                221 |
-- | JAMES            | PITT            |                174 |
-- | JANE             | JACKMAN         |                 74 |
-- | JAYNE            | NEESON          |               NULL |
-- | JAYNE            | NOLTE           |                 51 |
-- | JAYNE            | SILVERSTONE     |                263 |
-- | JEFF             | SILVERSTONE     |                112 |
-- | JENNIFER         | DAVIS           |                276 |
-- | JESSICA          | BAILEY          |                 59 |
-- | JIM              | MOSTEL          |                329 |
-- | JODIE            | DEGENERES       |                221 |
-- | JOE              | SWANK           |               NULL |
-- | JOHN             | SUVARI          |                392 |
-- | JOHNNY           | CAGE            |                517 |
-- | JOHNNY           | LOLLOBRIGIDA    |                325 |
-- | JON              | CHASE           |                280 |
-- | JUDE             | CRUISE          |                430 |
-- | JUDY             | DEAN            |                185 |
-- | JULIA            | BARRYMORE       |                129 |
-- | JULIA            | FAWCETT         |               NULL |
-- | JULIA            | MCQUEEN         |                265 |
-- | JULIA            | ZELLWEGER       |                267 |
-- | JULIANNE         | DENCH           |                330 |
-- | KARL             | BERRY           |                172 |
-- | KENNETH          | HOFFMAN         |               NULL |
-- | KENNETH          | PALTROW         |                117 |
-- | KENNETH          | PESCI           |                501 |
-- | KENNETH          | TORN            |                165 |
-- | KEVIN            | BLOOM           |                165 |
-- | KEVIN            | GARLAND         |                130 |
-- | KIM              | ALLEN           |                273 |
-- | KIRK             | JOVOVICH        |               NULL |
-- | KIRSTEN          | AKROYD          |                117 |
-- | KIRSTEN          | PALTROW         |                165 |
-- | LAURA            | BRODY           |               NULL |
-- | LAURENCE         | BULLOCK         |                125 |
-- | LISA             | MONROE          |                252 |
-- | LIZA             | BERGMAN         |                170 |
-- | LUCILLE          | DEE             |               NULL |
-- | LUCILLE          | TRACY           |                371 |
-- | MAE              | HOFFMAN         |                153 |
-- | MARY             | KEITEL          |                314 |
-- | MARY             | TANDY           |                145 |
-- | MATTHEW          | CARREY          |                195 |
-- | MATTHEW          | JOHANSSON       |                112 |
-- | MATTHEW          | LEIGH           |                103 |
-- | MEG              | HAWKE           |                392 |
-- | MENA             | HOPPER          |               NULL |
-- | MENA             | TEMPLE          |                 51 |
-- | MERYL            | ALLEN           |               NULL |
-- | MERYL            | GIBSON          |                146 |
-- | MICHAEL          | BENING          |                172 |
-- | MICHAEL          | BOLGER          |                 71 |
-- | MICHELLE         | MCCONAUGHEY     |               NULL |
-- | MILLA            | KEITEL          |                328 |
-- | MILLA            | PECK            |                 59 |
-- | MINNIE           | KILMER          |                269 |
-- | MINNIE           | ZELLWEGER       |                332 |
-- | MORGAN           | HOPKINS         |                 82 |
-- | MORGAN           | MCDORMAND       |               NULL |
-- | MORGAN           | WILLIAMS        |                 84 |
-- | NATALIE          | HOPKINS         |                220 |
-- | NICK             | DEGENERES       |                138 |
-- | NICK             | STALLONE        |               NULL |
-- | NICK             | WAHLBERG        |                170 |
-- | OLYMPIA          | PFEIFFER        |                530 |
-- | OPRAH            | KILMER          |               NULL |
-- | PARKER           | GOLDBERG        |                303 |
-- | PENELOPE         | CRONYN          |                245 |
-- | PENELOPE         | GUINESS         |                 87 |
-- | PENELOPE         | MONROE          |               NULL |
-- | PENELOPE         | PINKETT         |                 51 |
-- | RALPH            | CRUZ            |                 85 |
-- | RAY              | JOHANSSON       |                157 |
-- | REESE            | KILMER          |                 73 |
-- | REESE            | WEST            |                190 |
-- | RENEE            | BALL            |                233 |
-- | RENEE            | TRACY           |                310 |
-- | RICHARD          | PENN            |                242 |
-- | RIP              | CRAWFORD        |                 84 |
-- | RIP              | WINSLET         |                308 |
-- | RITA             | REYNOLDS        |               NULL |
-- | RIVER            | DEAN            |               NULL |
-- | ROCK             | DUKAKIS         |                 51 |
-- | RUSSELL          | BACALL          |                403 |
-- | RUSSELL          | CLOSE           |                175 |
-- | RUSSELL          | TEMPLE          |                165 |
-- | SALMA            | NOLTE           |                131 |
-- | SANDRA           | KILMER          |                340 |
-- | SANDRA           | PECK            |                 85 |
-- | SCARLETT         | BENING          |                194 |
-- | SCARLETT         | DAMON           |               NULL |
-- | SEAN             | GUINESS         |                393 |
-- | SEAN             | WILLIAMS        |                178 |
-- | SIDNEY           | CROWE           |                229 |
-- | SISSY            | SOBIESKI        |                131 |
-- | SPENCER          | DEPP            |                207 |
-- | SPENCER          | PECK            |                 75 |
-- | SUSAN            | DAVIS           |                300 |
-- | SYLVESTER        | DERN            |                275 |
-- | THORA            | TEMPLE          |                287 |
-- | TIM              | HACKMAN         |                 75 |
-- | TOM              | MCKELLEN        |                181 |
-- | TOM              | MIRANDA         |                 74 |
-- | UMA              | WOOD            |                269 |
-- | VAL              | BOLGER          |                194 |
-- | VIVIEN           | BASINGER        |                437 |
-- | VIVIEN           | BERGEN          |               NULL |
-- | WALTER           | TORN            |               NULL |
-- | WARREN           | JACKMAN         |                308 |
-- | WARREN           | NOLTE           |                255 |
-- | WHOOPI           | HURT            |               NULL |
-- | WILL             | WILSON          |                146 |
-- | WILLIAM          | HACKMAN         |               NULL |
-- | WOODY            | HOFFMAN         |                 83 |
-- | WOODY            | JOLIE           |                332 |
-- | ZERO             | CAGE            |               NULL |
-- +------------------+-----------------+--------------------+
-- 199 rows in set, 1 warning (0.02 sec)
--
-- +-------------+-----------------+
-- | First Name  | Actor Last Name |
-- +-------------+-----------------+
-- | JOE         | SWANK           |
-- | ZERO        | CAGE            |
-- | VIVIEN      | BERGEN          |
-- | HELEN       | VOIGHT          |
-- | CAMERON     | STREEP          |
-- | AUDREY      | OLIVIER         |
-- | KIRK        | JOVOVICH        |
-- | NICK        | STALLONE        |
-- | JAYNE       | NEESON          |
-- | MICHELLE    | MCCONAUGHEY     |
-- | BURT        | POSEY           |
-- | SCARLETT    | DAMON           |
-- | CHARLIZE    | DENCH           |
-- | CHRISTOPHER | BERRY           |
-- | ELLEN       | PRESLEY         |
-- | WALTER      | TORN            |
-- | CAMERON     | ZELLWEGER       |
-- | MORGAN      | MCDORMAND       |
-- | PENELOPE    | MONROE          |
-- | RITA        | REYNOLDS        |
-- | LUCILLE     | DEE             |
-- | WHOOPI      | HURT            |
-- | RIVER       | DEAN            |
-- | LAURA       | BRODY           |
-- | CHRIS       | DEPP            |
-- | OPRAH       | KILMER          |
-- | KENNETH     | HOFFMAN         |
-- | MENA        | HOPPER          |
-- | GROUCHO     | WILLIAMS        |
-- | WILLIAM     | HACKMAN         |
-- | CUBA        | BIRCH           |
-- | MERYL       | ALLEN           |
-- | JULIA       | FAWCETT         |
-- +-------------+-----------------+
-- 33 rows in set (0.00 sec)
--
-- +---------+---------------------+
-- | Film ID | Film Title          |
-- +---------+---------------------+
-- |     920 | UNBREAKABLE KARATE  |
-- |     887 | THIEF PELICAN       |
-- |     733 | RIVER OUTLAW        |
-- |     702 | PULP BEVERLY        |
-- |     507 | LADYBUGS ARMAGEDDON |
-- |       6 | AGENT TRUMAN        |
-- +---------+---------------------+
-- 6 rows in set (0.01 sec)
