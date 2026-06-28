WITH TerritoryYearRevenue AS (select st.name as TerritoryName, YEAR(soh.OrderDate) OrderYear, sum (sod.LineTotal) Revenue 
from Sales.SalesTerritory st
join Sales.SalesOrderHeader soh on soh.TerritoryID=st.TerritoryID
join Sales.SalesOrderDetail sod on sod.SalesOrderID=soh.SalesOrderID
group by st.Name, YEAR(soh.OrderDate)
)
SELECT 
    TerritoryName,
    OrderYear,
    Revenue,
    LAG(Revenue) OVER (
        PARTITION BY TerritoryName -- restart by territory name
        ORDER BY OrderYear
    ) AS PrevYearRevenue,
    CASE
     when  LAG(Revenue) OVER (
        PARTITION BY TerritoryName 
        ORDER BY OrderYear
    ) =0 then NULL
    ELSE 
        Round((Revenue -  LAG(Revenue) OVER (
        PARTITION BY TerritoryName 
        ORDER BY OrderYear))*100/LAG(Revenue) OVER (
        PARTITION BY TerritoryName 
        ORDER BY OrderYear),2
    )
    END as YoYGrowthPct
    from
    TerritoryYearRevenue

    ORDER BY TerritoryName, OrderYear;



