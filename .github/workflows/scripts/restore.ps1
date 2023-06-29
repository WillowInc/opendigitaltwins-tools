param (
    [Parameter(Mandatory=$true)] [string]$githubSource,
    [Parameter(Mandatory=$true)] [string]$githubName,
    [Parameter(Mandatory=$true)] [string]$githubUser,
    [Parameter(Mandatory=$true)] [string]$githubToken
    )

Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"
Import-Module "$PSScriptRoot/common.psm1" -Force
$root = Get-Root

foreach($solution in $(Get-Solutions)) {
    Write-Output "Restoring '$solution' using dotnet command line." 

    push-location $(Split-Path $solution -Parent)
        Show-SDKs

        dotnet nuget remove source $gitHubName
        dotnet nuget add source $githubSource --name $githubName --username $gitHubUser --password $githubToken --store-password-in-clear-text

        dotnet restore $solution /bl:"$solution.restore.binlog" "/flp1:errorsOnly;logfile=$solution.Errors.log"

        if (! $?) {
            $rawError = $(Get-Content -Raw "$solution.Errors.log")
            Write-Error "Failed to restore NuGet packages for $solution. Error: $rawError"
            pop-location
            throw
        }
    pop-location
}

Write-Output "Restored Packages: "
$(get-childitem -Path $root/SmartPlaces.Facilities/packages/ -Directory).FullName
