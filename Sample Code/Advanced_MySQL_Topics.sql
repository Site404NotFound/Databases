SELECT productLine, SUM(quantityInStock) from products
WHERE MSRP > 125
GROUP BY productLine
HAVING SUM(quantityInStock) > 50000;
-- Having works similarly to WHERE by can work on Aggregate Function
