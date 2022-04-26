USE AdventureWorks2008;
GO

create function dbo.zad4 ( @topPracownikow int )
returns table
as return
(
	select TOP (@topPracownikow) SalesPersonID, P.FirstName, P.LastName, count(SalesPersonID) as NumberOfSales FROM Person.EmailAddress EA
	JOIN Person.BusinessEntity BE ON EA.BusinessEntityID = BE.BusinessEntityID
	JOIN Person.BusinessEntityAddress BEA ON BEA.BusinessEntityID = BE.BusinessEntityID
	JOIN Person.Address A ON BEA.AddressID = A.AddressID
	JOIN Person.Person P ON P.BusinessEntityID = BE.BusinessEntityID
	JOIN HumanResources.Employee Emp ON P.BusinessEntityID = Emp.BusinessEntityID
	JOIN Sales.SalesPerson SP ON SP.BusinessEntityID = Emp.BusinessEntityID
	JOIN Sales.SalesOrderHeader SOH ON SOH.SalesPersonID = SP.BusinessEntityID
	group by SalesPersonID, P.FirstName, P.LastName
	order by COUNT(SalesPersonID) DESC
);
go

select * from dbo.zad4(4);
