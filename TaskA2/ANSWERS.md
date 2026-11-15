# A2 · Buffered attendance-log scanning

For 50 decimal MB, one-byte reads make 50,000,001 Java read calls including EOF. For 50 MiB, as used in the experiment, the count is 52,428,801. FileInputStream.read generally crosses the Java/native boundary for each byte. System caching reduces physical I/O yet leaves per-call overhead. With an 8,192-byte buffer and full reads, 50 MiB takes 6,400 data reads plus EOF. Short reads can increase the count.

```text
ALGORITHM CountLines(input)
    SET lines ← 0 and sawBytes ← false
    WHILE reading into fixed byte buffer returns positive count DO
        FOR index FROM 0 TO count - 1 DO
            IF byte[index] equals LF THEN lines ← lines + 1
            last ← byte[index]
            sawBytes ← true
        END FOR
    END WHILE
    IF sawBytes AND last differs from LF THEN lines ← lines + 1
    RETURN lines
END ALGORITHM
```

This counts LF, including CRLF logs, and includes a final unterminated line. Empty input returns zero. Buffering offers little benefit for tiny files or when a caller already makes large reads through a buffered source. For B bytes, both scan and Files.readAllLines cost O(B) overall time. The byte scan uses O(buffer size) working memory. readAllLines materializes decoded text and per-line objects in O(B) space and is suitable if subsequent steps need the complete small file in memory. B1 measures both input methods with actual read-call counts.
