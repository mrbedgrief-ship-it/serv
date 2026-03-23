$root = Split-Path -Parent $PSScriptRoot
$manifest = Get-Content (Join-Path $root 'configs/mod-manifest.json') | ConvertFrom-Json
$checks = @()

function Add-Check($name, $ok, $message) {
    $script:checks += [PSCustomObject]@{ Name = $name; OK = $ok; Message = $message }
}

$java = Get-Command java -ErrorAction SilentlyContinue
Add-Check 'Java 17 installed' ($null -ne $java) (if ($java) { (& java -version 2>&1 | Select-Object -First 1) } else { 'Install Java 17 first.' })

$prismExe = Join-Path $root 'launcher/PrismPortable/prismlauncher.exe'
Add-Check 'Prism game launcher' (Test-Path $prismExe) (if (Test-Path $prismExe) { 'Prism portable is ready.' } else { 'Run scripts/setup.bat to download Prism Launcher.' })

$instanceCfg = Join-Path $root 'launcher/prism-data/instances/cripcraft-zone-frontier/instance.cfg'
Add-Check 'CripCraft game instance' (Test-Path $instanceCfg) (if (Test-Path $instanceCfg) { 'Game instance found.' } else { 'Run scripts/setup.bat to create the playable game instance.' })

$runtimeRun = Join-Path $root 'server/runtime/run.bat'
Add-Check 'Forge server installed' (Test-Path $runtimeRun) (if (Test-Path $runtimeRun) { 'server/runtime/run.bat found.' } else { 'Run scripts/setup.bat to install the Forge server.' })

$templateProps = Join-Path $root 'server/template/server.properties'
$templateOffline = (Test-Path $templateProps) -and (Select-String -Path $templateProps -Pattern '^online-mode=false$' -Quiet)
Add-Check 'Local login mode' $templateOffline (if ($templateOffline) { 'online-mode=false is already set for local testing.' } else { 'Template server.properties is not set for local offline testing.' })

foreach ($mod in $manifest.shared_required) {
    $path = Join-Path $root ("mods/shared/" + $mod.filename)
    Add-Check ("Shared mod: " + $mod.name) (Test-Path $path) (if (Test-Path $path) { 'Found.' } else { 'Missing. Download from: ' + $mod.download_page })
}
foreach ($mod in $manifest.client_only_optional) {
    $path = Join-Path $root ("mods/client-only/" + $mod.filename)
    Add-Check ("Client mod: " + $mod.name) (Test-Path $path) (if (Test-Path $path) { 'Found.' } else { 'Optional but recommended. Download from: ' + $mod.download_page })
}

$instanceMods = Join-Path $root 'launcher/prism-data/instances/cripcraft-zone-frontier/.minecraft/mods'
Add-Check 'Play button game files' (Test-Path $instanceMods) (if (Test-Path $instanceMods) { 'Client instance mods folder exists.' } else { 'Repair/setup has not created the client game files yet.' })

$datapack = Join-Path $root 'server/template/cripcraft_world/datapacks/cripcraft/pack.mcmeta'
Add-Check 'CripCraft hub/world template' (Test-Path $datapack) (if (Test-Path $datapack) { 'Hub bunker and zone template found.' } else { 'World template datapack is missing.' })

Add-Check 'Shader warning' $true 'Turn shaders OFF before testing. Do not use shader packs for this prototype.'

Write-Host '========================================' -ForegroundColor Cyan
Write-Host 'CripCraft Forge File Check' -ForegroundColor Cyan
Write-Host '========================================' -ForegroundColor Cyan
foreach ($check in $checks) {
    if ($check.OK) {
        Write-Host "[OK] $($check.Name) - $($check.Message)" -ForegroundColor Green
    } else {
        Write-Host "[MISSING] $($check.Name) - $($check.Message)" -ForegroundColor Yellow
    }
}
