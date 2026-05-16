# Windows Server, RDS, and GPO Automation

## Purpose

This folder contains scripts and runbooks for Windows Server health reporting, RDP/RDS checks, and Group Policy troubleshooting.

## Real-World Scenario

Support teams often need to triage user reports involving terminal server access, slow logons, policy mapping issues, or basic server health. These examples provide structured first-line and escalation-ready checks.

## Included Files

| File | Description |
| --- | --- |
| `Get-ServerHealthReport.ps1` | Reports uptime, OS, CPU, memory, and disk summary |
| `Check-RDPServices.ps1` | Checks Remote Desktop service status and port connectivity |
| `GPO-Troubleshooting-Checklist.md` | Checklist for Group Policy issues |
| `RDS-Troubleshooting-Runbook.md` | Runbook for common RDS connection issues |

## Example Usage

```powershell
.\Get-ServerHealthReport.ps1 -ComputerName SERVER01,SERVER02 -OutputPath .\server-health.csv
.\Check-RDPServices.ps1 -ComputerName SERVER01
```

## Skills Demonstrated

- Windows Server health checks
- CIM-based reporting
- RDP/RDS service validation
- Group Policy troubleshooting
- Structured runbook documentation

## Safety Notes

The scripts are read-only and do not restart services, modify firewall rules, or change Group Policy.
