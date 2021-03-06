<#
.SYNOPSIS
Sets console transparency

.DESCRIPTION
Adjust the console transparency to a given level

.EXAMPLE
PS> Set-ConsoleTransparency
Sets console transparency to default level of 220

.EXAMPLE
PS> Set-ConsoleTransparency -Off
Disables console transparency

.EXAMPLE
PS> Set-ConsoleTransparency -Level 200
Sets console transparency to the given level

.EXAMPLE
PS> Set-ConsoleTransparency -Persist
Sets console transparency to the predefined level and persist its value for other sessions

.NOTES
This function is only available in Windows

#>

function Set-ConsoleTransparency {
    [CmdletBinding(DefaultParameterSetName = "Level")]
    param(
        [Parameter(Position = 0, ParameterSetName = "Level")]
        [ValidateRange(0, 255)]
        # Set transparency level 
        [int] $Level = (GetConfig('Module.ConsoleTransparency.DefaultLevel')),

        [Parameter(ParameterSetName = "Off")]
        # Disables transparency
        [switch] $Off = $false,

        [Parameter(ParameterSetName = "Level")]
        [Parameter(ParameterSetName = "Off")]
        # Whether to apply this change for future sessions or not
        [switch] $Persist = $false
        )

    if ($Off) {
        $Level = 255
        if ($Persist) {
            $params = @{
                'Context' = { 
                    $configFile = GetConfig('Module.ConsoleTransparency.Config')
                    if ((Test-Path $configFile)) {
                        Remove-Item $configFile
                    }
                }
                'RetryPolicy' = $script:consoleTransparencyRetryPolicy
            }

            Invoke-ScriptBlockWithRetry @params
        }
    }

    if ($Persist -and -not $Off) {
        $config = [PSCustomObject] @{ 'Level' = $Level }
        $transparencyConfigFile = GetConfig('Module.ConsoleTransparency.Config')
        $saveFileDefinition = {
            $config | Export-Clixml -Path $transparencyConfigFile
        }

        $params = @{
            'Context'     = $saveFileDefinition
            'RetryPolicy' = $script:consoleTransparencyRetryPolicy
        }

        Invoke-ScriptBlockWithRetry @params
    }

    $hwnd = (Get-Process -Id $PID).MainWindowHandle
    if ([xUtilityTransparency.Win32Methods]::transparencyLevel -ne 0) {
        [xUtilityTransparency.Win32Methods]::SetWindowTransparent($hwnd, 255)
    }
    
    [xUtilityTransparency.Win32Methods]::SetWindowTransparent($hwnd, $level)
}

Add-Type -Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
namespace xUtilityTransparency
{
    public static class Win32Methods
    {
        internal const int GWL_EXSTYLE = -20;
        internal const int WS_EX_LAYERED = 0x80000;
        internal const int LWA_ALPHA = 0x2;
        internal const int LWA_COLORKEY = 0x1;
        public static int transparencyLevel = 0;
        [DllImport("user32.dll")]
        internal static extern bool SetLayeredWindowAttributes(IntPtr hwnd, uint crKey, byte bAlpha, uint dwFlags);
        [DllImport("user32.dll")]
        internal static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);
        [DllImport("user32.dll")]
        internal static extern int GetWindowLong(IntPtr hWnd, int nIndex);
        public static void SetWindowTransparent(IntPtr hWnd, byte level)
        {
            SetWindowLong(hWnd, GWL_EXSTYLE, GetWindowLong(hWnd, GWL_EXSTYLE) ^ WS_EX_LAYERED);
            SetLayeredWindowAttributes(hWnd, 0, level, LWA_ALPHA);
            transparencyLevel = level;
        }
    }
}
"@

# Initialization code GetConfig('Module.ConsoleTransparency.PolicyName')
$params = @{
    'Policy'       = GetConfig('Module.ConsoleTransparency.PolicyName')
    'Milliseconds' = GetConfig('Module.ConsoleTransparency.WaitTimeMSecs')
    'Retries'      = GetConfig('Module.ConsoleTransparency.RetryTimes')
}

$script:consoleTransparencyRetryPolicy = New-RetryPolicy @params
$transparencyConfigFile = GetConfig('Module.ConsoleTransparency.Config')
if ((Test-Path $transparencyConfigFile)) {
    $fileRetrieval = {
        Import-Clixml -Path $transparencyConfigFile | Write-Output
    }

    $params = @{
        'Context'     = $fileRetrieval
        'RetryPolicy' = $script:consoleTransparencyRetryPolicy
    }

    $transparencyConfig = Invoke-ScriptBlockWithRetry @params
    $windowHandle = (Get-Process -Id $PID).MainWindowHandle
    [xUtilityTransparency.Win32Methods]::SetWindowTransparent($windowHandle, $transparencyConfig.Level)
}
