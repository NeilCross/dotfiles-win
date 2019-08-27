# Init Script for PowerShell

# Install modules
Import-Module PSReadLine
Import-Module posh-git

# custom aliases
function config {& git --git-dir=$HOME/.cfg/ --work-tree=$HOME $args }

# Pre assign the hooks so the first run of cmder gets a working prompt.
[ScriptBlock]$PrePrompt = {}
[ScriptBlock]$PostPrompt = {}
[ScriptBlock]$CmderPrompt = {
    $Host.UI.RawUI.ForegroundColor = "White"
    Microsoft.PowerShell.Utility\Write-Host $pwd.ProviderPath -NoNewLine -ForegroundColor Green
    checkGit($pwd.ProviderPath)
}

<#
This scriptblock runs every time the prompt is returned.
Explicitly use functions from MS namespace to protect from being overridden in the user session.
Custom prompt functions are loaded in as constants to get the same behaviour
#>
[ScriptBlock]$Prompt = {
    $realLASTEXITCODE = $LASTEXITCODE
    $host.UI.RawUI.WindowTitle = Microsoft.PowerShell.Management\Split-Path $pwd.ProviderPath -Leaf
    PrePrompt | Microsoft.PowerShell.Utility\Write-Host -NoNewline
    #CmderPrompt
    Microsoft.PowerShell.Utility\Write-Host $pwd.ProviderPath -NoNewLine -ForegroundColor Green
    Write-VcsStatus
    Microsoft.PowerShell.Utility\Write-Host "`nλ " -NoNewLine -ForegroundColor "DarkGray"
    PostPrompt | Microsoft.PowerShell.Utility\Write-Host -NoNewline
    $global:LASTEXITCODE = $realLASTEXITCODE
    return " "
}

# Once Created these code blocks cannot be overwritten
Set-Item -Path function:\PrePrompt   -Value $PrePrompt #  -Options Constant
Set-Item -Path function:\CmderPrompt -Value $CmderPrompt #-Options Constant
Set-Item -Path function:\PostPrompt  -Value $PostPrompt  #-Options Constant

# Functions can be made constant only at creation time
# ReadOnly at least requires `-force` to be overwritten
Set-Item -Path function:\prompt  -Value $Prompt  #-Options ReadOnly
