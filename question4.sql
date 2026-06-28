select YEAR(sh.OrderDate) as OrderYear, MONTH(sh.OrderDate) OrderMonth, SUM(sd.LineTotal) MonthlyRevenue,
sum(SUM(sd.LineTotal)) over(   --window function
partition by (YEAR(sh.OrderDate)) 
order by MONTH(sh.OrderDate)
-- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) RunningYearTotal

from Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd on
sd.SalesOrderID=sh.SalesOrderID
group by YEAR(sh.OrderDate), MONTH(sh.OrderDate)
order by YEAR(sh.OrderDate)

