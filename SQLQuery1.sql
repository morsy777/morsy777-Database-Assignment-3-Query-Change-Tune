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


-- ### TASK 2 ### --
-- 2.1
INSERT INTO [academic].[Departments] 
	([Code], [Name])
VALUES 
	('DSAI', ' Data Science & Artificial Intelligence');

SELECT *
FROM [academic].[Departments]
WHERE [Code] = 'DSAI';

-- 2.2
INSERT INTO [academic].[Courses]
    ([DepartmentId], [Code], [Title], [CreditHours], [PassingScore])
VALUES
    (18, 'DSAI-101', 'Introduction to Data Analysis', 3, 60);

SELECT *
FROM [academic].[Courses]
WHERE [Code] = 'DSAI-101';

-- 2.3
INSERT INTO [delivery].[AcademicTerms]
    ([AcademicYear], [Name], [TermCode], [StartDate], [EndDate], [RegistrationStartDate], [RegistrationEndDate])
VALUES
    ('2027', 'Summer 2027', 'Summer', '2027-06-15', '2027-08-31', '2027-05-01', '2027-06-10');

-- 2.4
INSERT INTO [communication].[Announcements]
    ([Title], [Body], [PublishedAtUtc], [CreatedByUserId])
VALUES
    (
        'Summer 2027 Registration',
        'Summer 2027 registration opens on 1 May 2027. All students are welcome to register during the registration period.',
        '2027-05-01',
		1 -- I TAKE IT FROM THIS TABLE'S DATA
    );

-- 2.5
INSERT INTO [identity].[Roles]
	([Code], [Name])
VALUES
	('TEACHING ASSISTANT' , 'Teaching Assistant');


-- ### TASK 3 ### --
-- 3.1
CREATE SEQUENCE [finance].[InvoiceNo]
	AS INT START WITH 1 INCREMENT BY 1;

-- 3.2
SELECT * 
FROM [identity].[StudentProfiles] -- 1

SELECT * 
FROM [delivery].[AcademicTerms] -- 14

INSERT INTO [finance].[Invoices]
	([InvoiceNumber], [StudentId], [TermId], [DueAtUtc], [TotalAmount])
VALUES 
	(
		CONCAT('LAB-INV-2026-', FORMAT(NEXT VALUE FOR [finance].[InvoiceNo], '00000')),
		1,
		14,
		DATEADD(DAY, 30, SYSDATETIME()), 
		4500
	);


-- 3.3
SELECT NEXT VALUE FOR [finance].[InvoiceNo]; -- output = 2
-- This number is reserved and will never be used in any other transactions
