$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
$functions = Join-Path (Split-Path -Parent $here) 'functions'
. "$functions\New-BuildVersion.ps1"

if ($env:APPVEYOR) {
    Push-Location $env:APPVEYOR_BUILD_FOLDER

    $version = New-BuildVersion
    Write-Host "Updating build version to $version"
    Update-AppveyorBuild -Version $version

    Pop-Location
}
