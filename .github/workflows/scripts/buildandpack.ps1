Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"
Import-Module "$PSScriptRoot/common.psm1" -Force

$AZURE_ARTIFACTS_FEED_URL = $env:AZURE_ARTIFACTS_FEED_URL
$NUGET_AUTH_TOKEN = $env:NUGET_AUTH_TOKEN

foreach($solution in $(Get-Solutions)) {
    Write-Output "Building '$solution' using dotnet command line." 

    push-location $(Split-Path $solution -Parent)
        Show-SDKs

        dotnet pack $solution --no-restore -c Release /bl:"$solution.build.binlog" "/flp1:errorsOnly;logfile=$solution.Errors.log"
        if (! $?) {
            $rawError = $(Get-Content -Raw "$solution.Errors.log")
            Write-Error "Failed to build $solution. Error: $rawError"
            pop-location
            throw
        }

        dotnet nuget push $AZURE_ARTIFACTS_FEED_URL --api-key $NUGET_AUTH_TOKEN --source $(Split-Path $solution -Parent)/bin/Release/net6.0/Microsoft.SmartPlaces.Facilities.*.nupkg --skip-duplicate

    pop-location
}
