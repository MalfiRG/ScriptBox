# The name speaks for itself

You can use it to start or stop any service you want, provided you will use a proper mask to match the Service name. 
Our you can just list it. Up to you.

### SYNOPSIS
This module provides functions to manage Windows services based on a name pattern.

### DESCRIPTION
The module contains functions to get matching services, display them, and perform actions on them.

### EXAMPLE
#### Example usage of the functions in this module:
##### Import the module
Import-Module -Name 'Start-or-stop-ANY-svc.psm1'

##### Get matching services
$serviceNamePattern = "wuauserv"
$services = Get-MatchingServices -Pattern $serviceNamePattern

##### Display the services
DisplayServices -Services $services

##### Perform an action on the services
$action = "start"
PerformActionOnServices -Services $services -Action $action

### NOTES
- Author         : Piotr Tarach
- Prerequisite   : PowerShell V5.0

### Recommendation
To allow the script to run smoothly, create a shortcut to _.ps1_ file and set up Execution Policy to _bypass_.

`C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\Path\to\File.ps1"`

### Version 1.0
:construction_worker: :construction: `Under development`:construction:

- To provide cmdlet for Repo registration and script installation in C:\ProgramFiles\Powershell\Scripts
  - It will allow to run in by relative path (only script name)
