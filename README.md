# AppVeyor Scripts

Shared scripts used to configure [AppVeyor](http://www.appveyor.com/).

## Installation

It is recommended to add this repository as a Git submodule of your repository:

```bash
$ git submodule add git@github.com:vtex/appveyor-scripts.git tools/appveyor
```

AppVeyor does not automatically clone submodules, so you need to configure
`appveyor.yml` as such:

```yml
install:
  - cmd: git submodule -q update --init
```

## Usage

Use the scripts in `appveyor.yml`, for example:

```yml
before_build:
  - ps: .\tools\appveyor\scripts\update-build-version.ps1
```

## Development

Unit tests are written using [Pester](https://github.com/pester/Pester). The
easiest way to install it is through [PsGet](http://psget.net/). From a
Powershell console, run:

```powershell
(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
```

Next, install Pester:

```powershell
Install-Module Pester
```

Change directory to the root folder of the repository and run the tests:

```powershell
Invoke-Pester
```
