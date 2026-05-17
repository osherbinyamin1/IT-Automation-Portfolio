# Monitoring and Reporting Automation

## Purpose

This folder contains reporting scripts for common operational checks: disk capacity, pending reboot indicators, and recent Windows event errors.

## Real-World Scenario

IT administrators often perform recurring checks before patching, after maintenance, or during incident triage. These scripts provide lightweight reports that can be exported to CSV and shared with technical teams.

## Included Files

| File | Description |
| --- | --- |
| `Get-DiskSpaceReport.ps1` | Reports disk usage and threshold status |
| `Get-PendingRebootReport.ps1` | Checks common pending reboot registry indicators |
| `Get-WindowsEventSummary.ps1` | Summarizes recent System or Application errors |

## Example Usage

```powershell
.\Get-DiskSpaceReport.ps1 -ComputerName SERVER01,SERVER02 -OutputPath .\disk-space.csv
.\Get-PendingRebootReport.ps1 -ComputerName SERVER01
.\Get-WindowsEventSummary.ps1 -ComputerName SERVER01 -LogName System -Hours 24
```

## Skills Demonstrated

- Operational reporting with PowerShell
- CIM and registry-based checks
- Windows event log triage
- CSV-friendly object output
- Safe read-only monitoring patterns

## Safety Notes

These scripts are read-only. They do not clear event logs, delete files, reboot systems, or modify registry values. Export paths should be reviewed before running so reports are written only to approved locations.
