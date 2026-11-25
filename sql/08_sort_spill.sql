
SELECT *
FROM finance.Invoices
ORDER BY TotalAmount DESC;

/*
 why it happened?
	This warning happen because memeory planed too small so the sql finishes the sort in tempdb

what the spill level means, and why it is slow?
	The spill level is 1, a spill level happens when a SQL Server doesn't have enough memory to complete the sor
	in memory. so it uses tempdb.
	Its slow because it introduces an additional I/O operation, that's why query is slow
*/