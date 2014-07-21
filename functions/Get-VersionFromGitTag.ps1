function Get-VersionFromGitTag {
    $tag = Get-GitTagOnLastCommit

    $tag | Select-String -Pattern "^v(\d+\.\d+\.\d+(-.+)?)$" |
        Foreach-Object { $_.Matches } | Foreach-Object { $_.Groups[1] } | Select-Object -First 1
}

function Get-GitTagOnLastCommit {
    ($tag = git describe --tags --exact-match) 2> $null
    if ($?) { $tag } else { $null }
}
