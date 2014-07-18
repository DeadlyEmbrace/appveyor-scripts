$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
$functions = Join-Path (Split-Path -Parent $here) 'functions'
. "$functions\New-BuildVersion.ps1"

Describe "New-BuildVersion" {
    Mock Get-AppveyorBuildNumber { return "42" }

    Context "When it is not possible to get version from Git tag" {
        Mock Get-VersionFromGitTag { return $null }

        It "should return the build number" {
            New-BuildVersion | Should Be "42"
        }
    }

    Context "When version from Git tag is a release" {
        Mock Get-VersionFromGitTag { return "1.2.3" }

        It "should return the version with the build number" {
            New-BuildVersion | Should Be "1.2.3+42"
        }
    }

    Context "When version from Git tag is a prerelease" {
        Mock Get-VersionFromGitTag { return "1.2.3-beta" }

        It "should return the version with the build number" {
            New-BuildVersion | Should Be "1.2.3-beta+42"
        }
    }
}
