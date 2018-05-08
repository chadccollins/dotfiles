<#
    .Synopsis
        Configure VSCode and necessary modules for Dotfiles
    .Description
        Bootstraps the VSCode portion of the Dotfiles Repository
    .Parameter Uninstall
        Removes appropriate installed files outside of the Dotfiles repository.
    .Parameter Confirm
        Approves all prompts
    .Example
        # Run bootstrapper, approving everything
        .\bootstrap.ps1 -Confirm
    .Example
        # Uninstall
        .\bootstrap.ps1 -Uninstall
    .Notes
        Check symlink map for additional information
#>
#Requires -Version 5
#Requires -RunAsAdministrator
[CmdletBinding()]
param(
    [switch]$confirm,
    [switch]$save,
    [switch]$uninstall
)
Begin
{
    $dotfilesModulePath = Resolve-Path (Join-Path $PSScriptRoot ../WindowsPowerShell/Modules-Dotfiles/Dotfiles/Dotfiles.psm1)
    Import-Module -Name $dotfilesModulePath
    Set-StrictMode -Version Latest
}
Process
{
    $ErrorActionPreference = "Stop"

    # Maps: AppData/Roaming/Code/User/* -> $dotfiles/VSCode/*
    $symlinks = @{
        (Join-Path "$env:APPDATA\Code\" "User\") = (Join-Path $PSScriptRoot '');
    }

	if ($save)
	{
		$source = (Join-Path "$env:APPDATA" "Code\User\")
		$dest = $PSScriptRoot
		
		# Copy all the *.json settings files from [User]\AppData\Roaming\Code\User into .
		Get-ChildItem $source -Recurse -Include "*.json" -Exclude "meta.json" | New-Item -ItemType File -Path {Join-Path $dest $_.FullName.Substring($source.Length)} -Force

		# Write out all the install extensions to the 'extensions' file
		code --list-extensions | Out-File .\extensions -Encoding UTF8
	}
    elseif ($uninstall)
    {
        # Delete the symlinks that exist
        $symlinks.Keys | Where-Object { Test-DotfilesSymlink -Path $_ -Target $symlinks[$_] } | Foreach-Object { $_.Delete() }
    }
    else
    {
        # Create symlinks
        $symlinks.Keys | %{ Set-DotfilesSymbolicLink -Path $_ -Target $symlinks[$_] -ErrorAction Stop }

	    # Load up the list of extensions from the file
	    $vscodeExtensions = Get-Content -Path ./extensions

	    # Loop over the list and install each one
        $vscodeExtensions | Foreach-Object {
            Write-Verbose "having VSCode install $_"
            code --install-extension $_
        }
    }
}
