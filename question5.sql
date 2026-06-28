WITH RankedRevenue AS (
select st.name as TerritoryName, p.name ProductName, sum (LineTotal) Revenue ,
ROW_NUMBER() OVER ( PARTITION BY st.name
 ORDER BY SUM(sod.LineTotal) DESC) AS RankInTerritory
from Sales.SalesTerritory st

join Sales.SalesOrderHeader soh on soh.TerritoryID=st.TerritoryID
join Sales.SalesOrderDetail sod on sod.SalesOrderID=soh.SalesOrderID
join Production.Product p on p.ProductID=sod.ProductID
group by st.Name, p.Name)

SELECT *
FROM RankedRevenue
WHERE RankInTerritory <= 3
ORDER BY TerritoryName, RankInTerritory;



