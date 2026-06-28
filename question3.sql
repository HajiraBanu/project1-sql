USE AdventureWorks2025
SELECT YEAR(OrderDate) Year, MONTH(OrderDate) Month,  Sum(LineTotal) total_revenue, count(OrderDate) as ordercount,
Sum(LineTotal)/count(OrderDate) average_value
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d on d.SalesOrderID= h.SalesOrderID
group by YEAR(OrderDate), MONTH(OrderDate)