use AdventureWorks2008;
go

CREATE VIEW rndView
AS
SELECT RAND() rndResult;

create function dbo.zad5( @min int, @max int)
returns date 
as
begin
	declare @rand int
	select @rand = FLOOR( (select * from rndView)*(@max - @min + 1) + @min)
	return DATEADD( day, @rand, cast( GETDATE() as date))
end
go


select dbo.zad5(-10,10);
