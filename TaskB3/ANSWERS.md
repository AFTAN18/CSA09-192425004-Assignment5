# B3 · MySQL insert experiments

## B3.1 · Correctness

For each mode, clear only the disposable table, insert the same ten generated passes and SELECT the ordered keys. Assert every field, no extra row and five expected JDBC column types using ResultSetMetaData. The benchmark applies the same check to counts at larger sizes.

## B3.2 · Growth

Use 10, 1,000, 10,000 and 100,000 generated passes, rotating execution order. A warmup is followed by three measured repetitions. Dataset construction, table truncation and verification are outside the timed region. Times include statement creation, binding or SQL construction, execution and commits. Batch size is 500. Each baseline uses one transaction so auto-commit is a separate experiment. Local Connector/J uses rewriteBatchedStatements=true.

## B3.3 · Atomicity

Force a duplicate first key at row 501. With auto-commit the earlier successful batch persists. With a single transaction all rows roll back. The completed PassLoader also binds an invalid decimal halfway through its fixture, after one executed batch. It must roll back to zero rows. It expects a dedicated connection to avoid committing caller-owned work.

## B3.4 · Trade-offs

For a counter issuing one pass, use one prepared statement with a small transaction as needed for associated updates. For nightly imports use prepared batches under an explicit transaction or staged chunks with clear restart behavior. The fixed-size batch reduces round trips and repeated parsing compared with individual statements. A multi-row SQL string groups rows and should bind parameters for each row, respecting packet limits. LOAD DATA uses server-side bulk parsing and needs staging, file access and validation design. Each loads at least O(n) rows. Batching with b rows uses O(b) parameter staging, plus O(n) Java fixture storage in this benchmark and database log/index cost. A single huge statement would require O(n) SQL space and can exceed limits.

At 100,000 rows, Statement averaged 10,184.39 ms, per-row PreparedStatement 9,642.81 ms, transactional prepared batch 1,302.62 ms, autocommit batch 1,770.19 ms and the completed loader 1,169.53 ms. With the injected duplicate, the observed remaining counts were 500 under autocommit and 0 inside a transaction. The invalid decimal in the loader also left 0 rows. Repeating the full benchmark produced a second dataset in evidence/replicate.csv.
