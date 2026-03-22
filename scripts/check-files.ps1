$root = Split-Path -Parent $PSScriptRoot
$checks = @()

function Add-Check($name, $ok, $message) {
    $script:checks += [PSCustomObject]@{ Name = $name; OK = $ok; Message = $message }
}

$java = Get-Command java -ErrorAction SilentlyContinue
Add-Check 'Java installed' ($null -ne $java) (if ($java) { 'Java was found.' } else { 'Install Java 21 and reopen this tool.' })

$jar = Join-Path $root 'downloads\vanilla-server-1.20.4.jar'
Add-Check 'Official server jar' (Test-Path $jar) (if (Test-Path $jar) { $jar } else { 'Run scripts\setup.bat to download it.' })

$datapack = Join-Path $root 'server\world-template\datapacks\cripcraft\pack.mcmeta'
Add-Check 'CripCraft datapack' (Test-Path $datapack) (if (Test-Path $datapack) { 'Datapack found.' } else { 'Datapack files are missing.' })

$eula = Join-Path $root 'server\runtime\eula.txt'
$eulaAccepted = $false
if (Test-Path $eula) {
    $eulaAccepted = Select-String -Path $eula -Pattern '^eula=true$' -Quiet
}
Add-Check 'Minecraft EULA accepted' $eulaAccepted (if ($eulaAccepted) { 'EULA already accepted.' } else { 'This is normal on first start. Click Play and type YES when asked.' })

Write-Host '========================================' -ForegroundColor Cyan
Write-Host 'CripCraft File Check' -ForegroundColor Cyan
Write-Host '========================================' -ForegroundColor Cyan
foreach ($check in $checks) {
    if ($check.OK) {
        Write-Host "[OK] $($check.Name) - $($check.Message)" -ForegroundColor Green
    } else {
        Write-Host "[MISSING] $($check.Name) - $($check.Message)" -ForegroundColor Yellow
    }
}
