$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$manifest = Get-Content (Join-Path $root 'configs/mod-manifest.json') | ConvertFrom-Json
$downloads = Join-Path $root 'downloads'
$runtime = Join-Path $root 'server/runtime'
$forgeInstallerName = "forge-$($manifest.minecraft_version)-$($manifest.forge_version)-installer.jar"
$forgeInstallerPath = Join-Path $downloads $forgeInstallerName
$forgeInstallerUrl = "https://maven.minecraftforge.net/net/minecraftforge/forge/$($manifest.minecraft_version)-$($manifest.forge_version)/forge-$($manifest.minecraft_version)-$($manifest.forge_version)-installer.jar"
$prismZipName = 'PrismLauncher-Windows-MinGW-w64-Portable-9.4.zip'
$prismZipPath = Join-Path $downloads $prismZipName
$prismZipUrl = 'https://github.com/PrismLauncher/PrismLauncher/releases/download/9.4/PrismLauncher-Windows-MinGW-w64-Portable-9.4.zip'
$prismHome = Join-Path $root 'launcher/PrismPortable'
$prismExe = Join-Path $prismHome 'prismlauncher.exe'

function Write-Step($message) {
    Write-Host "[CripCraft] $message" -ForegroundColor Cyan
}

if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Write-Host '[ERROR] Java was not found. Install Java 17 first.' -ForegroundColor Red
    exit 1
}

New-Item -ItemType Directory -Force -Path $downloads, $runtime, (Join-Path $root 'mods/shared'), (Join-Path $root 'mods/client-only'), (Join-Path $root 'client-pack/mods'), $prismHome, (Join-Path $root 'launcher/prism-data') | Out-Null

if (-not (Test-Path $forgeInstallerPath)) {
    Write-Step "Downloading Forge server installer: $forgeInstallerName"
    Invoke-WebRequest -Uri $forgeInstallerUrl -OutFile $forgeInstallerPath
} else {
    Write-Step "Forge server installer already exists."
}

if (-not (Test-Path (Join-Path $runtime 'run.bat'))) {
    Write-Step 'Installing Forge server into server/runtime ...'
    Push-Location $runtime
    & java -jar $forgeInstallerPath --installServer .
    Pop-Location
} else {
    Write-Step 'Forge server already installed.'
}

if (-not (Test-Path $prismExe)) {
    Write-Step 'Downloading Prism Launcher portable...'
    Invoke-WebRequest -Uri $prismZipUrl -OutFile $prismZipPath
    Write-Step 'Extracting Prism Launcher portable...'
    Expand-Archive -Path $prismZipPath -DestinationPath $prismHome -Force
} else {
    Write-Step 'Prism Launcher portable already exists.'
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
Write-Host 'IMPORTANT:' -ForegroundColor Green
Write-Host 'Prism Launcher is the game launcher for this project.' -ForegroundColor Green
Write-Host 'After setup, click Play in the CripCraft launcher.' -ForegroundColor Green
Write-Host 'The Play button will start the local server and then launch the Prism game instance.' -ForegroundColor Green
Write-Host 'Turn shaders OFF before testing.' -ForegroundColor Green
