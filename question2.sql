USE AdventureWorks2025
Select top 10 sc.CustomerID custID, 
COALESCE(p.FirstName + ' ' + p.LastName, s.Name) AS CustomerName,
MIN(OrderDate) as First_OrderDate, MAX(OrderDate) as Last_OrderDate,SUM(LineTotal) Total_Spend, COUNT(sod.SalesOrderID) as OrderCount
from Sales.Customer sc 
join Sales.SalesOrderHeader soh on soh.CustomerID= sc.CustomerID
join Sales.SalesOrderDetail sod on sod.SalesOrderID= soh.SalesOrderID
left join Person.Person p on sc.PersonID= p.BusinessEntityID
left JOIN Sales.Store s on s.BusinessEntityID= sc.StoreID
group by sc.CustomerID,  p.FirstName, p.LastName, s.Name
order by Total_Spend desc

