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

    $installer = Join-Path $root ("downloads/forge-" + $manifest.minecraft_version + "-" + $manifest.forge_version + "-installer.jar")
    if (Test-Path $installer) {
        $lines.Add('Forge installer: OK')
    } else {
        $lines.Add('Forge installer: MISSING - Click Repair / Setup.')
    }

    $runBat = Join-Path $root 'server/runtime/run.bat'
    if (Test-Path $runBat) {
        $lines.Add('Forge server: OK')
    } else {
        $lines.Add('Forge server: MISSING - Click Repair / Setup.')
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

    $lines.Add('Reminder: Turn shaders OFF before testing.')
    return ($lines -join [Environment]::NewLine)
}

$form = New-Object System.Windows.Forms.Form
$form.Text = 'CripCraft Launcher'
$form.Size = New-Object System.Drawing.Size(640,430)
$form.StartPosition = 'CenterScreen'
$form.BackColor = [System.Drawing.Color]::FromArgb(14,14,22)
$form.ForeColor = [System.Drawing.Color]::White
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

$banner = New-Object System.Windows.Forms.Panel
$banner.BackColor = [System.Drawing.Color]::FromArgb(16,26,40)
$banner.Size = New-Object System.Drawing.Size(620,92)
$banner.Location = New-Object System.Drawing.Point(0,0)
$form.Controls.Add($banner)

$title = New-Object System.Windows.Forms.Label
$title.Text = 'CRIPCRAFT'
$title.Font = New-Object System.Drawing.Font('Segoe UI',26,[System.Drawing.FontStyle]::Bold)
$title.ForeColor = [System.Drawing.Color]::Aqua
$title.AutoSize = $true
$title.Location = New-Object System.Drawing.Point(205,16)
$banner.Controls.Add($title)

$subtitle = New-Object System.Windows.Forms.Label
$subtitle.Text = 'Forge 1.20.1  |  Dark Neon Local Prototype'
$subtitle.Font = New-Object System.Drawing.Font('Segoe UI',11)
$subtitle.ForeColor = [System.Drawing.Color]::LightGray
$subtitle.AutoSize = $true
$subtitle.Location = New-Object System.Drawing.Point(154,58)
$banner.Controls.Add($subtitle)

$statusBox = New-Object System.Windows.Forms.TextBox
$statusBox.Multiline = $true
$statusBox.ReadOnly = $true
$statusBox.ScrollBars = 'Vertical'
$statusBox.BackColor = [System.Drawing.Color]::FromArgb(24,24,32)
$statusBox.ForeColor = [System.Drawing.Color]::White
$statusBox.Font = New-Object System.Drawing.Font('Consolas',10)
$statusBox.Size = New-Object System.Drawing.Size(560,180)
$statusBox.Location = New-Object System.Drawing.Point(30,150)
$statusBox.Text = "Welcome to CripCraft.`r`nClick Check Files first.`r`nTurn shaders OFF before testing."
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

$playButton = New-CCButton 'Play' 30 105 120
$checkButton = New-CCButton 'Check Files' 170 105 120
$guideButton = New-CCButton 'Open Guide' 310 105 120
$repairButton = New-CCButton 'Repair / Setup' 450 105 140
$exitButton = New-CCButton 'Exit' 450 345 140

$playButton.Add_Click({
    Save-LauncherState 'play'
    $statusBox.Text = "Starting the CripCraft Forge server...`r`nWait for DONE in the server window.`r`nThen open Minecraft Launcher, choose Forge 1.20.1, turn shaders OFF, and join localhost."
    Start-Process -FilePath (Join-Path $root 'scripts/start-server.bat')
})

$checkButton.Add_Click({
    Save-LauncherState 'check'
    $statusBox.Text = Get-CripCraftStatus
})

$guideButton.Add_Click({
    Save-LauncherState 'guide'
    Start-Process -FilePath (Join-Path $root 'README_FIRST.txt')
    $statusBox.Text = "Opened README_FIRST.txt.`r`nFollow the numbered steps."
})

$repairButton.Add_Click({
    Save-LauncherState 'repair'
    $statusBox.Text = "Opening setup/repair script...`r`nIf mod download pages open, download the missing jars and place them into the folders shown."
    Start-Process -FilePath (Join-Path $root 'scripts/setup.bat')
})

$exitButton.Add_Click({
    Save-LauncherState 'exit'
    $form.Close()
})

$form.Controls.AddRange(@($playButton,$checkButton,$guideButton,$repairButton,$exitButton))
[void]$form.ShowDialog()
