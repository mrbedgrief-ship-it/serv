Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot

function Test-CripCraftFiles {
    $messages = New-Object System.Collections.Generic.List[string]
    $java = Get-Command java -ErrorAction SilentlyContinue
    if ($java) { $messages.Add('Java: OK') } else { $messages.Add('Java: MISSING - Install Java 21 first.') }

    $jar = Join-Path $root 'downloads\vanilla-server-1.20.4.jar'
    if (Test-Path $jar) { $messages.Add('Server jar: OK') } else { $messages.Add('Server jar: MISSING - Run scripts\setup.bat.') }

    $templateProps = Join-Path $root 'server\template\server.properties'
    if (Test-Path $templateProps) {
        $offlineReady = Select-String -Path $templateProps -Pattern '^online-mode=false$' -Quiet
        if ($offlineReady) {
            $messages.Add('Local login mode: OK - username verification is disabled for localhost testing.')
        } else {
            $messages.Add('Local login mode: WARNING - template is not set to offline testing.')
        }
    } else {
        $messages.Add('Local login mode: MISSING - server.properties template not found.')
    }

    $datapack = Join-Path $root 'server\world-template\datapacks\cripcraft\pack.mcmeta'
    if (Test-Path $datapack) { $messages.Add('CripCraft datapack: OK') } else { $messages.Add('CripCraft datapack: MISSING') }

    $runtimeProps = Join-Path $root 'server\runtime\server.properties'
    if (Test-Path $runtimeProps) {
        $runtimeOffline = Select-String -Path $runtimeProps -Pattern '^online-mode=false$' -Quiet
        if ($runtimeOffline) {
            $messages.Add('Runtime server folder: READY - offline local testing is enabled.')
        } else {
            $messages.Add('Runtime server folder: READY - click Play once more to rewrite online-mode=false.')
        }
    } else {
        $messages.Add('Runtime server folder: Will be created on first Play click.')
    }

    return ($messages -join [Environment]::NewLine)
}

$form = New-Object System.Windows.Forms.Form
$form.Text = 'CripCraft Launcher'
$form.Size = New-Object System.Drawing.Size(520,380)
$form.StartPosition = 'CenterScreen'
$form.BackColor = [System.Drawing.Color]::FromArgb(18,18,24)
$form.ForeColor = [System.Drawing.Color]::White
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

$title = New-Object System.Windows.Forms.Label
$title.Text = 'CRIPCRAFT'
$title.Font = New-Object System.Drawing.Font('Segoe UI',24,[System.Drawing.FontStyle]::Bold)
$title.ForeColor = [System.Drawing.Color]::Aqua
$title.AutoSize = $true
$title.Location = New-Object System.Drawing.Point(150,20)
$form.Controls.Add($title)

$subtitle = New-Object System.Windows.Forms.Label
$subtitle.Text = 'Dark Neon Local Prototype'
$subtitle.Font = New-Object System.Drawing.Font('Segoe UI',11)
$subtitle.ForeColor = [System.Drawing.Color]::LightGray
$subtitle.AutoSize = $true
$subtitle.Location = New-Object System.Drawing.Point(157,68)
$form.Controls.Add($subtitle)

$output = New-Object System.Windows.Forms.TextBox
$output.Multiline = $true
$output.ReadOnly = $true
$output.ScrollBars = 'Vertical'
$output.BackColor = [System.Drawing.Color]::FromArgb(28,28,36)
$output.ForeColor = [System.Drawing.Color]::White
$output.Size = New-Object System.Drawing.Size(440,130)
$output.Location = New-Object System.Drawing.Point(35,180)
$output.Text = "Welcome to CripCraft.`r`nClick Check Files first."
$form.Controls.Add($output)

function New-LauncherButton($text, $x, $y) {
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $text
    $button.Size = New-Object System.Drawing.Size(180,40)
    $button.Location = New-Object System.Drawing.Point($x,$y)
    $button.BackColor = [System.Drawing.Color]::FromArgb(0,180,200)
    $button.ForeColor = [System.Drawing.Color]::Black
    $button.FlatStyle = 'Flat'
    return $button
}

$playButton = New-LauncherButton 'Play' 35 110
$checkButton = New-LauncherButton 'Check Files' 255 110
$guideButton = New-LauncherButton 'Open Guide' 35 320
$exitButton = New-LauncherButton 'Exit' 255 320

$playButton.Add_Click({
    $output.Text = "Starting CripCraft...`r`nLocal username verification is disabled for this prototype.`r`nWait for the word DONE, then join localhost in Minecraft Java 1.20.4. If needed, try 127.0.0.1."
    Start-Process -FilePath (Join-Path $root 'scripts\start-cripcraft.bat')
})

$checkButton.Add_Click({
    $output.Text = Test-CripCraftFiles
})

$guideButton.Add_Click({
    Start-Process -FilePath (Join-Path $root 'README_FIRST.txt')
    $output.Text = "Opened README_FIRST.txt`r`nFollow the numbered steps."
})

$exitButton.Add_Click({
    $form.Close()
})

$form.Controls.AddRange(@($playButton,$checkButton,$guideButton,$exitButton))
[void]$form.ShowDialog()
