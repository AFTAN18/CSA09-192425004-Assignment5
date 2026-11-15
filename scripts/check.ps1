param([string]$Connector,[switch]$Jdbc,[switch]$FullBench)
$ErrorActionPreference='Stop'
Push-Location (Split-Path -Parent $PSScriptRoot)
function RunJava($classpath,$main,[string[]]$arguments=@()) {
    java -Xmx512m -cp $classpath $main @arguments
    if ($LASTEXITCODE) { throw "$main failed with $LASTEXITCODE" }
}
try {
    New-Item -ItemType Directory -Force build | Out-Null
    javac -encoding UTF-8 -d build @(Get-ChildItem Task*/source/*.java | ForEach-Object FullName)
    if ($LASTEXITCODE) { throw 'Compilation failed' }
    RunJava build SerializationDemo
    $output = @(RunJava build PassStore)
    if (Compare-Object @('[P1003, 192311003, Divya, 7, 3800.0]','null') $output -SyncWindow 0) {
        throw 'PassStore output mismatch'
    }
    $output
    RunJava build FullPassStore
    RunJava build FileBench @('lookup')
    if ($FullBench) { RunJava build FileBench @('lines') }
    if ($Jdbc) {
        if (!$Connector) { throw 'Supply -Connector PATH_TO_CONNECTOR_JAR' }
        $cp = "build;$Connector"
        foreach ($main in 'StudentDaoTest','WalletTest','LoginExperiment','Migration') { RunJava $cp $main }
        RunJava $cp JdbcBenchmark @('quick')
        if ($FullBench) { RunJava $cp JdbcBenchmark }
    }
} finally {
    Pop-Location
}
