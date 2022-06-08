# Init Script for PowerShell

# Install-Module -Name oh-my-posh -Scope CurrentUser

# Prompt setup
Set-PoshPrompt -Theme slimfat

# config setup
function config {& git --git-dir=$HOME/.cfg/ --work-tree=$HOME $args }

'~/documents/powershell/scripts/*.ps1' | gci  | import-module