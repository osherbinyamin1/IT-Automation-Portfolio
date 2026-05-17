<#
.SYNOPSIS
Generates a CSV-friendly Active Directory user status report.

.DESCRIPTION
Queries Active Directory users and returns common account status fields used for access reviews,
support checks, and audit preparation. Disabled users are excluded by default unless IncludeDisabled
is specified.

.PARAMETER SearchBase
Optional distinguished name of the OU or container to search, such as OU=Users,DC=contoso,DC=com.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.PARAMETER IncludeDisabled
Includes disabled accounts in the report. By default, only enabled users are returned.

.EXAMPLE
.\Get-ADUserStatusReport.ps1 -OutputPath .\ad-user-status.csv

.EXAMPLE
.\Get-ADUserStatusReport.ps1 -SearchBase "OU=Users,DC=contoso,DC=com" -IncludeDisabled

.NOTES
Requires the ActiveDirectory PowerShell module and permissions to read user objects.
This script is read-only and does not modify Active Directory.
#>
[CmdletBinding()]
param(
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

    $properties = @(
        'Department',
        'Title',
        'LastLogonDate',
        'PasswordLastSet',
        'PasswordNeverExpires',
        'AccountExpirationDate'
    )

    $filter = if ($IncludeDisabled) { '*' } else { 'Enabled -eq $true' }
    $queryParameters = @{
        Filter      = $filter
        Properties  = $properties
        ErrorAction = 'Stop'
    }

    if ($SearchBase) {
        $queryParameters.SearchBase = $SearchBase
    }

    $report = Get-ADUser @queryParameters | Sort-Object SamAccountName | ForEach-Object {
        [PSCustomObject]@{
            SamAccountName       = $_.SamAccountName
            DisplayName          = $_.DisplayName
            Enabled              = $_.Enabled
            Department           = $_.Department
            Title                = $_.Title
            LastLogonDate        = $_.LastLogonDate
            PasswordLastSet      = $_.PasswordLastSet
            PasswordNeverExpires = $_.PasswordNeverExpires
            AccountExpirationDate = $_.AccountExpirationDate
            DistinguishedName    = $_.DistinguishedName
        }
    }

    if ($OutputPath) {
        $report | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8 -ErrorAction Stop
    }

    $report
}
catch {
    Write-Error -Message "Failed to generate AD user status report. $($_.Exception.Message)"
}
