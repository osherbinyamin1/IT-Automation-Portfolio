<#
.SYNOPSIS
Generates a basic Windows Server health report.

.DESCRIPTION
Collects operating system, uptime, CPU load, memory, and disk summary information from one or more
computers using CIM cmdlets. The output is designed for quick review or CSV export.

.PARAMETER ComputerName
One or more computer names to query. Defaults to localhost.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.EXAMPLE
.\Get-ServerHealthReport.ps1

.EXAMPLE
.\Get-ServerHealthReport.ps1 -ComputerName SERVER01,SERVER02 -OutputPath .\server-health.csv

.NOTES
Requires network access and permissions for remote CIM queries.
This script is read-only and does not modify target computers.
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

$results = foreach ($computer in $ComputerName) {
    try {
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer -ErrorAction Stop
        $processor = Get-CimInstance -ClassName Win32_Processor -ComputerName $computer -ErrorAction Stop |
            Measure-Object -Property LoadPercentage -Average
        $disks = Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName $computer -Filter "DriveType=3" -ErrorAction Stop

        $lastBoot = $os.LastBootUpTime
        $uptimeDays = [math]::Round(((Get-Date) - $lastBoot).TotalDays, 2)
        $diskSummary = ($disks | ForEach-Object {
            $sizeGb = [math]::Round($_.Size / 1GB, 2)
            $freeGb = [math]::Round($_.FreeSpace / 1GB, 2)
            "$($_.DeviceID) $freeGb GB free of $sizeGb GB"
        }) -join '; '

        [PSCustomObject]@{
            ComputerName   = $computer
            OSCaption      = $os.Caption
            LastBootUpTime = $lastBoot
            UptimeDays     = $uptimeDays
            CPULoad        = if ($null -ne $processor.Average) { [math]::Round($processor.Average, 2) } else { $null }
            TotalMemoryGB  = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
            FreeMemoryGB   = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
            DiskSummary    = $diskSummary
        }
    }
    catch {
        Write-Error -Message "Failed to collect server health for '$computer'. $($_.Exception.Message)"
    }
}

if ($OutputPath) {
    $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8 -ErrorAction Stop
}

$results
