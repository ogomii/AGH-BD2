use AdventureWorks2008;
go


create role [DeptA] authorization [dbo]
go
create role [DeptB] authorization [dbo]
go


GRANT SELECT, DELETE, INSERT, UPDATE ON [Vlab].[Employee] TO [DeptB] WITH GRANT OPTION
GO
REVOKE INSERT ON [Vlab].[Employee] TO [DeptB] CASCADE
GO

GRANT SELECT ON [Vlab].[Employee] TO [DeptA] WITH GRANT OPTION
GO


USE [master]
GO
CREATE LOGIN [MSSQLSERVER\db2labA] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks2008]
GO
USE [AdventureWorks2008]
GO
CREATE USER [MSSQLSERVER\db2labA] FOR LOGIN [MSSQLSERVER\db2labA]
GO
USE [master]
GO
CREATE LOGIN [MSSQLSERVER\db2labB] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks2008]
GO
USE [AdventureWorks2008]
GO
CREATE USER [MSSQLSERVER\db2labB] FOR LOGIN [MSSQLSERVER\db2labB]
GO
USE [master]
GO
CREATE LOGIN [MSSQLSERVER\db2labC] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks2008]
GO
USE [AdventureWorks2008]
GO
CREATE USER [MSSQLSERVER\db2labC] FOR LOGIN [MSSQLSERVER\db2labC]
GO

USE [master]
GO
CREATE LOGIN [MSSQLSERVER\db2labD] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks2008]
GO
USE [AdventureWorks2008]
GO
CREATE USER [MSSQLSERVER\db2labD] FOR LOGIN [MSSQLSERVER\db2labD]
GO


USE [AdventureWorks2008]
GO
EXEC sp_addrolemember 'DeptA', 'MSSQLSERVER\db2labD'
GO
EXEC sp_addrolemember 'DeptB', 'MSSQLSERVER\db2labD'
GO
EXEC sp_addrolemember 'DeptA', 'MSSQLSERVER\db2labA'
GO
EXEC sp_addrolemember 'DeptA', 'MSSQLSERVER\db2labB'
GO
EXEC sp_addrolemember 'DeptA', 'MSSQLSERVER\db2labC'
GO
EXEC sp_addrolemember 'DeptB', 'MSSQLSERVER\db2labC'
GO

GRANT INSERT ON [Vlab].[Employee] TO [MSSQLSERVER\db2labD]
GO


SELECT db2users.[name] As Username
, db2users.[type] AS [User Type]
, db2users.type_desc AS [Type description]
, db2perm.permission_name AS [Permission]
, db2perm.state_desc AS [Permission State]
, db2perm.class_desc Class
, object_name(db2perm.major_id) AS [Object Name]
FROM sys.database_principals db2users
LEFT JOIN
sys.database_permissions db2perm
ON db2perm.grantee_principal_id = db2users.principal_id
WHERE db2users.name IN ( 'MSSQLSERVER\db2labD', 'MSSQLSERVER\db2labA', 'MSSQLSERVER\db2labB', 'MSSQLSERVER\db2labC')
EXEC sp_table_privileges
@table_name = 'Employee';
PRINT(HAS_DBACCESS('AdventureWorks2012'))


EXECUTE AS USER='MSSQLSERVER\db2labD'
SELECT IS_MEMBER('DeptB');

--odmowa 
EXECUTE AS USER= 'MSSQLSERVER\db2labA' --czlonek DeptA (posiada tylko SELECT)
INSERT INTO [Vlab].[Employee] (FirstName, LastName) values ('Imie', 'Nazwisko');

EXECUTE AS USER= 'MSSQLSERVER\db2labA' --czlonek DeptA (posiada tylko SELECT)
DELETE FROM [Vlab].[Employee] WHERE ID = 2;

EXECUTE AS USER= 'MSSQLSERVER\db2labB' --czlonek DeptA (posiada tylko SELECT)
INSERT INTO [Vlab].[Employee] (FirstName, LastName) values ('Imie', 'Nazwisko');

EXECUTE AS USER= 'MSSQLSERVER\db2labB' --czlonek DeptA (posiada tylko SELECT)
DELETE FROM [Vlab].[Employee] WHERE ID = 2;

EXECUTE AS USER= 'MSSQLSERVER\db2labC' --czlonek DeptA (posiada tylko SELECT) oraz DeptB (posiada SELECT, UPDATE, DELETE)
INSERT INTO [Vlab].[Employee] (FirstName, LastName) values ('Imie', 'Nazwisko');


--sukces
EXECUTE AS USER= 'MSSQLSERVER\db2labA' --czlonek DeptA (posiada tylko SELECT)
SELECT * FROM [Vlab].[Employee];

EXECUTE AS USER= 'MSSQLSERVER\db2labB' --czlonek DeptA (posiada tylko SELECT)
SELECT * FROM [Vlab].[Employee];

EXECUTE AS USER= 'MSSQLSERVER\db2labC' --czlonek DeptA (posiada tylko SELECT) oraz DeptB (posiada SELECT, UPDATE, DELETE)
SELECT * FROM [Vlab].[Employee];

EXECUTE AS USER= 'MSSQLSERVER\db2labC' --czlonek DeptA (posiada tylko SELECT) oraz DeptB (posiada SELECT, UPDATE, DELETE)
DELETE FROM [Vlab].[Employee] WHERE ID = 2;

EXECUTE AS USER= 'MSSQLSERVER\db2labD' --czlonek DeptA (posiada tylko SELECT) oraz DeptB (posiada SELECT, UPDATE, DELETE)
UPDATE [Vlab].[Employee] SET FirstName = 'ImieImie' WHERE ID = 2;

EXECUTE AS USER= 'MSSQLSERVER\db2labD' --czlonek DeptA (posiada tylko SELECT) oraz DeptB (posiada SELECT, UPDATE, DELETE) + INSERT
SELECT * FROM [Vlab].[Employee];

EXECUTE AS USER= 'MSSQLSERVER\db2labD' --czlonek DeptA (posiada tylko SELECT) oraz DeptB (posiada SELECT, UPDATE, DELETE) + INSERT
DELETE FROM [Vlab].[Employee] WHERE ID = 2;

EXECUTE AS USER= 'MSSQLSERVER\db2labD' --czlonek DeptA (posiada tylko SELECT) oraz DeptB (posiada SELECT, UPDATE, DELETE) + INSERT
INSERT INTO [Vlab].[Employee] (FirstName, LastName) values ('Imie', 'Nazwisko');

EXECUTE AS USER= 'MSSQLSERVER\db2labD' --czlonek DeptA (posiada tylko SELECT) oraz DeptB (posiada SELECT, UPDATE, DELETE) + INSERT
UPDATE [Vlab].[Employee] SET FirstName = 'ImieImie' WHERE ID = 2;



