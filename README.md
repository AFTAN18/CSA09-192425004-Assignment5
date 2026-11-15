# CSA09 Assignment 5 · Data persistence engineering

Aftan Faiz · 192425004 · CO5

```text
openjdk version "1.8.0_504"
OpenJDK Runtime Environment (Temurin)(build 1.8.0_504-b01)
OpenJDK 64-Bit Server VM (Temurin)(build 25.504-b01, mixed mode)
javac 1.8.0_504
```

Run `pwsh -NoProfile -File scripts/check.ps1` from the repository root for the standalone programs. Use `-FullBench` to include the 1, 10 and 50 MiB byte-vs-buffer file experiment, which takes several minutes. Generated data is temporary. Its size and values are fixed by code.

For JDBC, create an empty disposable local MySQL schema named `csa09_persistence`, apply `schema.sql`, and set the environment values shown in `.env.example`. Use an account scoped to that schema. Example after setup:

```powershell
pwsh -NoProfile -File scripts/check.ps1 -Jdbc -Connector "PATH_TO_CONNECTOR_JAR"
pwsh -NoProfile -File scripts/check.ps1 -Jdbc -FullBench -Connector "PATH_TO_CONNECTOR_JAR"
```

The run uses synthetic rows. The JDBC benchmark truncates the disposable bus_pass table between trials; the login comparison runs only against loopback. Verification used MySQL Community 8.4.13 and Connector/J 8.4.0 with batch rewriting. The original B1 append syntax is also available in TaskB1/template-jdk17 and was verified separately with JDK 17.

| Task | Expected and verified behavior |
|---|---|
| [A1](TaskA1/ANSWERS.md) | Seven-field text/binary design with escaped delimiters and recovery |
| [A2](TaskA2/ANSWERS.md) | Read-call prediction and bounded buffering |
| [A3](TaskA3/ANSWERS.md) | Generic DAO and all five MySQL CRUD paths |
| [A4](TaskA4/ANSWERS.md) | Serialized graph excludes password and connection |
| [A5](TaskA5/ANSWERS.md) | Injected transfer failure rolls back both balances |
| [B1](TaskB1/ANSWERS.md) | Expected template lines, corrupt rows, lookup and line-count measurements |
| [B2](TaskB2/ANSWERS.md) | Crafted fixture accepted by unsafe SQL and rejected by parameters |
| [B3](TaskB3/ANSWERS.md) | Column types, 10 to 100,000 inserts and verified rollback |
| [B4](TaskB4/ANSWERS.md) | Two valid rows, two validation failures and live metadata |

See the [assignment report](report/AssignmentReport.md). Local timings are elapsed wall-clock measurements from this machine, and can vary with caching, checkpointing and concurrent work.

See the [evidence audit](EVIDENCE_AUDIT.md) for screenshot filenames, programming results and outstanding requirements.
