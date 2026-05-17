<#
.SYNOPSIS
Generates a BitLocker status report for local or remote computers.

.DESCRIPTION
Uses Get-BitLockerVolume locally or through Invoke-Command for remote computers. The script returns
volume status, protection status, encryption percentage, and key protector types in a CSV-friendly
format.

.PARAMETER ComputerName
One or more computer names to check. Defaults to localhost.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.EXAMPLE
.\Get-BitLockerStatusReport.ps1

.EXAMPLE
.\Get-BitLockerStatusReport.ps1 -ComputerName SERVER01,SERVER02 -OutputPath .\bitlocker-status.csv

.NOTES
Requires the BitLocker module on the target computer. Remote checks require PowerShell remoting.
This script is read-only and does not change BitLocker configuration.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string[]]$ComputerName = @('localhost'),

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath
)

$scriptBlock = {
    if (-not (Get-Command Get-BitLockerVolume -ErrorAction SilentlyContinue)) {
        throw 'Get-BitLockerVolume was not found. Confirm the BitLocker module is available on the target computer.'
    }

    Get-BitLockerVolume | ForEach-Object {
        [PSCustomObject]@{
            ComputerName         = $env:COMPUTERNAME
            MountPoint           = $_.MountPoint
            VolumeStatus         = $_.VolumeStatus
            ProtectionStatus     = $_.ProtectionStatus
            EncryptionPercentage = $_.EncryptionPercentage
            KeyProtectorTypes    = ($_.KeyProtector.KeyProtectorType | Sort-Object -Unique) -join ';'
        }
    }
}

$results = foreach ($computer in $ComputerName) {
    try {
        if ($computer -in @('localhost', '.', $env:COMPUTERNAME)) {
            & $scriptBlock
        }
        else {
            Invoke-Command -ComputerName $computer -ScriptBlock $scriptBlock -ErrorAction Stop
        }
    }
    catch {
        Write-Error -Message "Failed to get BitLocker status for '$computer'. $($_.Exception.Message)"
    }
}

if ($OutputPath) {
    $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8 -ErrorAction Stop
}

$results
