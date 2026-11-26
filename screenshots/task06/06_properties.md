##  1 Properties:
### Physical Operation: it descripe how the system works.
### Logical Operation: it describes how the system is *designed* to work.
### Actual Execution Mode: it describes how the system is *actually* working.
### Estimated Execution Mode: it describes how the system is *expected* to work.
### Storage: it describes how the system stores data.

### Actual Number of Rows Read: it describes how many rows the system actually read during execution.
### Actual Number of Rows for All Executions: it describes how many rows the system actually read during all executions.
### Estimated Number of Rows to be Read: it describes how many rows the system is expected to read during execution.
### Estimated Number of Rows for All Executions: it describes how many rows the system is expected to read during all executions.
### Estimated Row Size: it describes how many bytes the system is expected to read for each row during execution.

### Number of Executions: it describes how many times the system is expected to execute the operation.
### Estimated Number of Executions: it describes how many times the system is expected to execute the operation.  

### Acutal Rebind: it describes how many times the system actually rebinds the operation during execution.
### Actual Rewind: it describes how many times the system actually rewinds the operation during execution.

### Estimated I/O Cost: it describes how many I/O operations the system is expected to perform during execution.
### Estimated CPU Cost: it describes how many CPU operations the system is expected to perform during execution.
### Estimated Operator Cost: it describes how many operations the system is expected to perform during execution.
### Estimated Subtree Cost: it describes how many operations the system is expected to perform during execution for the entire subtree of operations.

## 2. Operators:
### Clustered Index Scan: it describes how the system scans a clustered index to retrieve data.
### Clustered Index Seek: it describes how the system seeks a clustered index to retrieve data.
### Compute Scalar: it describes how the system computes a scalar value.
### Sort: it describes how the system sorts data.
### Nested Loops: it describes how the system performs a nested loop join between two sets of data (tables).
### Parallelism: it describes how the system performs operations in parallel to improve performance.