# A1 · Bus-pass file format

## A1.1 · Represent the record

UTF-8 text, one record per LF-terminated line, fields in this order: pass ID, register number, name, route number, boarding stop, ISO validity date, amount paid with two decimal places. Separate fields by |. Escape a literal | as \| and a literal backslash as \\. Reject literal control characters, including CR and LF, in field values. Example: P1|192311001|Asha\|Rao|7|North Gate|2027-03-31|3800.00. Preserve registration as text because leading zeroes may matter.

Binary version: a four-byte magic word and two-byte version followed by records. Each record is length-prefixed with a four-byte signed length constrained by a documented maximum, then pass ID, registration and name as DataOutputStream.writeUTF fields (two-byte modified UTF-8 byte length per field, maximum 65,535), route as four-byte signed int, boarding stop as writeUTF, validity as eight-byte signed epoch-day and amount as eight-byte signed minor units. Delimiters have no special meaning. A per-record CRC-32 can detect accidental payload corruption; verify record lengths and range before allocating.

## A1.2 · Operations

```text
ALGORITHM AddPass(record, path)
    VALIDATE all fields
    ACQUIRE the store's exclusive writer lock
    IF FindPass(record.id, path) succeeds THEN RETURN duplicate
    APPEND escaped record and line terminator through buffered UTF-8 writer
    CLOSE writer
    RELEASE lock
END ALGORITHM

ALGORITHM FindPass(id, path)
    IF file does not exist THEN RETURN absent
    OPEN buffered UTF-8 reader
    FOR EACH line DO
        DECODE escape sequences and validate all fields
        IF damaged THEN record line number and CONTINUE
        IF record ID equals id THEN RETURN record
    END FOR
    RETURN absent
    CLOSE reader on exit
END ALGORITHM

ALGORITHM ListRoute(route, path)
    IF file does not exist THEN RETURN empty list
    OPEN buffered UTF-8 reader
    FOR EACH line DO
        DECODE and validate
        IF damaged THEN record line number and CONTINUE
        IF record route equals route THEN EMIT record
    END FOR
    CLOSE reader
END ALGORITHM
```

BufferedReader/BufferedWriter reduce calls while preserving charset and line boundaries. Java's Files factories let the program explicitly select UTF-8; FileReader/FileWriter in Java 8 otherwise use the platform default. FileInputStream/FileOutputStream are appropriate beneath binary data streams.

## A1.3 · Damaged data and alternatives

Reject wrong field count, unsupported escapes, malformed dates, out-of-range values and invalid amounts. Record damaged line numbers and keep scanning. A missing file represents a new empty store. A power interruption can leave an unterminated tail or a syntactically plausible but incomplete record. A durable format uses checksums and record framing and verifies the tail before future appends. For replace operations, write and force a sibling temporary file, then atomically replace the destination where supported. For append, serialize writers, use a recoverable journal/frame and force the channel before reporting durability. The simple B1 fixture supports in-process writers and semantic row validation, with the durability design left as an extension.

Scan costs O(total bytes) time with O(maximum record length) extra reader memory, plus output. RandomAccessFile can seek to i × recordSize in O(1) indexed work given a known record ordinal, with O(recordSize) read work and scratch. Arbitrary pass IDs still need an ID-to-ordinal index or a scan. Fixed-width records waste the sum of unused bytes in padded fields and constrain strings. A separate map costs O(n) index space and supports expected O(1) lookup for bounded-length keys.
