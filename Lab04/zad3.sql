USE AdventureWorks2008;

CREATE FUNCTION	dbo.zad3 ( @nazwisko varchar(20) )
RETURNS TABLE 
AS RETURN (
	select LastName, SOH.OrderDate, SOH.SubTotal FROM Person.EmailAddress EA
	JOIN Person.BusinessEntity BE ON EA.BusinessEntityID = BE.BusinessEntityID
	JOIN Person.BusinessEntityAddress BEA ON BEA.BusinessEntityID = BE.BusinessEntityID
	JOIN Person.Address A ON BEA.AddressID = A.AddressID
	JOIN Person.Person P ON P.BusinessEntityID = BE.BusinessEntityID
	JOIN HumanResources.Employee Emp ON P.BusinessEntityID = Emp.BusinessEntityID
	JOIN Sales.SalesPerson SP ON SP.BusinessEntityID = Emp.BusinessEntityID
	JOIN Sales.SalesOrderHeader SOH ON SOH.SalesPersonID = SP.BusinessEntityID
	WHERE LastName like @nazwisko
);

select * from zad3('Carson');