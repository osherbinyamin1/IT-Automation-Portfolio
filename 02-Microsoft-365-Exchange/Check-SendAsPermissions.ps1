<#
.SYNOPSIS
Checks Send As permissions for an Exchange Online mailbox or recipient.

.DESCRIPTION
Uses Get-RecipientPermission to report Send As delegation for a mailbox or recipient. The script
returns structured objects that can be reviewed in the console or exported to CSV.

.PARAMETER MailboxIdentity
Mailbox or recipient identity to check, such as shared-mailbox@contoso.com.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.EXAMPLE
.\Check-SendAsPermissions.ps1 -MailboxIdentity shared-mailbox@contoso.com

.EXAMPLE
.\Check-SendAsPermissions.ps1 -MailboxIdentity shared-mailbox@contoso.com -OutputPath .\send-as.csv

.NOTES
Assumes the administrator is already connected to Exchange Online PowerShell.
This script is read-only and does not modify recipient permissions.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$MailboxIdentity,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath
)

try {
    if (-not (Get-Command Get-RecipientPermission -ErrorAction SilentlyContinue)) {
        throw 'Get-RecipientPermission was not found. Connect to Exchange Online PowerShell before running this script.'
    }

    $permissions = Get-RecipientPermission -Identity $MailboxIdentity -ErrorAction Stop |
        Where-Object {
            $_.Trustee -ne 'NT AUTHORITY\SELF' -and
            $_.AccessRights -contains 'SendAs'
        }

    $report = $permissions | Sort-Object Trustee | ForEach-Object {
        [PSCustomObject]@{
            Identity     = $_.Identity.ToString()
            Trustee      = $_.Trustee.ToString()
            AccessRights = ($_.AccessRights -join ';')
            IsInherited  = $_.IsInherited
            Deny         = $_.Deny
        }
    }

    if ($OutputPath) {
        $report | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8 -ErrorAction Stop
    }

    $report
}
catch {
    Write-Error -Message "Failed to check Send As permissions for '$MailboxIdentity'. Confirm Exchange Online connection and permissions. $($_.Exception.Message)"
}
