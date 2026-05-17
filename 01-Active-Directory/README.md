# Active Directory Automation

## Purpose

This folder contains PowerShell examples for common Active Directory reporting tasks used in account reviews, access validation, and support troubleshooting.

## Real-World Scenario

An IT administrator may need to review user account status, export group membership, or identify inactive accounts before an access cleanup project. These scripts provide repeatable, CSV-friendly reports using the Active Directory PowerShell module.

## Included Files

| File | Description |
| --- | --- |
| `Get-ADUserStatusReport.ps1` | Reports AD user status and account metadata |
| `Export-ADGroupMembers.ps1` | Exports members of a specified AD group |
| `Find-InactiveADUsers.ps1` | Finds enabled users inactive for a configurable number of days |

## Example Usage

```powershell
.\Get-ADUserStatusReport.ps1 -SearchBase "OU=Users,DC=contoso,DC=com" -OutputPath .\ad-user-status.csv
.\Export-ADGroupMembers.ps1 -GroupName "IT Support" -Recursive -OutputPath .\group-members.csv
.\Find-InactiveADUsers.ps1 -DaysInactive 90 -OutputPath .\inactive-users.csv
.\Find-InactiveADUsers.ps1 -DaysInactive 180 -IncludeDisabled -OutputPath .\inactive-users-all.csv
```

## Skills Demonstrated

- Active Directory reporting with PowerShell
- RSAT / ActiveDirectory module usage
- Parameterized scripts
- Safe read-only account review
- CSV-friendly object output

## Safety Notes

These scripts are read-only. They do not disable, delete, move, or modify AD accounts or groups.
