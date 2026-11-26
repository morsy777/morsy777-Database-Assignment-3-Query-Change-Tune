## Task 10:
### The CTO asks: "When should we use numbers and when should we use GUIDs for ids?" Answer with the trade-offs.
When deciding between using numbers (typically integers) and GUIDs (Globally Unique Identifiers) for IDs, there are several trade-offs to consider:
1. **Uniqueness**:
   - **Numbers**: Sequential integers are unique within a single database but can lead to conflicts when merging data from different sources.
   - **GUIDs**: Provide global uniqueness, making them suitable for distributed systems where data may come from multiple sources.
2. **Performance**:
   - **Numbers**: Generally faster for indexing and lookups due to their smaller size and sequential nature, which can lead to better cache performance.
   - **GUIDs**: Larger in size (16 bytes) and can lead to fragmentation in indexes, which may degrade performance over time, especially for large datasets.
3. **Storage**:
   - **Numbers**: Require less storage space (typically 4 bytes for an integer), making them more efficient for large tables.
   - **GUIDs**: Require more storage space (16 bytes), which can increase the overall size of the database and impact performance.
4. **Readability**:
   - **Numbers**: Easier to read and understand, especially for debugging and logging purposes.
   - **GUIDs**: Less human-readable due to their length and complexity, which can make debugging more challenging.
5. **Security**:
   - **Numbers**: Can be predictable, potentially exposing information about the system or data structure.
   - **GUIDs**: More secure as they are harder to guess, providing better protection against certain types of attacks.