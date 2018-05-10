[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification="Literally the PowerShell Host")]
param(
)

<#
Windows PowerShell console (shell) specific profile
#>

Set-StrictMode -Version Latest

function Write-MessageOfTheDay
{
    Write-Output "Hello $env:Username@$env:COMPUTERNAME, how are you today?"
    Write-Output "TODO: Add some useful thing here."
}

function Set-PowerShellHostCustomColor
{
    # Distinguish different types of pipeline messages using custom colors.
    # Helps differentiate between warning/verbose which are both "Yellow" by default

    # Get a reference to the host's color data
    $hostPrivateDataOpts = (Get-Host).PrivateData

    # Green on black; pretty much hidden
    $hostPrivateDataOpts.DebugForegroundColor = "Green"
    $hostPrivateDataOpts.DebugBackgroundColor = "Black"

    # Black on dark gray; brighter than debug
    $hostPrivateDataOpts.VerboseForegroundColor = "Black"
    $hostPrivateDataOpts.VerboseBackgroundColor = "DarkGray"

    # White on yellow;
    $hostPrivateDataOpts.WarningForegroundColor = "DarkGray"
    $hostPrivateDataOpts.WarningBackgroundColor = "Yellow"

    $hostPrivateDataOpts.ErrorForegroundColor = "White"
    $hostPrivateDataOpts.ErrorBackgroundColor = "Red"
}

function Write-StreamColorVariations
{
    # Useful for verifying colors. Writes examples of various textual or logging pipelines.

    # Momento global preferences to work around `-debug` switch starting PS Debugger
    $origDebugPreference = $DebugPreference
    $DebugPreference = 'Continue'

    # Write examples on each textual pipeline
    @('Debug','Verbose','Information','Warning','Error','Host') |
        %{ &"Write-$($_)" $($_) -InformationAction Continue -WarningAction Continue -ErrorAction Continue -Verbose}

    # Reset preferences to momento value
    $DebugPreference = $origDebugPreference

    # Write some related preferences using Write-Information with
    Write-Information @"
Related Preferences
  `$DebugPreference = $DebugPreference
  `$VerbosePreference = $VerbosePreference
  `$InformationPreference = $InformationPreference
  `$WarningPreference = $WarningPreference
  `$ErrorActionPreference = $ErrorActionPreference
  `$ProgressPreference = $ProgressPreference
"@ -InformationAction Continue
}

function Import-DotfilesUserModules
{
    # Chocolatey tab expansion
    $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path($ChocolateyProfile)) {
        Import-Module "$ChocolateyProfile"
    }
}

Write-MessageOfTheDay
Set-PowerShellHostCustomColor
Import-DotfilesUserModules

Set-StrictMode -Off
