WITH RFM AS(
select h.CustomerID, DATEDIFF(day, Max(h.OrderDate), GETDATE()) Recency, count(DISTINCT h.OrderDate) Frequency, sum(d.LineTotal) Monetary 
from Sales.SalesOrderHeader h
JOIN
Sales.SalesOrderDetail d on d.SalesOrderID=h.SalesOrderID
group by h.CustomerID),

RFMScore as(
SELECT 
        CustomerID,
        Recency,
        Frequency,
        Monetary,
        NTILE(4) OVER (ORDER BY Recency ASC) AS RScore,   -- lower recency = better
        NTILE(4) OVER (ORDER BY Frequency DESC) AS FScore, -- higher frequency = better
        NTILE(4) OVER (ORDER BY Monetary DESC) AS MScore   -- higher spend = better
    FROM RFM )

    select CustomerID,
        Recency,
        Frequency,
        Monetary,RScore, FScore,MScore,
        case when RScore= 4 and FScore=4 then 'Champions'
        WHEN RScore >= 3 AND FScore >= 3 THEN 'Loyal'
        WHEN RScore <= 2 AND FScore <= 2 THEN 'At Risk'
        ELSE 'Lost'
    END AS Segment from  RFMScore
    order by Segment, CustomerID

