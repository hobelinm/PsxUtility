# PsxUtility
> Extended Utilities for PowerShell

Version: **`v2.1.3`**
Release: **`4-LOM`**

```
Major.Minor.Build
  |     |     |_____ Small fixes
  |     |___________ New features, publish to PowerShell gallery
  |_________________ Major ship releases
```

## What is PsxUtility?
PxsUtility is a project for creating extended Utilities for PowerShell wrapping common functionality on `xUtility` module. 
This module is available for download from the [PowerShell Gallery](https://www.powershellgallery.com/)

## Available Utilities
- [x] Retry Block with Retry Policy Cmdlet
  - [Invoke-ScriptBlockWithRetry](https://github.com/hobelinm/PsxUtility/blob/master/Main/Invoke-ScriptBlockWithRetry.ps1)
  - [New-RetryPolicy](https://github.com/hobelinm/PsxUtility/blob/master/Main/New-RetryPolicy.ps1)
- [x] Execution block with Expiring Cache Cmdlets.
  - [Add-ExpiringCacheItem](https://github.com/hobelinm/PsxUtility/blob/master/Main/Add-ExpiringCacheItem.ps1)
  - [Get-ExpiringCacheItem](https://github.com/hobelinm/PsxUtility/blob/master/Main/Get-ExpiringCacheItem.ps1)
  - [Remove-ExpiringCacheItem](https://github.com/hobelinm/PsxUtility/blob/master/Main/Remove-ExpiringCacheItem.ps1)
- [x] Custom and Extensible Prompt. 
  - [Set-Prompt](https://github.com/hobelinm/PsxUtility/blob/master/Main/Set-Prompt.ps1)
- [x] Window Title Cmdlets. 
  - [Set-Title](https://github.com/hobelinm/PsxUtility/blob/master/Main/Set-Title.ps1)
- [x] Window Transparency Cmdlet. 
  - [Set-ConsoleTransparency](https://github.com/hobelinm/PsxUtility/blob/master/Main/Set-ConsoleTransparency.ps1)
- [x] Window Resizing Cmdlet. 
  - [Get-WindowSize](https://github.com/hobelinm/PsxUtility/blob/master/Main/Get-WindowSize.ps1)
  - [Set-WindowSize](https://github.com/hobelinm/PsxUtility/blob/master/Main/Set-WindowSize.ps1)
- [x] Admin Detection and Elevation. 
  - [Test-AdminRights](https://github.com/hobelinm/PsxUtility/blob/master/Main/Test-AdminRights.ps1)
  - [Invoke-PSCommand](https://github.com/hobelinm/PsxUtility/blob/master/Main/Invoke-PSCommand.ps1)
- [x] Enable symbolic link behavior. 
  - [Set-SymbolicLinkBehavior](https://github.com/hobelinm/PsxUtility/blob/master/Main/Set-SymbolicLinkBehavior.ps1)
- [x] General utilities. 
  - [Start-SublimeText](https://github.com/hobelinm/PsxUtility/blob/master/Main/Start-SublimeText.ps1)
- [x] Display formatting cmdlets: Coloring words, rows
  - [New-ConsoleColorSet](https://github.com/hobelinm/PsxUtility/blob/master/Main/New-ConsoleColorSet.ps1)
  - [Out-ColorFormat](https://github.com/hobelinm/PsxUtility/blob/master/Main/Out-ColorFormat.ps1)
- [x] Check for updates
- [x] Inline progress function
- [ ]Additional Package Manager(?)

## How to get it:
- [xUtility in the PowerShell Gallery](https://www.powershellgallery.com/packages/xUtility)

````
PS> Install-Module -Name xUtility
PS> Import-Module -Name xUtility
````

## TO DO Items:
- Report upstream logging/analytics from all cmdlets
- Add post documentation for the multiple features
- Repository and plugins for customizable prompts
* Users are able to discover and install custom prompts with provided cmdlets
* Provide few examples like Git based custom prompts
* Users are able to contribute to repository
- Format-Table equivalent with real-time user provided updates
- Write tests
- Retry policy objects should be classes now

Additional features will be added over time

## Change Log

````
Version - Release - Description
------- - ------- - ------------
2.1.3   - 4-LOM   - Disabling ConfigHive to avoid compatibility issues
2.1.2   - 4-LOM   - Custom prompt is optional, integration with ConfigHive, checks for newer PS Versions
2.1.1   - 4-LOM   - Updated New-ConsoleColorSet and Out-ColorFormat, initial introduction of class based Retry policies
2.1.0   - 4-LOM   - Minor fixes released for PowerShell gallery
2.0.8   - 2-1B    - Created OS-independent functions for getting Temp and AppData folders
2.0.7   - 2-1B    - Fixed pre-load script logic
2.0.6   - 2-1B    - Custom error class
2.0.5   - 2-1B    - Updated expiring cache to support custom cache refresh triggering via [ScriptBlock]
2.0.4   - 2-1B    - Fixed path composition logic, coloring for Linux terminals
2.0.3   - 2-1B    - Check for null before attempting to use the variable
2.0.2   - 2-1B    - Initial fixes to enhance compatibility with Linux OS
2.0.1   - 2-1B    - Check for updates periodically, Write-InlineProgress cmdlet
2.0.0   - 2-1B    - Support for MacOS in addition to Windows OS
````
