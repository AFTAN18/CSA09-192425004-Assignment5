# Verification environment

Aftan Faiz · 192425004

- Windows NT build 10.0.26200.0, x64.
- 12 logical processors reported by .NET. Processor identifier Intel64 Family 6 Model 151 Stepping 2, GenuineIntel.
- Default Java and compiler Temurin 8u504. The preserved modern-syntax templates were separately checked on Temurin 17.0.21+9.
- PowerShell 7.6.9 and Git 2.54.0.windows.1.
- All measured durations use System.nanoTime. Inputs are generated or fixed. Averages and medians use the CSV repetitions indicated by task answers.
- Timings are elapsed local observations. JIT compilation, OS file cache and concurrent activity were not fully controlled.
- For the JDBC tasks the disposable host used MySQL Community 8.4.13 and MySQL Connector/J 8.4.0 on loopback.
