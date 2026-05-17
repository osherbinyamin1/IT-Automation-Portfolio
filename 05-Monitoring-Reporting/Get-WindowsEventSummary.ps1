<#
.SYNOPSIS
Summarizes recent Windows event log errors.

.DESCRIPTION
Uses Get-WinEvent to collect recent events from a specified log and level. The script shortens long
messages for CSV-friendly review while preserving key event metadata.

.PARAMETER ComputerName
One or more computer names to query. Defaults to localhost.

.PARAMETER LogName
Windows event log name to query. Defaults to System.

.PARAMETER Hours
Number of hours back from the current time to search. Defaults to 24.

.PARAMETER Level
Event level display name to include, such as Error, Warning, or Critical. Defaults to Error.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.EXAMPLE
.\Get-WindowsEventSummary.ps1

.EXAMPLE
.\Get-WindowsEventSummary.ps1 -ComputerName SERVER01 -LogName Application -Hours 12 -Level Error

.NOTES
Requires permission to read the target event log.
This script is read-only and does not clear or modify event logs.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [string[]]$ComputerName = @('localhost'),

    [Parameter()]
    [string]$LogName = 'System',

    [Parameter()]
    [ValidateRange(1, 8760)]
    [int]$Hours = 24,

    [Parameter()]
    [ValidateSet('Critical', 'Error', 'Warning', 'Information', 'Verbose')]
    [string]$Level = 'Error',

    [Parameter()]
    [string]$OutputPath
)

$levelMap = @{
    Critical    = 1
    Error       = 2
    Warning     = 3
    Information = 4
    Verbose     = 5
}

$startTime = (Get-Date).AddHours(-$Hours)

$results = foreach ($computer in $ComputerName) {
    try {
        $filter = @{
            LogName   = $LogName
            Level     = $levelMap[$Level]
            StartTime = $startTime
        }

        Get-WinEvent -ComputerName $computer -FilterHashtable $filter -ErrorAction Stop |
            Sort-Object TimeCreated -Descending |
            ForEach-Object {
                $message = ($_.Message -replace '\s+', ' ').Trim()
                if ($message.Length -gt 250) {
                    $message = $message.Substring(0, 247) + '...'
                }

                [PSCustomObject]@{
                    ComputerName     = $computer
                    LogName          = $LogName
                    TimeCreated      = $_.TimeCreated
                    ProviderName     = $_.ProviderName
                    Id               = $_.Id
                    LevelDisplayName = $_.LevelDisplayName
                    Message          = $message
                }
            }
    }
    catch {
        Write-Error -Message "Failed to collect event summary from '$computer' log '$LogName'. $($_.Exception.Message)"
    }
}

if ($OutputPath) {
    $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
}

$results
