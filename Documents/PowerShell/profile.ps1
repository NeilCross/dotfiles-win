# Init Script for PowerShell

# Prompt setup
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme ~\documents\powershell\Paradox.psm1
$DefaultUser = 'Neil Cross'

# Custom aliases
function config {& git --git-dir=$HOME/.cfg/ --work-tree=$HOME $args }
function dwr {& dotnet watch run $args }