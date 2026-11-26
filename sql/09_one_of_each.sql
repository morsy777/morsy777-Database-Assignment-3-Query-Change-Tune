SELECT DISTINCT 
	TotalAmount
FROM 
	finance.Invoices


-- I just wanna show if it use stream agg instead hashmatch
CREATE INDEX IX_Invoices_TotalAmount    
ON finance.Invoices (TotalAmount);

DROP INDEX IX_Invoices_TotalAmount
ON finance.Invoices;


SELECT DISTINCT 
	TotalAmount
FROM 
	finance.Invoices


SELECT DISTINCT 
	[Id]
FROM 
	[identity].[Users]