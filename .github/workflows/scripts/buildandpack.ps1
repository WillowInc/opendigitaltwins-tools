param (
    [Parameter(Mandatory=$true)] [string]$githubToken
    )

Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"
Import-Module "$PSScriptRoot/common.psm1" -Force

foreach($solution in $(Get-Solutions)) {
    Write-Output "Building '$solution' using dotnet command line." 

    $rootPath =  $(Split-Path $solution -Parent)

    push-location $rootPath
        Show-SDKs

        dotnet pack $solution --no-restore -c Release /bl:"$solution.build.binlog" "/flp1:errorsOnly;logfile=$solution.Errors.log"
        if (! $?) {
            $rawError = $(Get-Content -Raw "$solution.Errors.log")
            Write-Error "Failed to build $solution. Error: $rawError"
            pop-location
            throw
        }

        dotnet nuget push $rootPath/src/bin/Release/Microsoft.SmartPlaces.Facilities.*.nupkg --api-key "$githubToken" --source "github" --skip-duplicate

        pop-location
}
