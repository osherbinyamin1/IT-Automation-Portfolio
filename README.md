# IT Automation Portfolio

This repository is a professional portfolio of practical IT administration automation, reporting scripts, and runbooks. It focuses on common work performed in Windows enterprise environments, Microsoft 365, identity administration, endpoint management, BitLocker, Exchange Online, RDS, GPO, and operational monitoring. The examples are designed to demonstrate safe PowerShell practices, structured output, troubleshooting discipline, and documentation that technical managers can review quickly. The work is intentionally scoped toward hands-on sysadmin and support engineering scenarios rather than exaggerated architecture claims.

## Technologies Covered

- PowerShell scripting and automation
- Active Directory administration
- Microsoft 365 and Exchange Online PowerShell
- Entra ID and endpoint identity concepts
- Intune, MDM, and BitLocker operational workflows
- Windows Server, RDS, GPO, and CIM/WMI reporting
- Windows event log, disk, reboot, and health monitoring

## Portfolio Structure

| Folder | Focus | Example Content |
| --- | --- | --- |
| `01-Active-Directory` | AD user and group reporting | User status, group membership, inactive account reports |
| `02-Microsoft-365-Exchange` | Exchange Online and mailbox operations | Permission checks, cleanup runbook, troubleshooting checklist |
| `03-Endpoint-Intune-BitLocker` | Endpoint security and compliance | BitLocker reporting, key escrow runbook, compliance checklist |
| `04-Windows-Server-RDS-GPO` | Server, RDS, and Group Policy support | Server health, RDP checks, GPO and RDS runbooks |
| `05-Monitoring-Reporting` | General operations reporting | Disk space, pending reboot, Windows event summaries |
| `docs` | Supporting examples | Sanitized sample CSV outputs and screenshot placeholder |

## How to Use This Repository

1. Review the folder README files to understand the scenario and purpose of each script or runbook.
2. Run scripts from an elevated or appropriately permissioned PowerShell session when required by the target system.
3. Connect to required services first, such as Exchange Online PowerShell or an AD management workstation with RSAT tools installed.
4. Use `-OutputPath` parameters to export reports to CSV for review or documentation.
5. Treat scripts as portfolio examples and adapt them carefully for any real environment.

## Security and Privacy Note

All names, domains, sample outputs, and examples in this repository are sanitized and fictional. Do not add real company names, domains, IP addresses, server names, usernames, emails, tenant details, internal data, credentials, or secrets.

## Disclaimer

These scripts and runbooks are sanitized lab and portfolio examples. They are intended to demonstrate practical administration workflows and safe automation patterns. Validate any script in a test environment before using it in production.

## Relevant Roles

This portfolio is relevant for roles such as System Administrator, Microsoft 365 Administrator, IAM Administrator, Cloud Support Engineer, Endpoint Administrator, Help Desk / SysDesk Administrator, and Junior Cloud or Security Administrator.
