SET STATISTICS IO ON
SET STATISTICS TIME ON;

SELECT TOP (15)
       i.InvoiceNumber,
       sp.StudentNumber,
       i.TotalAmount - i.PaidAmount AS Remaining,
CASE WHEN i.DueAtUtc < DATEADD(DAY, -60, SYSUTCDATETIME()) THEN 'Urgent' ELSE 'Normal' END 
AS Urgency
FROM finance.Invoices AS i
INNER JOIN [identity].[StudentProfiles] AS sp ON sp.Id = i.StudentId
WHERE i.PaidAmount < i.TotalAmount
AND i.DueAtUtc < SYSUTCDATETIME()
ORDER BY Remaining DESC;

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF
/*
* First Operator I think is Scan if there is no index on PaidAmount
* Second Operator is Sort 
* Third Operator is Nested Loop for inner join
*	SQL Server Execution Times:
*   CPU time = 31 ms,  elapsed time = 12 ms.
*/