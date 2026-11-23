USE LmsTrainingLab;
GO

-- ### TASK 1 ### --
-- 1.1
SELECT 
	[StudentId], 
	[TotalAmount], 
	[PaidAmount], 
	[TotalAmount] - [PaidAmount] AS [Paid Amount left],
	DATEDIFF(DAY, [DueAtUtc], SYSUTCDATETIME()) AS [Due Days]
FROM [finance].[Invoices]
WHERE [TotalAmount] != [PaidAmount];


-- 1.2
SELECT 
	[Id], 
	[InvoiceNumber],
	[TotalAmount], 
	[PaidAmount], 
	[TotalAmount] - [PaidAmount] AS [Paid Amount left],
	DATEDIFF(DAY, [DueAtUtc], SYSUTCDATETIME()) AS [Due Days]
FROM [finance].[Invoices]
WHERE [TotalAmount] != [PaidAmount] 
	AND (((DATEDIFF(DAY, [DueAtUtc], SYSUTCDATETIME()) / 30) >= 2) OR ([TotalAmount] - [PaidAmount]) > 10000);

-- 1.3
SELECT 
	[Id], 
	[InvoiceNumber],
	[TotalAmount], 
	[PaidAmount], 
	[TotalAmount] - [PaidAmount] AS [Paid Amount left],
	DATEDIFF(DAY, [DueAtUtc], SYSUTCDATETIME()) AS [Due Days]
FROM [finance].[Invoices]
WHERE [TotalAmount] != [PaidAmount] 
	AND (((DATEDIFF(DAY, [DueAtUtc], SYSUTCDATETIME()) / 30) >= 2) OR ([TotalAmount] - [PaidAmount]) > 10000)
ORDER BY [Paid Amount left] DESC, [Due Days] DESC;
