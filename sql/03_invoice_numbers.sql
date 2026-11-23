USE LmsTrainingLab;
GO

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