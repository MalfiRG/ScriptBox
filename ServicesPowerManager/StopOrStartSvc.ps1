Import-Module "$PSScriptRoot\Start-or-stop-ANY-svc.psm1"

$serviceNamePattern = Read-Host "Please enter the service name pattern (e.g., 'Program*n')"
$services = Get-MatchingServices -Pattern $serviceNamePattern

if ($services.Count -eq 0) {
    Write-Host "No services found matching the pattern. Exiting script." -ForegroundColor Red
    return
}

DisplayServices -Services $services

$action = @('start', 'stop') | Out-GridView -Title "Select an action" -OutputMode Single
PerformActionOnServices -Services $services -Action $action

Write-Host "Operation completed." -ForegroundColor Green

Pause