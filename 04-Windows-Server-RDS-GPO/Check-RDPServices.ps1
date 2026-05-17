<#
.SYNOPSIS
Checks RDP-related service status and basic port connectivity.

.DESCRIPTION
Checks the Remote Desktop Services service status on a target computer and tests TCP connectivity
to the specified RDP port using Test-NetConnection when available.

.PARAMETER ComputerName
Computer name to check, such as SERVER01.

.PARAMETER Port
TCP port to test. Defaults to 3389.

.EXAMPLE
.\Check-RDPServices.ps1 -ComputerName SERVER01

.EXAMPLE
.\Check-RDPServices.ps1 -ComputerName SERVER01 -Port 3390

.NOTES
Requires permission to query remote services. Port checks require network connectivity.
This script is read-only and does not restart services or change firewall settings.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$ComputerName,

    [Parameter()]
    [ValidateRange(1, 65535)]
    [int]$Port = 3389
)

try {
    $serviceNote = $null
    $service = Get-Service -ComputerName $ComputerName -Name TermService -ErrorAction Stop
}
catch {
    $service = $null
    $serviceNote = "Unable to query TermService: $($_.Exception.Message)"
}

try {
    if (Get-Command Test-NetConnection -ErrorAction SilentlyContinue) {
        $connection = Test-NetConnection -ComputerName $ComputerName -Port $Port -InformationLevel Quiet
        $connectivityNote = if ($connection) { 'Port reachable' } else { 'Port not reachable' }
    }
    else {
        $connection = $null
        $connectivityNote = 'Test-NetConnection is not available on this system'
    }
}
catch {
    $connection = $false
    $connectivityNote = "Port test failed: $($_.Exception.Message)"
}

[PSCustomObject]@{
    ComputerName      = $ComputerName
    TermServiceStatus = if ($service) { $service.Status } else { 'Unknown' }
    Port              = $Port
    PortReachable     = $connection
    Notes             = if ($serviceNote) { "$serviceNote; $connectivityNote" } else { $connectivityNote }
}
