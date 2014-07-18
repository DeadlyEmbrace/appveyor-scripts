$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$here\Get-VersionFromGitTag.ps1"

function New-BuildVersion {
    $buildNumber = Get-AppveyorBuildNumber
    $version = Get-VersionFromGitTag

    if ($version) { "$version+$buildNumber" } else { $buildNumber }
}

function Get-AppveyorBuildNumber {
    $env:APPVEYOR_BUILD_NUMBER
}
