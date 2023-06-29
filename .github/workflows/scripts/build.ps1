param (
    [Parameter(Mandatory=$true)] [string]$githubSource,
    [Parameter(Mandatory=$true)] [string]$githubName,
    [Parameter(Mandatory=$true)] [string]$githubUser,
    [Parameter(Mandatory=$true)] [string]$githubToken
    )

Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"
Import-Module "$PSScriptRoot/common.psm1" -Force

foreach($solution in $(Get-Solutions)) {
    Write-Output "Building '$solution' using dotnet command line." 

    push-location $(Split-Path $solution -Parent)
        Show-SDKs

        dotnet nuget remove source $gitHubName
        dotnet nuget add source $githubSource --name $githubName --username $gitHubUser --password $githubToken --store-password-in-clear-text

        dotnet build  $solution --no-restore -c Release /bl:"$solution.build.binlog" "/flp1:errorsOnly;logfile=$solution.Errors.log"

        if (! $?) {
            $rawError = $(Get-Content -Raw "$solution.Errors.log")
            Write-Error "Failed to build $solution. Error: $rawError"
            pop-location
            throw
        }
    pop-location
}
