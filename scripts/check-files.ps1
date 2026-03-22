$root = Split-Path -Parent $PSScriptRoot
$checks = @()

function Add-Check($name, $ok, $message) {
    $script:checks += [PSCustomObject]@{ Name = $name; OK = $ok; Message = $message }
}

$java = Get-Command java -ErrorAction SilentlyContinue
Add-Check 'Java installed' ($null -ne $java) (if ($java) { 'Java was found.' } else { 'Install Java 21 and reopen this tool.' })

$jar = Join-Path $root 'downloads\vanilla-server-1.20.4.jar'
Add-Check 'Official server jar' (Test-Path $jar) (if (Test-Path $jar) { $jar } else { 'Run scripts\setup.bat to download it.' })

$templateProps = Join-Path $root 'server\template\server.properties'
$templateOffline = (Test-Path $templateProps) -and (Select-String -Path $templateProps -Pattern '^online-mode=false$' -Quiet)
Add-Check 'Template local login mode' $templateOffline (if ($templateOffline) { 'online-mode=false is already set for local testing.' } else { 'The template is not set for offline localhost testing.' })

$runtimeProps = Join-Path $root 'server\runtime\server.properties'
$runtimeOffline = (Test-Path $runtimeProps) -and (Select-String -Path $runtimeProps -Pattern '^online-mode=false$' -Quiet)
Add-Check 'Runtime local login mode' ($runtimeOffline -or -not (Test-Path $runtimeProps)) (if ($runtimeOffline) { 'Runtime server is ready for localhost testing.' } elseif (Test-Path $runtimeProps) { 'Runtime server exists but online-mode is not false yet. Click Play once more.' } else { 'This is normal before first launch. Click Play to create the runtime files.' })

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
