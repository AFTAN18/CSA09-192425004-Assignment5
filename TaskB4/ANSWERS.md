# B4 · Migration and scale decision

## B4.1 · Migration

```text
ALGORITHM MigratePasses(input, rejects)
    OPEN dedicated connection and disable auto-commit
    FOR EACH numbered input line DO
        PARSE and validate fields and detect repeated input keys
        IF invalid THEN WRITE rejection with line number AND CONTINUE
        BIND seven fields and add to batch
        IF batch reaches 500 THEN execute batch
    END FOR
    EXECUTE final partial batch
    FLUSH validation report
    COMMIT all valid inserts, or ROLLBACK on database/system failure
END ALGORITHM
```

The fixture sends two valid lines, one malformed line and one duplicate key in the input. It checks all fields that were absent from the five-field teaching template and captures two validation messages. An existing server-side primary-key conflict rolls back the valid import. For multiple importers, stage with import-run IDs and reconcile duplicates transactionally. The single input-ID set takes O(n) worst-case client space. SQL parameter staging uses O(b) for b batch rows.

## B4.2 · Metadata

DatabaseMetaData reports actual product, server version, driver and tables. Compare these to deployment requirements and help diagnose server/driver or missing-schema issues without assuming vendor and version. This program requires MySQL and uses its SQL dialect.

## B4.3 · Decision

Use one logical database for twelve campuses, with a stable global key or composite campus/pass ID, indexed by route and campus, durable writes, transactions, least-privilege roles, backups and observed load tests. The 8,000-per-year baseline scales to roughly 800,000 per year. B1's measured tail/miss scan grows with file size. B3's real batch timings establish feasibility for loading 100,000 rows on this local fixture. They do not establish throughput for independent production sites. Index lookups are roughly O(log N) plus network, and route reports are roughly O(log N+k) with k matches and a matching index. The database stores O(N) rows and O(N) index entries, plus logs and working caches.

Twelve separate serialized campus files need a local writer protocol and atomic file replacement. Searching all files is O(N) record work without a global index. Parallel materialization may use O(N) memory, while processing one campus at a time uses O(max campus records), plus results. Concurrent counters need cross-process locking or a single writer and reliable coordination across sites. Database uniqueness and transactional concurrency directly represent those requirements.
