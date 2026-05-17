<#
.SYNOPSIS
Checks FullAccess permissions for an Exchange Online mailbox.

.DESCRIPTION
Uses Get-MailboxPermission to report explicit mailbox permissions. The script filters out the
default NT AUTHORITY\SELF entry where appropriate and returns CSV-friendly objects.

.PARAMETER MailboxIdentity
Mailbox identity to check, such as shared-mailbox@contoso.com.

.PARAMETER OutputPath
Optional path where the report should be exported as a CSV file.

.EXAMPLE
.\Check-MailboxPermissions.ps1 -MailboxIdentity shared-mailbox@contoso.com

.EXAMPLE
.\Check-MailboxPermissions.ps1 -MailboxIdentity shared-mailbox@contoso.com -OutputPath .\mailbox-permissions.csv

.NOTES
Assumes the administrator is already connected to Exchange Online PowerShell.
This script is read-only and does not modify mailbox permissions.
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
    if (-not (Get-Command Get-MailboxPermission -ErrorAction SilentlyContinue)) {
        throw 'Get-MailboxPermission was not found. Connect to Exchange Online PowerShell before running this script.'
    }

    $permissions = Get-MailboxPermission -Identity $MailboxIdentity -ErrorAction Stop |
        Where-Object {
            $_.User -ne 'NT AUTHORITY\SELF' -and
            $_.AccessRights -contains 'FullAccess'
        }

    $report = $permissions | Sort-Object User | ForEach-Object {
        [PSCustomObject]@{
            Mailbox      = $MailboxIdentity
            User         = $_.User.ToString()
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
    Write-Error -Message "Failed to check mailbox permissions for '$MailboxIdentity'. Confirm Exchange Online connection and permissions. $($_.Exception.Message)"
}
