use AdventureWorks2008;
go

create function dbo.zad1( @bussinesID  int, @separator char(3))
returns varchar(max)
as
begin
	declare @ret varchar(max)
	select @ret = ('"' + FirstName + '"' + @separator + '"' + LastName + '"' + @separator + '"' + EmailAddress + '"' + @separator + '"' + City + '"') FROM Person.EmailAddress EA
	JOIN Person.BusinessEntity BE ON EA.BusinessEntityID = BE.BusinessEntityID
	JOIN Person.BusinessEntityAddress BEA ON BEA.BusinessEntityID = BE.BusinessEntityID
	JOIN Person.Address A ON BEA.AddressID = A.AddressID
	JOIN Person.Person P ON P.BusinessEntityID = BE.BusinessEntityID
	where EA.BusinessEntityID = @bussinesID
	return @ret
end
go

select dbo.zad1(11, ' ; ');
