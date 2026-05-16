<#
.SYNOPSIS
Finds inactive Active Directory users based on LastLogonDate.

.DESCRIPTION
Returns enabled and disabled Active Directory user accounts where LastLogonDate is older than the
specified inactivity threshold, or where LastLogonDate is empty. This script is read-only and does
not disable or modify users.

.PARAMETER DaysInactive
Number of days since last logon used to classify a user as inactive. Default is 90.

.PARAMETER SearchBase
Optional distinguished name of the OU or container to search, such as OU=Users,DC=contoso,DC=com.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.EXAMPLE
.\Find-InactiveADUsers.ps1 -DaysInactive 120

.EXAMPLE
.\Find-InactiveADUsers.ps1 -SearchBase "OU=Users,DC=contoso,DC=com" -OutputPath .\inactive-users.csv

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
    [string]$SearchBase,

    [Parameter()]
    [string]$OutputPath
)

try {
    Import-Module ActiveDirectory -ErrorAction Stop

    $cutoffDate = (Get-Date).AddDays(-$DaysInactive)
    $queryParameters = @{
        Filter      = '*'
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
        $report | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    }

    $report
}
catch {
    Write-Error -Message "Failed to find inactive AD users. $($_.Exception.Message)"
}
