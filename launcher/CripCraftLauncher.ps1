Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$settingsDir = Join-Path $env:APPDATA 'CripCraftLauncher'
$settingsFile = Join-Path $settingsDir 'settings.json'
New-Item -ItemType Directory -Force -Path $settingsDir | Out-Null

function Save-LauncherState($action) {
    $payload = @{ last_action = $action; updated_at = (Get-Date).ToString('s') }
    $payload | ConvertTo-Json | Set-Content -Path $settingsFile
}

function Get-CripCraftStatus {
    $manifest = Get-Content (Join-Path $root 'configs/mod-manifest.json') | ConvertFrom-Json
    $lines = New-Object System.Collections.Generic.List[string]

    if (Get-Command java -ErrorAction SilentlyContinue) {
        $lines.Add('Java: OK')
    } else {
        $lines.Add('Java: MISSING - Install Java 17.')
    }

    $prismExe = Join-Path $root 'launcher/PrismPortable/prismlauncher.exe'
    if (Test-Path $prismExe) {
        $lines.Add('Prism game launcher: OK')
    } else {
        $lines.Add('Prism game launcher: MISSING - Click Repair / Setup.')
    }

    $runBat = Join-Path $root 'server/runtime/run.bat'
    if (Test-Path $runBat) {
        $lines.Add('Local Forge server: OK')
    } else {
        $lines.Add('Local Forge server: MISSING - Click Repair / Setup.')
    }

    $instanceCfg = Join-Path $root 'launcher/prism-data/instances/cripcraft-zone-frontier/instance.cfg'
    if (Test-Path $instanceCfg) {
        $lines.Add('CripCraft game instance: OK')
    } else {
        $lines.Add('CripCraft game instance: MISSING - Click Repair / Setup.')
    }

    foreach ($mod in $manifest.shared_required) {
        $path = Join-Path $root ("mods/shared/" + $mod.filename)
        if (Test-Path $path) {
            $lines.Add("Shared mod OK: $($mod.filename)")
        } else {
            $lines.Add("Shared mod missing: $($mod.filename)")
        }
    }

    foreach ($mod in $manifest.client_only_optional) {
        $path = Join-Path $root ("mods/client-only/" + $mod.filename)
        if (Test-Path $path) {
            $lines.Add("Client mod ready: $($mod.filename)")
        } else {
            $lines.Add("Optional client mod missing: $($mod.filename)")
        }
    }

    $lines.Add('Reminder: The Play button starts the local server and launches the Prism game instance.')
    $lines.Add('Reminder: Turn shaders OFF before testing.')
    return ($lines -join [Environment]::NewLine)
}

$form = New-Object System.Windows.Forms.Form
$form.Text = 'CripCraft Launcher'
$form.Size = New-Object System.Drawing.Size(660,450)
$form.StartPosition = 'CenterScreen'
$form.BackColor = [System.Drawing.Color]::FromArgb(12,12,20)
$form.ForeColor = [System.Drawing.Color]::White
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

$banner = New-Object System.Windows.Forms.Panel
$banner.BackColor = [System.Drawing.Color]::FromArgb(16,26,40)
$banner.Size = New-Object System.Drawing.Size(660,96)
$banner.Location = New-Object System.Drawing.Point(0,0)
$form.Controls.Add($banner)

$title = New-Object System.Windows.Forms.Label
$title.Text = 'CRIPCRAFT'
$title.Font = New-Object System.Drawing.Font('Segoe UI',28,[System.Drawing.FontStyle]::Bold)
$title.ForeColor = [System.Drawing.Color]::Aqua
$title.AutoSize = $true
$title.Location = New-Object System.Drawing.Point(208,14)
$banner.Controls.Add($title)

$subtitle = New-Object System.Windows.Forms.Label
$subtitle.Text = 'Zone Frontier  |  Forge 1.20.1  |  Local playable prototype'
$subtitle.Font = New-Object System.Drawing.Font('Segoe UI',11)
$subtitle.ForeColor = [System.Drawing.Color]::LightGray
$subtitle.AutoSize = $true
$subtitle.Location = New-Object System.Drawing.Point(115,60)
$banner.Controls.Add($subtitle)

$statusBox = New-Object System.Windows.Forms.TextBox
$statusBox.Multiline = $true
$statusBox.ReadOnly = $true
$statusBox.ScrollBars = 'Vertical'
$statusBox.BackColor = [System.Drawing.Color]::FromArgb(24,24,32)
$statusBox.ForeColor = [System.Drawing.Color]::White
$statusBox.Font = New-Object System.Drawing.Font('Consolas',10)
$statusBox.Size = New-Object System.Drawing.Size(590,195)
$statusBox.Location = New-Object System.Drawing.Point(30,155)
$statusBox.Text = "Welcome to CripCraft.`r`nClick Check Files first.`r`nWhen you click Play, the launcher starts the local server and launches the game.`r`nTurn shaders OFF before testing."
$form.Controls.Add($statusBox)

function New-CCButton($text, $x, $y, $width) {
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $text
    $button.Size = New-Object System.Drawing.Size($width,42)
    $button.Location = New-Object System.Drawing.Point($x,$y)
    $button.BackColor = [System.Drawing.Color]::FromArgb(0,194,219)
    $button.ForeColor = [System.Drawing.Color]::Black
    $button.FlatStyle = 'Flat'
    $button.Font = New-Object System.Drawing.Font('Segoe UI',10,[System.Drawing.FontStyle]::Bold)
    return $button
}

$playButton = New-CCButton 'Play' 30 110 120
$checkButton = New-CCButton 'Check Files' 170 110 120
$guideButton = New-CCButton 'Open Guide' 310 110 120
$repairButton = New-CCButton 'Repair / Setup' 450 110 170
$exitButton = New-CCButton 'Exit' 450 370 170

$playButton.Add_Click({
    Save-LauncherState 'play'
    $statusBox.Text = "Starting CripCraft...`r`n1. The local server will open in a new window.`r`n2. Prism Launcher will start the CripCraft game instance.`r`n3. If Prism asks for your Minecraft account the first time, sign in there.`r`n4. If the server is still loading, wait for DONE and then click Reconnect once."
    Start-Process -FilePath (Join-Path $root 'scripts/play-cripcraft.bat')
})

$checkButton.Add_Click({
    Save-LauncherState 'check'
    $statusBox.Text = Get-CripCraftStatus
})

$guideButton.Add_Click({
    Save-LauncherState 'guide'
    Start-Process -FilePath (Join-Path $root 'README_FIRST.txt')
    $statusBox.Text = "Opened README_FIRST.txt.`r`nFollow the numbered steps exactly."
})

$repairButton.Add_Click({
    Save-LauncherState 'repair'
    $statusBox.Text = "Opening setup/repair script...`r`nThis downloads Prism + Forge server files, syncs the instance, and opens mod download pages if something is missing."
    Start-Process -FilePath (Join-Path $root 'scripts/setup.bat')
})

$exitButton.Add_Click({
    Save-LauncherState 'exit'
    $form.Close()
})

$form.Controls.AddRange(@($playButton,$checkButton,$guideButton,$repairButton,$exitButton))
[void]$form.ShowDialog()
