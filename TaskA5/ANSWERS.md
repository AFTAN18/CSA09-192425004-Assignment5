# A5 · Wallet transaction and login

## A5.1 · Transfer

```text
ALGORITHM Transfer(source, target, amount)
    REQUIRE distinct wallet IDs AND amount = 50000 paise
    OPEN dedicated JDBC connection
    DISABLE auto-commit
    TRY
        LOCK both wallet records in ascending ID order
        IF either missing OR source balance < amount THEN FAIL
        DEBIT source using parameterized UPDATE and require one changed row
        CREDIT target using parameterized UPDATE and require one changed row
        COMMIT
    ON failure
        ROLLBACK
        REPORT failure, preserving rollback diagnostics
    END TRY
    CLOSE connection
END ALGORITHM
```

Before commit, transactional rollback restores both rows after a statement error or disconnect. A lost commit acknowledgement requires an idempotency key or reconciliation before retrying. Separate autocommit statements can leave the debit permanently applied if failure precedes credit. Both do two writes plus indexed lookups. A transaction may add lock and commit overhead but can amortize durability work into one commit. Auxiliary app space is O(1); database logging/locking is bounded for the two-row example.

## A5.2 · Injection

Concatenating an ID that closes a string and introduces OR 1=1, followed by a MySQL comment marker with required whitespace, can bypass the password predicate. Parameterize the ID and applicable password lookup so data cannot become SQL syntax. The assignment's disposable demonstration compares literal fixture passwords to show the difference. A real authentication implementation should retrieve a password hash by ID and verify it separately.
