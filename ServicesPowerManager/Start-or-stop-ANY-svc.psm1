<#
.SYNOPSIS
This module provides functions to manage Windows services based on a name pattern.

.DESCRIPTION
The module contains functions to get matching services, display them, and perform actions on them.

.EXAMPLE
# Example usage of the functions in this module:
# Import the module
Import-Module -Name 'Start-or-stop-ANY-svc.psm1'

# Get matching services
$serviceNamePattern = "wuauserv"
$services = Get-MatchingServices -Pattern $serviceNamePattern

# Display the services
DisplayServices -Services $services

# Perform an action on the services
$action = "start"
PerformActionOnServices -Services $services -Action $action

.NOTES
File Name      : Start-or-stop-ANY-svc.psm1
Author         : Piotr Tarach
Prerequisite   : PowerShell V5.0
#>


#region to get matching services based on a pattern

function Get-MatchingServices {
    param (
        [string]$Pattern
    )
    return Get-Service -Name $Pattern -ErrorAction SilentlyContinue
}

#endregion


#region to get matching services based on a pattern

function DisplayServices {
    param (
        [System.ServiceProcess.ServiceController[]]$Services
    )
    Write-Host "Matching services:" -ForegroundColor Blue
    $Services | ForEach-Object {
        Write-Host -NoNewline "$($_.DisplayName) ("
        switch ($_.Status) {
            'Running' { Write-Host -NoNewline "Running" -ForegroundColor Green }
            'Stopped' { Write-Host -NoNewline "Stopped" -ForegroundColor Red }
            default   { Write-Host -NoNewline $_.Status -ForegroundColor Yellow }
        }
        Write-Host ")"
    }
}

#endregion


#region to display services with color-coded statuses

function PerformActionOnServices {
    param (
        [System.ServiceProcess.ServiceController[]]$Services,
        [string]$Action
    )
    try {
        $Services | ForEach-Object {
            Write-Host "Processing service: $($_.DisplayName)"
            if ($Action -eq 'start') {
                $_ | Start-Service
                Write-Host "Successfully started service: $($_.DisplayName)" -ForegroundColor Green
            } elseif ($Action -eq 'stop') {
                $_ | Stop-Service -Force
                Write-Host "Successfully stopped service: $($_.DisplayName)" -ForegroundColor Green
            }
        }
    } catch {
        Write-Host "Error: Could not find or control the service. Stopping the script." -ForegroundColor Red
    }
}

#endregion

# Export functions from this module
Export-ModuleMember -Function Get-MatchingServices, DisplayServices, PerformActionOnServices