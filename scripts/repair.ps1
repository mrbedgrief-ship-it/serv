$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$runtime = Join-Path $root 'server/runtime'
$template = Join-Path $root 'server/template'
$manifest = Get-Content (Join-Path $root 'configs/mod-manifest.json') | ConvertFrom-Json

function Ensure-Directory($path) {
    New-Item -ItemType Directory -Force -Path $path | Out-Null
}

Ensure-Directory $runtime
Ensure-Directory (Join-Path $runtime 'mods')
Ensure-Directory (Join-Path $root 'client-pack/mods')
Ensure-Directory (Join-Path $root 'mods/shared')
Ensure-Directory (Join-Path $root 'mods/client-only')

Copy-Item (Join-Path $template 'server.properties') (Join-Path $runtime 'server.properties') -Force
if (-not (Test-Path (Join-Path $runtime 'eula.txt'))) {
    Copy-Item (Join-Path $template 'eula.txt') (Join-Path $runtime 'eula.txt') -Force
}

if (Test-Path (Join-Path $template 'cripcraft_world')) {
    Ensure-Directory (Join-Path $runtime 'cripcraft_world')
    Copy-Item (Join-Path $template 'cripcraft_world/*') (Join-Path $runtime 'cripcraft_world') -Recurse -Force
}

# Keep local testing enabled even if runtime config already existed.
$propsPath = Join-Path $runtime 'server.properties'
if (Test-Path $propsPath) {
    $props = Get-Content $propsPath
    $props = $props -replace '^online-mode=.*', 'online-mode=false'
    $props = $props -replace '^enforce-secure-profile=.*', 'enforce-secure-profile=false'
    Set-Content -Path $propsPath -Value $props
}

# Client pack and server mods
Remove-Item (Join-Path $runtime 'mods/*') -Force -ErrorAction SilentlyContinue
Remove-Item (Join-Path $root 'client-pack/mods/*') -Force -ErrorAction SilentlyContinue

foreach ($mod in $manifest.shared_required) {
    $sharedPath = Join-Path $root ("mods/shared/" + $mod.filename)
    if (Test-Path $sharedPath) {
        Copy-Item $sharedPath (Join-Path $runtime 'mods') -Force
        Copy-Item $sharedPath (Join-Path $root 'client-pack/mods') -Force
    }
}
foreach ($mod in $manifest.client_only_optional) {
    $clientPath = Join-Path $root ("mods/client-only/" + $mod.filename)
    if (Test-Path $clientPath) {
        Copy-Item $clientPath (Join-Path $root 'client-pack/mods') -Force
    }
}

Write-Host '[OK] CripCraft repair/sync finished.' -ForegroundColor Green
