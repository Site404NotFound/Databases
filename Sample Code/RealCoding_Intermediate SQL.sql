SELECT p.productName, pl.textDescription, p.MSRP FROM customers c INNER JOIN
orders o ON o.customerNumber = c.customerNumber INNER JOIN
orderdetails od ON od.orderNumber = o.orderNumber INNER JOIN
products p ON p.productCode = od.productCode INNER JOIN
productlines pl ON pl.productLine = p.productLine
WHERE c. customerName = "Atelier graphique";
