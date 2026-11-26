-- ### Task12 ### --

-- 12.1
CREATE TABLE AuditTable 
(
    [Id] INT NOT NULL,
    [OldPassingScore] DECIMAL(5,2) NOT NULL,
    [NewPassingScore] DECIMAL(5,2) NOT NULL,
    [ChangedAtUtc] DATETIME2(0) NOT NULL,
    [ChangedByUserId] BIGINT NOT NULL
);

-- RUN THE BELOW CODA AS A ONE BATCH
DECLARE @ChangedByUserId INT = 1;

UPDATE [academic].[Courses] 
SET 
	[PassingScore] = 65
OUTPUT
    INSERTED.[Id],
    DELETED.[PassingScore],
    INSERTED.[PassingScore],
    SYSUTCDATETIME(),
    @ChangedByUserId
INTO 
	AuditTable
(
    [Id],
    [OldPassingScore],
    [NewPassingScore],
    [ChangedAtUtc],
    [ChangedByUserId]
)
WHERE 
	[Code] = 'XC-075';

SELECT * FROM AuditTable;


-- 12.2
CREATE TABLE [communication].[AnnouncementsArchive]
(
    [Id] BIGINT NOT NULL,
    [SectionId] BIGINT NULL,
    [Title] NVARCHAR(200) NOT NULL,
    [Body] NVARCHAR(MAX) NOT NULL,
    [PublishedAtUtc] DATETIME2(0) NULL,
    [ExpiresAtUtc] DATETIME2(0) NULL,
    [CreatedByUserId] BIGINT NOT NULL,
    [CreatedAtUtc] DATETIME2(0) NOT NULL,
    [UpdatedAtUtc] DATETIME2(0) NOT NULL,
    [Status] TINYINT NOT NULL,
);

DELETE FROM [communication].[Announcements]
OUTPUT
    deleted.[Id],
    deleted.[SectionId],
    deleted.[Title],
    deleted.[Body],
    deleted.[PublishedAtUtc],
    deleted.[ExpiresAtUtc],
    deleted.[CreatedByUserId],
    deleted.[CreatedAtUtc],
    deleted.[UpdatedAtUtc],
    deleted.[Status]
INTO [communication].[AnnouncementsArchive]
(
    [Id],
    [SectionId],
    [Title],
    [Body],
    [PublishedAtUtc],
    [ExpiresAtUtc],
    [CreatedByUserId],
    [CreatedAtUtc],
    [UpdatedAtUtc],
    [Status]
)
WHERE [ExpiresAtUtc] < DATEADD(MONTH, -6, SYSUTCDATETIME());

SELECT * FROM [communication].[AnnouncementsArchive]