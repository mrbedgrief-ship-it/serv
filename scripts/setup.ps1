$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$manifest = Get-Content (Join-Path $root 'configs/mod-manifest.json') | ConvertFrom-Json
$downloads = Join-Path $root 'downloads'
$installerName = "forge-$($manifest.minecraft_version)-$($manifest.forge_version)-installer.jar"
$installerPath = Join-Path $downloads $installerName
$installerUrl = "https://maven.minecraftforge.net/net/minecraftforge/forge/$($manifest.minecraft_version)-$($manifest.forge_version)/forge-$($manifest.minecraft_version)-$($manifest.forge_version)-installer.jar"
$runtime = Join-Path $root 'server/runtime'

function Write-Step($message) {
    Write-Host "[CripCraft] $message" -ForegroundColor Cyan
}

if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Write-Host '[ERROR] Java was not found. Install Java 17 first.' -ForegroundColor Red
    exit 1
}

$javaVersion = (& java -version 2>&1 | Select-Object -First 1)
Write-Step "Java detected: $javaVersion"

New-Item -ItemType Directory -Force -Path $downloads, $runtime, (Join-Path $root 'mods/shared'), (Join-Path $root 'mods/client-only'), (Join-Path $root 'client-pack/mods') | Out-Null

if (-not (Test-Path $installerPath)) {
    Write-Step "Downloading Forge installer: $installerName"
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
} else {
    Write-Step "Forge installer already exists: $installerName"
}

if (-not (Test-Path (Join-Path $runtime 'run.bat'))) {
    Write-Step 'Installing Forge server into server/runtime ...'
    Push-Location $runtime
    & java -jar $installerPath --installServer .
    Pop-Location
} else {
    Write-Step 'Forge server already installed.'
}

& (Join-Path $PSScriptRoot 'repair.ps1')
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$missing = @()
foreach ($mod in $manifest.shared_required) {
    $path = Join-Path $root ("mods/shared/" + $mod.filename)
    if (-not (Test-Path $path)) { $missing += $mod }
}
foreach ($mod in $manifest.client_only_optional) {
    $path = Join-Path $root ("mods/client-only/" + $mod.filename)
    if (-not (Test-Path $path)) { $missing += $mod }
}

if ($missing.Count -gt 0) {
    Write-Host ''
    Write-Host 'Some mod files are still missing.' -ForegroundColor Yellow
    Write-Host 'Browser tabs will open so you can download them.' -ForegroundColor Yellow
    foreach ($mod in $missing) {
        Write-Host ("- " + $mod.filename + " -> " + $mod.download_page) -ForegroundColor Yellow
        Start-Process $mod.download_page
    }
} else {
    Write-Step 'All listed mod jars are present.'
}

Write-Host ''
Write-Host 'IMPORTANT CLIENT STEP:' -ForegroundColor Green
Write-Host "Double-click $installerPath and click Install client." -ForegroundColor Green
Write-Host 'Then copy everything from client-pack/mods/ into %APPDATA%\.minecraft\mods' -ForegroundColor Green
Write-Host 'Turn shaders OFF before testing.' -ForegroundColor Green
