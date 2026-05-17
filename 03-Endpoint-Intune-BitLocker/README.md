# Endpoint, Intune, and BitLocker Automation

## Purpose

This folder contains endpoint security and compliance examples focused on BitLocker reporting, Entra ID key escrow validation, and Intune/MDM troubleshooting.

## Real-World Scenario

Endpoint administrators often need to confirm encryption status, verify recovery key escrow, troubleshoot MDM enrollment, and validate compliance policy behavior. These examples provide safe reporting and structured checklist documentation.

## Included Files

| File | Description |
| --- | --- |
| `Get-BitLockerStatusReport.ps1` | Reports BitLocker status for local or remote computers |
| `Backup-BitLockerKey-ToEntra-Runbook.md` | Runbook for validating BitLocker key escrow to Entra ID |
| `Endpoint-Compliance-Checklist.md` | Checklist for common endpoint compliance issues |

## Example Usage

```powershell
.\Get-BitLockerStatusReport.ps1
.\Get-BitLockerStatusReport.ps1 -ComputerName SERVER01 -OutputPath .\bitlocker-status.csv
```

## Skills Demonstrated

- BitLocker operational reporting
- PowerShell remoting concepts
- Entra ID key escrow validation
- Intune enrollment and compliance troubleshooting
- Endpoint administration documentation

## Safety Notes

The included script is reporting-focused. The runbook discusses key escrow validation conceptually and should be followed only with proper administrative authorization. Do not expose recovery keys, device IDs, or tenant-specific details in portfolio material.
