# B1 · File store and measurement

The full store transfers the seven-field design from A1 to UTF-8. One object serializes additions through its instance monitor. find reads until match and route visits all valid records. The fixture checks a missing file, escaped delimiter/backslash, two good rows, a wrong field count, an invalid amount, a blank line, a missing ID and duplicate rejection. Malformed rows emit a numbered diagnostic and scanning continues. This fixture does not implement multi-process locking or a crash journal.

The original shorter PassStore uses the five-field CSV compatibility exercise. The clipped P1001 line is restored with an illustrative amount because it never affects the two printed results. The supplied `Files.writeString` is represented on Java 8 with an equivalent UTF-8 byte append. The TODO skips records with the wrong field count, so P1002 cannot abort the lookup for P1003. The full implementation additionally validates numeric and date fields.

The timing fixture builds exact 1, 10 and 50 MiB logs using 128-byte LF-terminated rows. Each method is sampled three times per size and compared for exact counts. Actual Java read-call counts include EOF. It also verifies empty and unterminated inputs. Timed lookup uses 1,000, 10,000 and 100,000 records with first, last and missing IDs. It samples five times after two warmups. File generation is outside the timed sections. Warm OS cache affects throughput, while per-call overhead remains visible.

For q lookups over n similarly-sized records, repeated scans use O(qn) worst-case time and O(maximum row length) working space. Loading valid rows once into a HashMap and applying a deterministic duplicate policy takes O(n) expected time and O(n) retained entries, then expected O(q) additional lookup work for bounded length keys. The map must be kept current on writes. Route output materialization uses O(k) records for k matches.

At 50 MiB, the one-byte method used 52,428,801 read calls and averaged 65,093.22 ms. The block method used 6,401 calls and averaged 33.73 ms. These are Java read calls, not independently traced OS calls. At 100,000 rows the final-ID and absent-ID scans averaged 118.24 and 119.73 ms, respectively. The first-ID path stopped after one record. See both means tables and the raw CSV files.

The full 1, 10 and 50 MiB benchmark is recorded in lines.csv. Its long repeat finished while the desktop returned a black capture, so the saved interactive screenshot uses a separate real 1 MiB run. Launch it with java -cp build FileBench lines smoke.
