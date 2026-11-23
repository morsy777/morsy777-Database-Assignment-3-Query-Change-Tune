USE LmsTrainingLab;
GO

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