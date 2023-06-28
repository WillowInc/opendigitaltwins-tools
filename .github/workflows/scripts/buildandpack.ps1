Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"
Import-Module "$PSScriptRoot/common.psm1" -Force

$AZURE_ARTIFACTS_FEED_URL = $env:AZURE_ARTIFACTS_FEED_URL
$NUGET_AUTH_TOKEN = $env:NUGET_AUTH_TOKEN

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

        dotnet nuget push $rootPath/bin/Release/net6.0/Microsoft.SmartPlaces.Facilities.*.nupkg --api-key $NUGET_AUTH_TOKEN --source $AZURE_ARTIFACTS_FEED_URL --skip-duplicate

    pop-location
}
