use AdventureWorks2008;
go

CREATE TABLE Vlab.Employee
(
	ID integer NOT NULL IDENTITY(1, 1) ,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Email VARCHAR(50),
	AddressLine VARCHAR(51),
	Salary MONEY,
	ModifyDate datetime,
	CONSTRAINT [PK_Vlab.Employee_ID] PRIMARY KEY CLUSTERED
		( [ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE OR ALTER TRIGGER [Vlab].[zad1] ON [Vlab].[Employee]
FOR INSERT, UPDATE NOT FOR REPLICATION AS
BEGIN
	DECLARE @Count int;
	SET @Count = @@ROWCOUNT;
	IF @Count = 0
		RETURN;
	SET NOCOUNT ON;
	BEGIN TRY
		IF UPDATE([Salary])
		BEGIN
			DECLARE @val int;
			SET @val = (SELECT Salary FROM deleted WHERE deleted.ID IN (SELECT inserted.[ID] FROM inserted) )
			UPDATE [Vlab].[Employee]
			SET Salary = 
			(
				CASE 
				WHEN inserted.Salary >= 10 AND inserted.Salary > @val THEN inserted.Salary 
				WHEN inserted.Salary >= 10 AND @val IS NULL THEN inserted.Salary
				ELSE @val 
				END
			)
			FROM inserted
			WHERE [Vlab].[Employee].ID IN
			(SELECT inserted.[ID] FROM inserted)
			-- = inserted.ID ;
		END;
	END TRY
	
	BEGIN CATCH
	EXECUTE [dbo].[uspPrintError];
	-- Rollback
	IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION;
		END
	EXECUTE [dbo].[uspLogError];
	END CATCH;
END;

UPDATE Vlab.Employee
SET Salary = 22
WHERE ID = 1;
select * from Vlab.Employee;


insert into Vlab.Employee (FirstName, LastName, Email, AddressLine, Salary, ModifyDate) values ('Kim', 'Sam', 'email@email.com', NULL, 9, NULL);
select * from Vlab.Employee;