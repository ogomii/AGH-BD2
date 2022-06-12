use AdventureWorks2008;
go

select XML_SCHEMA_NAMESPACE(N'Person', N'IndividualSurveySchemaCollection');

--zad 1
select FirstName, LastName, Demographics.value(' declare default element namespace 
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";(/IndividualSurvey/YearlyIncome)[1][. > "0"][. < "5000"]','varchar(250)')
as YearlyIncome
from Person.Person
order by 3 DESC

--zad 2
select FirstName, LastName, Demographics.value(' declare default element namespace 
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";(/IndividualSurvey/NumberChildrenAtHome)[1]','int')
- Demographics.value(' declare default element namespace 
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";(/IndividualSurvey/TotalChildren)[1][. > 0]','int')
as diff
from Person.Person
order by 3 DESC

--zad 3
select XML_SCHEMA_NAMESPACE(N'HumanResources', N'HRResumeSchemaCollection');

select Resume.query(' declare default element namespace
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume";
for $p in /Resume/Address/Addr.Telephone
let $name := /Resume/Name/Name.Last
let $city := /Resume/Address/Addr.Location/Location/Loc.City
let $street := /Resume/Address/Addr.Street

return
<person xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume">
<Name>{data($name)}</Name>
<City>{data($city)}</City>
<Street>{data($street)}</Street>
</person>
')
from HumanResources.JobCandidate