<#
.SYNOPSIS
Opens a given target (file or directory) in Sublime Text

.DESCRIPTION
Opens a given target (file or directory) in Sublime Text.
If Sublime Text installation folder is not found in the system it opens Sublme Text Home Page

#>

function Start-SublimeText
{
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $Target = ""
        )

    $ErrorActionPreference = 'Stop'
    $sublimePath = Join-Path -Path $env:ProgramFiles -ChildPath "Sublime Text 3"
    if (-not (Test-Path $sublimePath)) {
        Start-Process 'http://www.sublimetext.com/3'
        Write-Error '[Start-SublimeText] Sublime Text 3 is not installed on the system'
    }

    $sublimeExe = [System.IO.FileInfo] (Join-Path -Path $sublimePath -ChildPath 'subl.exe')
    . $sublimeExe $Target
}

Set-Alias sublime Start-SublimeText