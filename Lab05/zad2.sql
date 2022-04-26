use AdventureWorks2008;
go;

SET NOCOUNT ON;

DECLARE @prodID INT, @nazwaProduktu NVARCHAR(50),
	@message VARCHAR(120), @cena NVARCHAR(10), @carrierNumber NVARCHAR(50), @orderDate NVARCHAR(20), @shipDate NVARCHAR(20);

PRINT '-------- Struktura AdventureWorks --------';

DECLARE zad2Cursor CURSOR FOR
SELECT ProductID, [Name]
FROM Production.Product 
ORDER BY [Name];

OPEN zad2Cursor

FETCH NEXT FROM zad2Cursor
INTO @prodID, @nazwaProduktu

WHILE @@FETCH_STATUS = 0
BEGIN
	 PRINT ' '
	 SELECT @message = '----- Produkt: ' + @nazwaProduktu

	 PRINT @message

	 -- nested cursor

	 DECLARE fakturaCursor CURSOR FOR
	 SELECT CONVERT(NVARCHAR, detail.UnitPrice) AS UnitPrice, CONVERT(NVARCHAR,detail.CarrierTrackingNumber), CONVERT(NVARCHAR,header.OrderDate), CONVERT(NVARCHAR,header.ShipDate)
	 FROM Sales.SalesOrderDetail detail
	 JOIN sales.SalesOrderHeader header on detail.SalesOrderID = header.SalesOrderID
	 WHERE detail.ProductID = @prodID

	 OPEN fakturaCursor
	 FETCH NEXT FROM fakturaCursor INTO @cena, @carrierNumber, @orderDate, @shipDate

	 IF @@FETCH_STATUS <> 0
	 PRINT ' <<Brak produktow>>'

	 WHILE @@FETCH_STATUS = 0
	 BEGIN

		 SELECT @message = 'Cena: ' + @cena + ' Kurier: ' + @carrierNumber + ' Data zakupu: ' + @orderDate + ' Data wyslania: ' + @shipDate
		 IF @message is not NULL
			PRINT @message
		 FETCH NEXT FROM fakturaCursor INTO @cena, @carrierNumber, @orderDate, @shipDate
	 END

	 CLOSE fakturaCursor
	 DEALLOCATE fakturaCursor
		-- next dept.
	 FETCH NEXT FROM zad2Cursor
	 INTO @prodID, @nazwaProduktu
END
CLOSE zad2Cursor;
DEALLOCATE  zad2Cursor;
go