USE LmsTrainingLab;
GO

-- ### Task 5 ### --
-- 5.1
SELECT 
    [Code] AS [Course Code],
    [Title] AS [Course Title],
    [CreditHours] AS [Credits]
FROM [academic].[Courses]
ORDER BY [CreditHours] DESC, [Code] ASC;


-- 5.2
SELECT 
	TOP 5 * -- * IS BAD AS A PERFORMANCE WISE
FROM [identity].[StudentProfiles]


-- 5.3
SELECT 
	[Email]
FROM [identity].[Users]
WHERE DATALENGTH([Email]) != DATALENGTH(TRIM([Email]))
	AND [LastLoginAtUtc] IS NULL;


-- 5.4
SELECT 
	[Email]
FROM [identity].[Users]
WHERE LOWER([Email]) != [Email]


-- 5.5
SELECT 
	[Email]
FROM [identity].[Users]
WHERE [Email] NOT LIKE '%@%' OR
	  [Email] LIKE '@%'	OR
	  [Email] NOT LIKE '%@%.%';


-- 5.6
SELECT 
	DISTINCT SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email])) AS [Email Providers]
FROM [identity].[Users]
ORDER BY [Email Providers]

-- 5.7
-- JUST TO PERFORM CUSTOM SORTING
-- USING CASE MEANS IF [LastLoginAtUtc] IS NOT NULL,
-- THEN DISPLAY IT FIRST.
SELECT [LastLoginAtUtc]
FROM [identity].[Users]
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
SELECT [PaidAtUtc]
FROM [finance].[Payments]
WHERE [PaidAtUtc] >= '2026-10-31' AND [PaidAtUtc] < '2026-11-1'

-- 5.9
SELECT 
	[PaidAtUtc] AT TIME ZONE 'UTC'
				AT TIME ZONE 'Egypt Standard Time' AS [PaidAtCairo]
FROM [finance].[Payments]
WHERE CAST([PaidAtUtc] AT TIME ZONE 'UTC' AT TIME ZONE 'Egypt Standard Time' AS [TIME]) >= '00:00:00' AND
	  CAST([PaidAtUtc] AT TIME ZONE 'UTC' AT TIME ZONE 'Egypt Standard Time' AS [TIME]) < '05:00:00'

-- 5.10
SELECT [Id], [SectionId], [SessionDate], DATENAME(WEEKDAY, [SessionDate]) AS [Day]
FROM [attendance].[AttendanceSessions]
WHERE DATENAME(WEEKDAY, [SessionDate]) = 'Friday';


-- 5.11



-- 5.12



-- 5.13










