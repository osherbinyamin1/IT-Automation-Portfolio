<#
.SYNOPSIS
Exports members of an Active Directory group.

.DESCRIPTION
Returns a CSV-friendly list of members for a specified Active Directory group. The script supports
direct membership or recursive membership when nested groups should be expanded.

.PARAMETER GroupName
Name, SamAccountName, distinguished name, or object GUID of the Active Directory group.

.PARAMETER Recursive
Expands nested group membership recursively.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.EXAMPLE
.\Export-ADGroupMembers.ps1 -GroupName "IT Support"

.EXAMPLE
.\Export-ADGroupMembers.ps1 -GroupName "VPN Users" -Recursive -OutputPath .\vpn-users.csv

.NOTES
Requires the ActiveDirectory PowerShell module and permissions to read group membership.
This script is read-only and does not modify Active Directory.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$GroupName,

    [Parameter()]
    [switch]$Recursive,

    [Parameter()]
    [string]$OutputPath
)

try {
    Import-Module ActiveDirectory -ErrorAction Stop

    $group = Get-ADGroup -Identity $GroupName -ErrorAction Stop
    $memberParameters = @{
        Identity    = $group.DistinguishedName
        ErrorAction = 'Stop'
    }

    if ($Recursive) {
        $memberParameters.Recursive = $true
    }

    $report = Get-ADGroupMember @memberParameters | Sort-Object ObjectClass, Name | ForEach-Object {
        [PSCustomObject]@{
            GroupName         = $group.Name
            Name              = $_.Name
            SamAccountName    = $_.SamAccountName
            ObjectClass       = $_.ObjectClass
            DistinguishedName = $_.DistinguishedName
        }
    }

    if ($OutputPath) {
        $report | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    }

    $report
}
catch {
    Write-Error -Message "Failed to export AD group members for '$GroupName'. $($_.Exception.Message)"
}
