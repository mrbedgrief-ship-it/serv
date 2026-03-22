$root = Split-Path -Parent $PSScriptRoot
$manifest = Get-Content (Join-Path $root 'configs/mod-manifest.json') | ConvertFrom-Json
$checks = @()

function Add-Check($name, $ok, $message) {
    $script:checks += [PSCustomObject]@{ Name = $name; OK = $ok; Message = $message }
}

$java = Get-Command java -ErrorAction SilentlyContinue
Add-Check 'Java 17 installed' ($null -ne $java) (if ($java) { (& java -version 2>&1 | Select-Object -First 1) } else { 'Install Java 17 first.' })

$installer = Join-Path $root ("downloads/forge-" + $manifest.minecraft_version + "-" + $manifest.forge_version + "-installer.jar")
Add-Check 'Forge installer' (Test-Path $installer) (if (Test-Path $installer) { $installer } else { 'Run scripts/setup.bat to download the Forge installer.' })

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

$clientPack = Join-Path $root 'client-pack/mods'
Add-Check 'Client pack folder' (Test-Path $clientPack) (if (Test-Path $clientPack) { 'Ready to copy into .minecraft\mods once jars are present.' } else { 'Missing client-pack/mods folder.' })

$mcMods = Join-Path $env:APPDATA '.minecraft\mods'
Add-Check 'Minecraft client mods folder' (Test-Path $mcMods) (if (Test-Path $mcMods) { $mcMods } else { 'Forge client may not be installed yet. After installing Forge client, this folder should exist.' })

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
