# Microsoft 365 and Exchange Automation

## Purpose

This folder contains scripts and runbooks for Exchange Online mailbox permission checks and common Microsoft 365 mailbox troubleshooting workflows.

## Real-World Scenario

Administrators frequently validate mailbox permissions, Send As delegation, mailbox storage usage, Outlook behavior, and mail flow issues. These examples show practical, safe ways to collect evidence and document troubleshooting steps.

## Included Files

| File | Description |
| --- | --- |
| `Check-MailboxPermissions.ps1` | Checks FullAccess mailbox permissions |
| `Check-SendAsPermissions.ps1` | Checks Send As permissions |
| `Mailbox-Cleanup-Runbook.md` | Safe mailbox cleanup process |
| `Exchange-Troubleshooting-Checklist.md` | Checklist for common Exchange and Outlook issues |

## Example Usage

```powershell
Connect-ExchangeOnline -UserPrincipalName admin@contoso.com
.\Check-MailboxPermissions.ps1 -MailboxIdentity shared-mailbox@contoso.com -OutputPath .\mailbox-permissions.csv
.\Check-SendAsPermissions.ps1 -MailboxIdentity shared-mailbox@contoso.com -OutputPath .\send-as.csv
```

## Skills Demonstrated

- Exchange Online PowerShell usage
- Permission review and delegation troubleshooting
- Structured operational runbooks
- CSV-friendly reporting
- Microsoft 365 support workflows

## Safety Notes

The included scripts are read-only and assume you are already connected to Exchange Online PowerShell. The runbooks avoid destructive purge commands as default actions and emphasize compliance review before cleanup. Sanitize mailbox names and user details before sharing any exported report.
