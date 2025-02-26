#Written by MMKF https://github.com/MichaelK-F/windows-wallpaper-changer
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function setWallpaper {
    Remove-Item -Recurse -Force "$env:APPDATA\Microsoft\Windows\Themes\CachedFiles\"
    Remove-Item -Force "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper"

    $sourceFile = $textBox.Text
    $destinationFile = "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper"

    if (-not $sourceFile -or -not (Test-Path $sourceFile)) {
        [System.Windows.Forms.MessageBox]::Show("Please select a valid wallpaper!", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    try {
        Copy-Item -Path $sourceFile -Destination $destinationFile -Force
        Stop-Process -Name explorer
        [System.Windows.Forms.MessageBox]::Show("Wallpaper set successfully :)", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }

    catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to copy wallpaper: $_", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }

}

function revertWallpaper {
    Remove-Item -Recurse -Force "$env:APPDATA\Microsoft\Windows\Themes\CachedFiles\"
    Remove-Item -Force "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper"
    Stop-Process -Name explorer
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "Wallpaper changer by MMKF"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.Size = New-Object System.Drawing.Size(510, 200)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Select image:"
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(100, 20)
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Enabled = $false
$textBox.Location = New-Object System.Drawing.Point(110, 20)
$textBox.Size = New-Object System.Drawing.Size(280, 20)
$form.Controls.Add($textBox)

$browseButton = New-Object System.Windows.Forms.Button
$browseButton.Text = "Browse"
$browseButton.Location = New-Object System.Drawing.Point(400, 18)
$browseButton.Size = New-Object System.Drawing.Size(80, 25)
$form.Controls.Add($browseButton)

$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Filter = "Image Files (*.jpg;*.jpeg;*.png;*.bmp;*.gif)|*.jpg;*.jpeg;*.png;*.bmp;*.gif"

$browseButton.Add_Click({
    if ($openFileDialog.ShowDialog() -eq "OK") {
        $textBox.Text = $openFileDialog.FileName
    }
})

$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "Set wallpaper"
$button1.Location = New-Object System.Drawing.Point(142.5, 70)
$button1.Size = New-Object System.Drawing.Size(120, 50)
$button1.Add_Click({ setWallpaper })
$form.Controls.Add($button1)

$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "Revert to original wallpaper"
$button2.Location = New-Object System.Drawing.Point(250, 70)
$button2.Size = New-Object System.Drawing.Size(120, 50)
$button2.Add_Click({ revertWallpaper })
$form.Controls.Add($button2)

$label2 = New-Object System.Windows.Forms.Label
$label2.Text = "Made by MMKF - https://mmkf.au/"
$label2.AutoSize = $true
$label2.Location = New-Object System.Drawing.Point(10, 140)
$form.Controls.Add($label2)

$form.ShowDialog()
#Written by MMKF https://github.com/MichaelK-F/windows-wallpaper-changer
