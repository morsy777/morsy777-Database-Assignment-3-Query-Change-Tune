-- I initially struggled to understand this task, so honestly I used GPT to clarify the concept.
-- I learned that Data Synchronization keeps the website catalog consistent with the source data.
-- I used merge to insert new active courses, update modified courses, and hide inactive ones.
-- I also tested the synchronization to make sure that running it again without new changes does not modify anything.

-- 1
CREATE SCHEMA [website];
GO

CREATE TABLE [website].[Courses]
(
    [CourseId] INT NOT NULL PRIMARY KEY,
    [Code] VARCHAR(30) NOT NULL,
    [Title] NVARCHAR(200) NOT NULL,
    [CreditHours] DECIMAL(4,2) NOT NULL,
    [IsVisible] BIT NOT NULL DEFAULT (1)
);
GO

-- 2
MERGE [website].[Courses] AS Target
USING [academic].[Courses] AS Source
    ON Target.[CourseId] = Source.[Id]

WHEN MATCHED AND
(
    Target.[Code] != Source.[Code] OR 
	Target.[Title] != Source.[Title] OR 
	Target.[CreditHours] != Source.[CreditHours] OR
	Target.[IsVisible] != Source.[IsActive]
)
THEN
    UPDATE SET
        Target.[Code] = Source.[Code],
        Target.[Title] = Source.[Title],
        Target.[CreditHours] = Source.[CreditHours],
        Target.[IsVisible] = Source.[IsActive]

WHEN NOT MATCHED BY TARGET -- when there is active course added to the source ([academic].[Courses]) and doesn't exist in the website then add it.
    AND Source.[IsActive] = 1
THEN
    INSERT
    (
        [CourseId],
        [Code],
        [Title],
        [CreditHours],
        [IsVisible]
    )
    VALUES
    (
        Source.[Id],
        Source.[Code],
        Source.[Title],
        Source.[CreditHours],
        1
    )

OUTPUT
    $action AS [Action], -- $action is the type of op (insert, update or delete)
    INSERTED.[CourseId],
    DELETED.[Title] AS [OldTitle],
    INSERTED.[Title] AS [NewTitle],
    DELETED.[IsVisible] AS [OldVisibility],
    INSERTED.[IsVisible] AS [NewVisibility];

-- 3
-- Insert one course
INSERT INTO [academic].[Courses]
    ([DepartmentId], [Code], [Title], [CreditHours], [PassingScore], [IsActive])
VALUES
    (3, 'DSAI-102', 'Introduction to Machine Learning', 3, 60, 1);

-- Rename one course
UPDATE [academic].[Courses]
SET [Title] = 'Advanced Data Analysis'
WHERE [Code] = 'DSAI-102';

-- Deactivate another course
-- Replace the code with an existing active course code
UPDATE [academic].[Courses]
SET [IsActive] = 0
WHERE [Code] = 'DSAI-102';

SELECT *
FROM [website].[Courses]
WHERE [Code] = 'DSAI-102';