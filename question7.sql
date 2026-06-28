
Select (p.FirstName+' '+p.LastName) SalesPersonName, sp.SalesQuota, sp.SalesYTD,
case
when sp.SalesQuota is null or sp.SalesQuota=0 then null
else round((sp.SalesYTD*100)/sp.SalesQuota ,2)
end as AttainmentPct,
Rank() over(
ORDER BY SalesYTD DESC) as salesrank
from Sales.SalesPerson sp
join Person.Person p on p.BusinessEntityID=sp.BusinessEntityID