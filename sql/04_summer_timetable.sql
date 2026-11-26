USE LmsTrainingLab;
GO

-- ### TASK 4 ### --
-- most recent term id is (12)
-- term id that we added is (14)

SELECT *
FROM [delivery].[Sections]
WHERE TermId = 12

INSERT INTO [delivery].[Sections] 
	([CourseId], [TermId], [SectionCode], [Capacity], [Location])
SELECT 
	[CourseId], 
	14 AS [TermId], 
	[SectionCode], 
	[Capacity], 
	[Location]
FROM [delivery].[Sections]
WHERE TermId = 12

SELECT *
FROM [delivery].[Sections]
WHERE [TermId] = 14;