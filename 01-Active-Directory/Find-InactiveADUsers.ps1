<#
.SYNOPSIS
Finds inactive Active Directory users based on LastLogonDate.

.DESCRIPTION
Returns enabled Active Directory user accounts where LastLogonDate is older than the specified
inactivity threshold, or where LastLogonDate is empty. Disabled users can be included with the
IncludeDisabled switch. This script is read-only and does not disable or modify users.

.PARAMETER DaysInactive
Number of days since last logon used to classify a user as inactive. Default is 90.

.PARAMETER SearchBase
Optional distinguished name of the OU or container to search, such as OU=Users,DC=contoso,DC=com.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.PARAMETER IncludeDisabled
Includes disabled accounts in the inactive user report. By default, only enabled users are returned.

.EXAMPLE
.\Find-InactiveADUsers.ps1 -DaysInactive 120

.EXAMPLE
.\Find-InactiveADUsers.ps1 -SearchBase "OU=Users,DC=contoso,DC=com" -OutputPath .\inactive-users.csv

.EXAMPLE
.\Find-InactiveADUsers.ps1 -DaysInactive 180 -IncludeDisabled

.NOTES
Requires the ActiveDirectory PowerShell module and permissions to read user objects.
Read-only only: this script does not disable, move, or delete accounts.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [ValidateRange(1, 3650)]
    [int]$DaysInactive = 90,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$SearchBase,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath,

    [Parameter()]
    [switch]$IncludeDisabled
)

try {
    Import-Module ActiveDirectory -ErrorAction Stop

    $cutoffDate = (Get-Date).AddDays(-$DaysInactive)
    $filter = if ($IncludeDisabled) { '*' } else { 'Enabled -eq $true' }
    $queryParameters = @{
        Filter      = $filter
        Properties  = @('LastLogonDate')
        ErrorAction = 'Stop'
    }

    if ($SearchBase) {
        $queryParameters.SearchBase = $SearchBase
    }

    $report = Get-ADUser @queryParameters |
        Where-Object { -not $_.LastLogonDate -or $_.LastLogonDate -lt $cutoffDate } |
        Sort-Object LastLogonDate, SamAccountName |
        ForEach-Object {
            $daysSinceLastLogon = if ($_.LastLogonDate) {
                [int]((Get-Date) - $_.LastLogonDate).TotalDays
            }
            else {
                $null
            }

            [PSCustomObject]@{
                SamAccountName       = $_.SamAccountName
                DisplayName          = $_.DisplayName
                Enabled              = $_.Enabled
                LastLogonDate        = $_.LastLogonDate
                DaysSinceLastLogon   = $daysSinceLastLogon
                DistinguishedName    = $_.DistinguishedName
            }
        }

    if ($OutputPath) {
        $report | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8 -ErrorAction Stop
    }

    $report
}
catch {
    Write-Error -Message "Failed to find inactive AD users. $($_.Exception.Message)"
}
