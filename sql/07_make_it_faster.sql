-- 7.1
-- users who registered in March 2026
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT Id, Email
FROM [identity].[Users]
WHERE YEAR(CreatedAtUtc) = 2026
AND MONTH(CreatedAtUtc) = 3;

SELECT Id, Email
FROM [identity].[Users]
WHERE CreatedAtUtc >= '2026-03-01' AND CreatedAtUtc < '2026-04-01'

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

CREATE INDEX IX_Users_CreatedAtUtc
ON [identity].[Users] (CreatedAtUtc)
INCLUDE (Email);

-- 7.2
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- payments of the last 30 days
SELECT Id, InvoiceId, Amount
FROM finance.Payments
WHERE DATEDIFF(DAY, PaidAtUtc,
               SYSUTCDATETIME()) <= 30;

SELECT Id, InvoiceId, Amount
FROM finance.Payments
WHERE PaidAtUtc >= DATEADD(DAY, -30, SYSUTCDATETIME())	AND PaidAtUtc <= SYSUTCDATETIME();

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

CREATE INDEX IX_Payments_PaidAtUtc 
ON finance.Payments (PaidAtUtc) 
INCLUDE (InvoiceId, Amount);

-- 7.3
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- last names starting with "Abd"
SELECT Id, FirstName, LastName
FROM [identity].[Users]
WHERE LEFT(LastName, 3) = N'Abd';

SELECT Id, FirstName, LastName
FROM [identity].[Users]
WHERE LastName like N'Abd%';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

CREATE INDEX IX_Users_LastName     
ON [identity].[Users] (LastName)     
INCLUDE (FirstName, Email);

-- 7.4
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT *
FROM operations.AuditLogs
WHERE Id + 1 = 50001;

SELECT *
FROM operations.AuditLogs
WHERE Id = 50000;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;


-- 7.5
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT Id, TotalAmount, PaidAmount
FROM finance.Invoices
WHERE InvoiceNumber
      = N'LAB-INV-2026-00001';

-- The N prefix forces SQL to convert the column value for each row, which may result in an index scan.
SELECT Id, TotalAmount, PaidAmount
FROM finance.Invoices
WHERE InvoiceNumber
      = 'LAB-INV-2026-00001';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

CREATE INDEX IX_Invoices_Number    
ON finance.Invoices (InvoiceNumber);


-- 7.6
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- login screen
DECLARE @Email NVARCHAR(320) = N'...';
SELECT Id, FirstName, LastName
FROM [identity].[Users]
WHERE UPPER(Email) = UPPER(@Email);


SELECT Id, FirstName, LastName
FROM [identity].[Users]
WHERE Email = @Email;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

CREATE INDEX IX_Users_Email        
ON [identity].[Users] (Email)        
INCLUDE (FirstName, LastName);

SELECT DATABASEPROPERTYEX(DB_NAME(), 'Collation') AS DatabaseCollation; -- its SQL_Latin1_General_CP1_CI_AS which means insensetive


-- 7.7
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- search screen: NULL when the box is empty
DECLARE @LastName NVARCHAR(100) = N'Hassan';
SELECT Id, FirstName, Email
FROM [identity].[Users]
WHERE (@LastName IS NULL
OR LastName = @LastName);

SELECT Id, FirstName, Email
FROM [identity].[Users]
WHERE (@LastName IS NULL OR LastName = @LastName)
OPTION (RECOMPILE);

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

-- 7.8
-- 7.1, 7.2, 7.3 and 7.6 -> all of them cause the same problem

-- 7.1 slow & faster
SELECT Id, Email
FROM [identity].[Users]
WHERE YEAR(CreatedAtUtc) = 2026
AND MONTH(CreatedAtUtc) = 3;

SELECT Id, Email
FROM [identity].[Users]
WHERE CreatedAtUtc >= '2026-03-01' AND CreatedAtUtc < '2026-04-01'



-- 7.2 slow & faster
SELECT Id, InvoiceId, Amount
FROM finance.Payments
WHERE DATEDIFF(DAY, PaidAtUtc,
               SYSUTCDATETIME()) <= 30;

SELECT Id, InvoiceId, Amount
FROM finance.Payments
WHERE PaidAtUtc >= DATEADD(DAY, -30, SYSUTCDATETIME())	AND PaidAtUtc <= SYSUTCDATETIME();



-- 7.3 slow & faster
SELECT Id, FirstName, LastName
FROM [identity].[Users]
WHERE LEFT(LastName, 3) = N'Abd';

SELECT Id, FirstName, LastName
FROM [identity].[Users]
WHERE LastName like N'Abd%';


-- 7.6 slow & faster
SELECT Id, FirstName, LastName
FROM [identity].[Users]
WHERE UPPER(Email) = UPPER(@Email);


SELECT Id, FirstName, LastName
FROM [identity].[Users]
WHERE Email = @Email;















