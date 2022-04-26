use AdventureWorks2008;
go

create function dbo.zad2( @N int, @P int )
returns @ans table
(
	LastName varchar(50),
	FirstName varchar(50),
	email varchar(50),
	city varchar(50)
)
as
begin
	with 
	wynikiCTE as
	(
		select FirstName, LastName, EmailAddress, City FROM Person.EmailAddress EA
		JOIN Person.BusinessEntity BE ON EA.BusinessEntityID = BE.BusinessEntityID
		JOIN Person.BusinessEntityAddress BEA ON BEA.BusinessEntityID = BE.BusinessEntityID
		JOIN Person.Address A ON BEA.AddressID = A.AddressID
		JOIN Person.Person P ON P.BusinessEntityID = BE.BusinessEntityID
	),
	ansCTE as
	(
		select *, NTILE(@N) over (order by city, LastName) as podzbior from wynikiCTE
	)
	insert into @ans (LastName, FirstName, email, city)
	select FirstName, LastName, EmailAddress, City from ansCTE
	where podzbior = @P
	return
end

select * from dbo.zad2(4, 4);