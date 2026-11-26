--### Task 11 ###--

-- 11.1
UPDATE [academic].[Courses]
SET [PassingScore] = 65
WHERE [Code] LIKE 'DSAI-%';

SELECT 
	[Code],
	[Title], 
	[PassingScore]
FROM 
	[academic].[Courses]
WHERE [Code] LIKE 'DSAI-%';


-- 11.2
UPDATE E
SET E.[FinalGrade] =
    CASE
        WHEN E.[FinalScore] >= 90 THEN 'A'
        WHEN E.[FinalScore] >= 80 THEN 'B'
        WHEN E.[FinalScore] >= 70 THEN 'C'
        WHEN E.[FinalScore] >= 60 THEN 'D'
        ELSE 'F'
    END
FROM 
	[delivery].[Enrollments] E
INNER JOIN 
	[ref].[EnrollmentStatuses] S
ON
	E.EnrollmentStatusId = S.Id
WHERE S.[Name] = 'Finished'
  AND E.[FinalScore] IS NOT NULL;

-- THERE IS NO STATUS IS FINISHED IN [ref].[EnrollmentStatuses], SO 0 ROWS AFFECTED

-- 11.3
DELETE FROM 
	[identity].[Roles]
WHERE [Code] = 'TEACHING ASSISTANT'

SELECT *
FROM 
	[identity].[Roles]
WHERE [Code] = 'TEACHING ASSISTANT'


-- 11.4
SELECT *
INTO #TEMP_TABLE
FROM [finance].[Payments]

SELECT * FROM #TEMP_TABLE

-- I take the table structure from "generate sql script to a [finance].[Payments] table"
CREATE TABLE [finance].[PaymentsStage](
	[Id] [bigint] NOT NULL,
	[InvoiceId] [bigint] NOT NULL,
	[PaymentMethodId] [tinyint] NOT NULL,
	[Amount] [decimal](12, 2) NOT NULL,
	[CurrencyCode] [char](3) NOT NULL,
	[ExternalReference] [nvarchar](200) NULL,
	[PaidAtUtc] [datetime2](0) NULL,
	[CreatedByUserId] [bigint] NOT NULL,
	[CreatedAtUtc] [datetime2](0) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[Kind] [tinyint] NOT NULL,
	[Status] [tinyint] NOT NULL,
) 

INSERT INTO 
	[finance].[PaymentsStage]
(
    [Id],
    [InvoiceId],
    [PaymentMethodId],
    [Amount],
    [CurrencyCode],
    [ExternalReference],
    [PaidAtUtc],
    [CreatedByUserId],
    [CreatedAtUtc],
    [Kind],
    [Status]
)
SELECT
    [Id],
    [InvoiceId],
    [PaymentMethodId],
    [Amount],
    [CurrencyCode],
    [ExternalReference],
    [PaidAtUtc],
    [CreatedByUserId],
    [CreatedAtUtc],
    [Kind],
    [Status]
FROM 
	[finance].[Payments];

SELECT * FROM [finance].[PaymentsStage];

TRUNCATE TABLE [finance].[PaymentsStage];

-- 11.5

--2.4
DELETE FROM [communication].[Announcements]
WHERE [Title] = 'Summer 2027 Registration'
  AND [CreatedByUserId] = 1;

-- 2.2 
DELETE FROM [academic].[Courses]
WHERE [Code] = 'DSAI-101';

-- 2.1
DELETE FROM [academic].[Departments]
WHERE [Code] = 'DSAI' AND [Name] = ' Data Science & Artificial Intelligence';
