USE LmsTrainingLab;
GO

-- ### Task 5 ### --
-- 5.1
SELECT 
    [Code] AS [Course Code],
    [Title] AS [Course Title],
    [CreditHours] AS [Credits]
FROM 
	[academic].[Courses]
ORDER BY [CreditHours] DESC, [Code] ASC;


-- 5.2
SELECT 
	TOP 5 * -- * IS BAD AS A PERFORMANCE WISE
FROM [identity].[StudentProfiles]


-- 5.3
SELECT 
	[Email]
FROM 
	[identity].[Users]
WHERE DATALENGTH([Email]) != DATALENGTH(TRIM([Email]))
	AND [LastLoginAtUtc] IS NULL;


-- 5.4
SELECT 
	[Email]
FROM 
	[identity].[Users]
WHERE LOWER([Email]) != [Email]


-- 5.5
SELECT 
	[Email]
FROM 
	[identity].[Users]
WHERE [Email] NOT LIKE '%@%' OR
	  [Email] LIKE '@%'	OR
	  [Email] NOT LIKE '%@%.%';


-- 5.6
SELECT 
	DISTINCT SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email])) AS [Email Providers]
FROM 
	[identity].[Users]
ORDER BY [Email Providers]

-- 5.7
-- JUST TO PERFORM CUSTOM SORTING
-- USING CASE MEANS IF [LastLoginAtUtc] IS NOT NULL,
-- THEN DISPLAY IT FIRST.
SELECT 
	[LastLoginAtUtc]
FROM 
	[identity].[Users]
ORDER BY 
	CASE 
		WHEN [LastLoginAtUtc] IS NULL THEN 1 ELSE 0 
	END ASC, 
[LastLoginAtUtc] DESC


-- 5.8
SELECT 
	[PaidAtUtc],
	CASE 
		WHEN [PaidAtUtc] < '2026-10-31' THEN 'RECIEVED'
		WHEN [PaidAtUtc] > '2026-10-31' AND [PaidAtUtc] < '2026-11-1' THEN 'LATE'
		ELSE 'N/A'
	END AS [Payments Recieved]
FROM [finance].[Payments]

-- JUST TO TEST THE PREVIOUS QUERY
SELECT 
	[PaidAtUtc]
FROM 
	[finance].[Payments]
WHERE 
	[PaidAtUtc] >= '2026-10-31' AND [PaidAtUtc] < '2026-11-1'

-- 5.9
SELECT 
	[PaidAtUtc] AT TIME ZONE 'UTC'
				AT TIME ZONE 'Egypt Standard Time' AS [PaidAtCairo]
FROM 
	[finance].[Payments]
WHERE 
	CAST([PaidAtUtc] AT TIME ZONE 'UTC' AT TIME ZONE 'Egypt Standard Time' AS [TIME]) >= '00:00:00' AND
	CAST([PaidAtUtc] AT TIME ZONE 'UTC' AT TIME ZONE 'Egypt Standard Time' AS [TIME]) < '05:00:00'

-- 5.10
SELECT 
	[Id],
	[SectionId],
	[SessionDate],
	DATENAME(WEEKDAY, [SessionDate]) AS [Day]
FROM 
	[attendance].[AttendanceSessions]
WHERE 
	DATENAME(WEEKDAY, [SessionDate]) = 'Friday';

-- 5.11
SELECT 
	[PhoneNumber]
FROM
	[identity].[Users]
WHERE 
	[PhoneNumber] LIKE '+201[0125][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';


-- 5.12
SELECT 
	LEFT([PhoneNumber], 5) + 
	REPLICATE('*', LEN([PhoneNumber]) - 7) +
	RIGHT([PhoneNumber], 2)
FROM
	[identity].[Users]
WHERE 
	[PhoneNumber] LIKE '+201[0125][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';


-- 5.13
SELECT
	[InvoiceNumber],
	RIGHT([InvoiceNumber], CHARINDEX('-', REVERSE([InvoiceNumber])) - 1) AS [RunningNumber]
FROM
	[finance].[Invoices]
ORDER BY [RunningNumber];

-- 5.14
SELECT 
	CONCAT([EstimatedMinutes] / 60, 'h', ' ', [EstimatedMinutes] % 60, 'min') [Duration]
FROM 
	[content].[Lessons]
WHERE 
	EstimatedMinutes IS NOT NULL

-- 5.15
SELECT *
FROM 
	[communication].[Announcements] 
WHERE 
	[Body] LIKE '%[%]%';


-- 5.16
SELECT TOP 5 WITH TIES
	[InvoiceNumber], [TotalAmount]
FROM 
	[finance].[Invoices]
ORDER BY [TotalAmount] DESC


-- 5.17
SELECT TOP 10 PERCENT
	[InvoiceNumber], [TotalAmount]
FROM 
	[finance].[Invoices]
ORDER BY [TotalAmount] DESC


-- 5.18
SELECT 
	[Location]
FROM
	[delivery].[Sections]
WHERE [Location] != 'Hall A' OR [Location] IS NULL;

-- 5.19
-- ALHUMDULEALLAH I SOLVED IT ENTIRELY ON MY OWN, WITHOUT AI TOOLS, THEN I REVIEWD MY ANSWER 
SELECT 
	[TotalAmount],
	[PaidAmount],
	CASE
		WHEN [PaidAmount] = 0.00 THEN 'not paid'
		WHEN [PaidAmount] < [TotalAmount] THEN 'partially paid'
	END AS [Payment Status],
	CASE
		WHEN [DueAtUtc] <= DATEADD(MONTH, -2, SYSUTCDATETIME()) THEN 'overdue'
		ELSE 'not over due'
	END AS [Due],
	CAST([PaidAmount] * 100.0 / NULLIF([TotalAmount], 0) AS DECIMAL(10,1)) AS [Paid Percentage]
FROM
	[finance].[Invoices]
WHERE [PaidAmount] < [TotalAmount]
ORDER BY ([TotalAmount] - [PaidAmount]) DESC;


SELECT 
	[TotalAmount], [PaidAmount]
FROM
	[finance].[Invoices]
WHERE [PaidAmount] < [TotalAmount];

-- 5.20


-- 5.21


-- 5.22


-- 5.23


-- 5.24







