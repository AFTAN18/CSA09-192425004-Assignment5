# Assignment 5 · Files and JDBC

Aftan Faiz · 192425004 · CSA09 Programming in Java

Temurin Java 8u504. JDK 17.0.21 for the modern templates.

## Compile and run

```powershell
pwsh -NoProfile -File scripts/check.ps1
```

Apply [schema.sql](schema.sql) to disposable local MySQL schema `csa09_persistence` and set [the environment variables](.env.example). Use `pwsh -NoProfile -File scripts/check.ps1 -Jdbc -Connector PATH_TO_CONNECTOR_JAR`. Add `-FullBench` for all measurements.

**Tests.** File and JDBC tests, rollback, migration and benchmarks verified.

| Task and screenshots | Topic |
|---|---|
| [TaskA1](TaskA1/README.md) | A1 · Bus-pass file format |
| [TaskA2](TaskA2/README.md) | A2 · Buffered attendance-log scanning |
| [TaskA3](TaskA3/README.md) | A3 · Generic data access |
| [TaskA4](TaskA4/README.md) | A4 · Serialization |
| [TaskA5](TaskA5/README.md) | A5 · Wallet transaction and login |
| [TaskB1](TaskB1/README.md) | B1 · File store and measurement |
| [TaskB2](TaskB2/README.md) | B2 · Adversarial inputs |
| [TaskB3](TaskB3/README.md) | B3 · MySQL insert experiments |
| [TaskB4](TaskB4/README.md) | B4 · Migration and scale decision |

[Assignment report](report/AssignmentReport.md) · [Evidence audit](EVIDENCE_AUDIT.md) · [Test environment](report/TestEnvironment.md)
