$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
$functions = Join-Path (Split-Path -Parent $here) 'functions'
. "$functions\Get-VersionFromGitTag.ps1"

Describe "Get-VersionFromGitTag" {
    Context "When there is no tag on the last commit" {
        Mock Get-GitTagOnLastCommit { return $null }

        It "should return null" {
            Get-VersionFromGitTag | Should Be $null
        }
    }

    Context "When there is an ordinary tag" {
        Mock Get-GitTagOnLastCommit { return "not-a-release-tag" }

        It "should return null" {
            Get-VersionFromGitTag | Should Be $null
        }
    }

    Context "When there is a release tag" {
        Mock Get-GitTagOnLastCommit { return "v1.2.3" }

        It "should return the version" {
            Get-VersionFromGitTag | Should Be "1.2.3"
        }
    }

    Context "When there is a prerelease tag" {
        Mock Get-GitTagOnLastCommit { return "v1.2.3-beta" }

        It "should return the version defined by the prerelease tag" {
            Get-VersionFromGitTag | Should Be "1.2.3-beta"
        }
    }
}
