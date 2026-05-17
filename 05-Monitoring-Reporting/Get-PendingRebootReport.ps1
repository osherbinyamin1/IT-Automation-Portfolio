<#
.SYNOPSIS
Checks common pending reboot indicators.

.DESCRIPTION
Checks registry locations commonly used to indicate pending reboots, including Component Based
Servicing, Windows Update, PendingFileRenameOperations, and SCCM client indicators when detectable.
Remote checks use the .NET remote registry API and handle access errors gracefully.

.PARAMETER ComputerName
One or more computer names to check. Defaults to localhost.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.EXAMPLE
.\Get-PendingRebootReport.ps1

.EXAMPLE
.\Get-PendingRebootReport.ps1 -ComputerName SERVER01,SERVER02 -OutputPath .\pending-reboot.csv

.NOTES
Requires registry access to the target computer.
This script is read-only and does not reboot computers or modify registry values.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [string[]]$ComputerName = @('localhost'),

    [Parameter()]
    [string]$OutputPath
)

function Test-RegistrySubKey {
    param(
        [Parameter(Mandatory)]
        [Microsoft.Win32.RegistryKey]$BaseKey,

        [Parameter(Mandatory)]
        [string]$SubKeyPath
    )

    $subKey = $BaseKey.OpenSubKey($SubKeyPath)
    if ($subKey) {
        $subKey.Close()
        $true
    }
    else {
        $false
    }
}

function Get-RegistryValueExists {
    param(
        [Parameter(Mandatory)]
        [Microsoft.Win32.RegistryKey]$BaseKey,

        [Parameter(Mandatory)]
        [string]$SubKeyPath,

        [Parameter(Mandatory)]
        [string]$ValueName
    )

    $subKey = $BaseKey.OpenSubKey($SubKeyPath)
    if (-not $subKey) {
        return $false
    }

    try {
        $null -ne $subKey.GetValue($ValueName, $null)
    }
    finally {
        $subKey.Close()
    }
}

$results = foreach ($computer in $ComputerName) {
    $baseKey = $null

    try {
        $isLocalComputer = $computer -in @('localhost', '.', $env:COMPUTERNAME)
        $baseKey = if ($isLocalComputer) {
            [Microsoft.Win32.RegistryKey]::OpenBaseKey(
                [Microsoft.Win32.RegistryHive]::LocalMachine,
                [Microsoft.Win32.RegistryView]::Default
            )
        }
        else {
            [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey(
                [Microsoft.Win32.RegistryHive]::LocalMachine,
                $computer
            )
        }

        $cbs = Test-RegistrySubKey -BaseKey $baseKey -SubKeyPath 'SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending'
        $windowsUpdate = Test-RegistrySubKey -BaseKey $baseKey -SubKeyPath 'SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'
        $pendingFileRename = Get-RegistryValueExists -BaseKey $baseKey -SubKeyPath 'SYSTEM\CurrentControlSet\Control\Session Manager' -ValueName 'PendingFileRenameOperations'
        $sccm = Test-RegistrySubKey -BaseKey $baseKey -SubKeyPath 'SOFTWARE\Microsoft\CCM\RebootManagement\RebootData'

        [PSCustomObject]@{
            ComputerName      = $computer
            PendingReboot     = ($cbs -or $windowsUpdate -or $pendingFileRename -or $sccm)
            CBS               = $cbs
            WindowsUpdate     = $windowsUpdate
            PendingFileRename = $pendingFileRename
            SCCM              = $sccm
            Notes             = 'Registry indicators checked'
        }
    }
    catch {
        [PSCustomObject]@{
            ComputerName      = $computer
            PendingReboot     = $null
            CBS               = $null
            WindowsUpdate     = $null
            PendingFileRename = $null
            SCCM              = $null
            Notes             = "Unable to complete registry checks: $($_.Exception.Message)"
        }
    }
    finally {
        if ($baseKey) {
            $baseKey.Close()
        }
    }
}

if ($OutputPath) {
    $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
}

$results
