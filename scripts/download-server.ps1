$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$downloads = Join-Path $root 'downloads'
New-Item -ItemType Directory -Force -Path $downloads | Out-Null
$target = Join-Path $downloads 'vanilla-server-1.20.4.jar'
$version = '1.20.4'

Write-Host 'Reading Mojang version manifest...' -ForegroundColor Cyan
$manifest = Invoke-RestMethod 'https://launchermeta.mojang.com/mc/game/version_manifest.json'
$entry = $manifest.versions | Where-Object { $_.id -eq $version } | Select-Object -First 1
if (-not $entry) {
    throw "Minecraft version $version was not found in Mojang's manifest."
}

Write-Host 'Reading version metadata...' -ForegroundColor Cyan
$meta = Invoke-RestMethod $entry.url
$serverUrl = $meta.downloads.server.url
if (-not $serverUrl) {
    throw 'Could not find the official server download URL.'
}

Write-Host 'Downloading official server jar...' -ForegroundColor Cyan
Invoke-WebRequest -Uri $serverUrl -OutFile $target
Write-Host "Saved: $target" -ForegroundColor Green
