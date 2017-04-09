<#
.SYNOPSIS
    This script takes care of loading my powershell profile onto the system I am currently working on.
.DESCRIPTION
    See synopsis.
.EXAMPLE
    Add-Profile
#>



function Add-Profile {
    $Username = $Env:USERNAME
    $ProfilePath = "C:\Users\$Username\Documents\playingwithpowershell\profile\cbbps_profile.ps1"
    # Test the Profile Path
    if (-not (Test-Path -Path $ProfilePath)) {
        Throw 'Could not locate the given profile, check your path..'
    }

    if (-not (Test-Path -Path $profile)) {
        New-Item -Path $profile -force
    }
    # Make sure the 

    Copy-Item -Path $ProfilePath -Destination $profile -Force
}

Add-Profile