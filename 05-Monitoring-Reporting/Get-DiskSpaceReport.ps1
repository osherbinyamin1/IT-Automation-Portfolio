<#
.SYNOPSIS
Reports disk usage for local or remote computers.

.DESCRIPTION
Uses CIM to collect fixed disk size and free space information. Each volume is classified as OK,
Warning, or Critical based on the configured free space threshold.

.PARAMETER ComputerName
One or more computer names to query. Defaults to localhost.

.PARAMETER MinimumFreePercent
Warning threshold for free disk percentage. Default is 15.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.EXAMPLE
.\Get-DiskSpaceReport.ps1

.EXAMPLE
.\Get-DiskSpaceReport.ps1 -ComputerName SERVER01,SERVER02 -MinimumFreePercent 20 -OutputPath .\disk-space.csv

.NOTES
Requires network access and permissions for remote CIM queries.
This script is read-only and does not delete files or modify disks.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [string[]]$ComputerName = @('localhost'),

    [Parameter()]
    [ValidateRange(1, 99)]
    [int]$MinimumFreePercent = 15,

    [Parameter()]
    [string]$OutputPath
)

$criticalThreshold = [math]::Max([math]::Floor($MinimumFreePercent / 2), 1)

$results = foreach ($computer in $ComputerName) {
    try {
        Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName $computer -Filter "DriveType=3" -ErrorAction Stop |
            ForEach-Object {
                $sizeGb = [math]::Round($_.Size / 1GB, 2)
                $freeGb = [math]::Round($_.FreeSpace / 1GB, 2)
                $freePercent = if ($_.Size -gt 0) {
                    [math]::Round(($_.FreeSpace / $_.Size) * 100, 2)
                }
                else {
                    0
                }

                $status = if ($freePercent -le $criticalThreshold) {
                    'Critical'
                }
                elseif ($freePercent -le $MinimumFreePercent) {
                    'Warning'
                }
                else {
                    'OK'
                }

                [PSCustomObject]@{
                    ComputerName = $computer
                    DriveLetter  = $_.DeviceID
                    SizeGB       = $sizeGb
                    FreeGB       = $freeGb
                    FreePercent  = $freePercent
                    Status       = $status
                }
            }
    }
    catch {
        Write-Error -Message "Failed to collect disk space for '$computer'. $($_.Exception.Message)"
    }
}

if ($OutputPath) {
    $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
}

$results
