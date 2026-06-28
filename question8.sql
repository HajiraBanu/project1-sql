with productRevenue as(
    SELECT 
        p.Name AS ProductName,
        SUM(sod.LineTotal) AS Revenue        
    FROM Production.Product p
    JOIN Sales.SalesOrderDetail sod 
        ON p.ProductID = sod.ProductID
    GROUP BY p.Name
    ),
RevenueWithTotal as(
    SELECT 
        ProductName,
        Revenue,
        SUM(Revenue) OVER () AS TotalRevenue,
        SUM(Revenue) OVER (
            ORDER BY Revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS RunningRevenue
    FROM ProductRevenue
)

select
ProductName,
        Revenue,
        TotalRevenue,
        RunningRevenue,
         ROUND(RunningRevenue*100/TotalRevenue,2) as CumulativeRevenuePct,
         case when ROUND(RunningRevenue*100/TotalRevenue,2) <= 80 THEN 'A'
         when ROUND(RunningRevenue*100/TotalRevenue,2) <= 95 THEN 'B'
         else 'C'
         END AS ABCClass
         FROM RevenueWithTotal
         ORDER BY Revenue DESC;
