- SELECT DISTINCT TotalAmount FROM finance.Invoices scans the
clustered index, then uses Hash Match (Aggregate) to build hash
groups and return one row per distinct amount (88 rows from
146,800).

- SQL Server could use the cheaper Stream Aggregate, which reads
rows in order and outputs one row when the value changes.

- A Stream Aggregate needs its input ordered by TotalAmount, an
index whose leading key is TotalAmount can provide that order
without an extra sort.

- SELECT Id FROM identity.Users returns the unique Id values using
a Nonclustered Index Scan on IX_Users_Status, no
duplicate-removal operator is needed because Id is already unique.