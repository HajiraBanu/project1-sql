USE AdventureWorks2025;

select  pc.Name as Product_Category, ps.Name Product_SubCategory, Year(soh.OrderDate)  as OrderYear, sum(sod.LineTotal) TotalRevenue, count(*) OrderCount from
Production.Product p
join Production.ProductSubcategory ps on ps.ProductSubcategoryID=p.ProductSubcategoryID
join Production.ProductCategory pc on pc.ProductCategoryID=ps.ProductCategoryID
join Sales.SalesOrderDetail sod on p.productID =sod.ProductID 
join Sales.SalesOrderHeader soh on soh.SalesOrderID=sod.SalesOrderID
group by YEAR(soh.OrderDate), pc.Name, ps.Name
