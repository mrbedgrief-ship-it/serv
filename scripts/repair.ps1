$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$runtime = Join-Path $root 'server/runtime'
$template = Join-Path $root 'server/template'
$manifest = Get-Content (Join-Path $root 'configs/mod-manifest.json') | ConvertFrom-Json
$clientMods = Join-Path $root 'client-pack/mods'
$instanceTemplate = Join-Path $root 'client-pack/prism-instance-template/cripcraft-zone-frontier'
$prismData = Join-Path $root 'launcher/prism-data'
$instanceRoot = Join-Path $prismData 'instances/cripcraft-zone-frontier'
$instanceMods = Join-Path $instanceRoot '.minecraft/mods'

function Ensure-Directory($path) {
    New-Item -ItemType Directory -Force -Path $path | Out-Null
}

Ensure-Directory $runtime
Ensure-Directory (Join-Path $runtime 'mods')
Ensure-Directory $clientMods
Ensure-Directory (Join-Path $root 'mods/shared')
Ensure-Directory (Join-Path $root 'mods/client-only')
Ensure-Directory $prismData
Ensure-Directory (Join-Path $prismData 'instances')

Copy-Item (Join-Path $template 'server.properties') (Join-Path $runtime 'server.properties') -Force
if (-not (Test-Path (Join-Path $runtime 'eula.txt'))) {
    Copy-Item (Join-Path $template 'eula.txt') (Join-Path $runtime 'eula.txt') -Force
}
if (Test-Path (Join-Path $template 'cripcraft_world')) {
    Ensure-Directory (Join-Path $runtime 'cripcraft_world')
    Copy-Item (Join-Path $template 'cripcraft_world/*') (Join-Path $runtime 'cripcraft_world') -Recurse -Force
}

$propsPath = Join-Path $runtime 'server.properties'
if (Test-Path $propsPath) {
    $props = Get-Content $propsPath
    $props = $props -replace '^online-mode=.*', 'online-mode=false'
    $props = $props -replace '^enforce-secure-profile=.*', 'enforce-secure-profile=false'
    Set-Content -Path $propsPath -Value $props
}

if (Test-Path $instanceTemplate) {
    Ensure-Directory $instanceRoot
    Copy-Item (Join-Path $instanceTemplate '*') $instanceRoot -Recurse -Force
}
Ensure-Directory $instanceMods

Remove-Item (Join-Path $runtime 'mods/*') -Force -ErrorAction SilentlyContinue
Remove-Item (Join-Path $clientMods '*') -Force -ErrorAction SilentlyContinue
Remove-Item (Join-Path $instanceMods '*') -Force -ErrorAction SilentlyContinue

foreach ($mod in $manifest.shared_required) {
    $sharedPath = Join-Path $root ("mods/shared/" + $mod.filename)
    if (Test-Path $sharedPath) {
        Copy-Item $sharedPath (Join-Path $runtime 'mods') -Force
        Copy-Item $sharedPath $clientMods -Force
        Copy-Item $sharedPath $instanceMods -Force
    }
}
foreach ($mod in $manifest.client_only_optional) {
    $clientPath = Join-Path $root ("mods/client-only/" + $mod.filename)
    if (Test-Path $clientPath) {
        Copy-Item $clientPath $clientMods -Force
        Copy-Item $clientPath $instanceMods -Force
    }
}

Write-Host '[OK] CripCraft repair/sync finished.' -ForegroundColor Green
