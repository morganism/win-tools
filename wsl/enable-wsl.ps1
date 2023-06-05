#--------------------------------------------------------
# Enable WSL
#--------------------------------------------------------
# A Windows Powershell script to enable and setup WSL
# Author: morgan.sziraki@morganism.dev
# Date: Mon  5 Jun 2023 01:36:23 BST
#
#--------------------------------------------------------
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Download and install the Linux distribution
$distro = "Ubuntu"  # Specify the desired distribution (e.g., Ubuntu, Debian)
Invoke-WebRequest -Uri "https://aka.ms/wslstore/$distro" -OutFile "$env:USERPROFILE\$distro.appx"  # Download the distribution package
Add-AppxPackage -Path "$env:USERPROFILE\$distro.appx"  # Install the distribution

# Launch the Linux distribution to complete the initial setup
Start-Process -FilePath "wsl" -ArgumentList "-d $distro" -Wait

# Prompt for username and password
$username = Read-Host -Prompt "Enter a username for the Linux distribution"
$password = Read-Host -Prompt "Enter a password for the Linux distribution" -AsSecureString

# Set the default username and password for the Linux distribution
$credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
wsl -d $distro --user $username --password ($credentials.GetNetworkCredential().Password)

