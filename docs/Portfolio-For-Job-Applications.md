# IT Automation Portfolio for Job Applications

## Professional Summary

This portfolio demonstrates practical IT administration automation and documentation for Microsoft-focused environments. It includes PowerShell reporting scripts, operational runbooks, and troubleshooting checklists for common tasks across Active Directory, Microsoft 365, Entra ID, Intune/MDM, BitLocker, Exchange Online, Windows Server, RDS, GPO, and endpoint administration.

The work is intentionally focused on realistic sysadmin and support engineering scenarios: validating access, collecting status reports, reviewing endpoint compliance, checking server health, and documenting safe troubleshooting steps. The examples are designed to show careful scripting habits, structured output, and an understanding of how IT teams support users, devices, mailboxes, servers, and identity systems.

## Technical Areas Covered

- Active Directory user and group reporting
- Microsoft 365 and Exchange Online permission checks
- Entra ID and Intune endpoint administration concepts
- BitLocker status reporting and recovery key escrow validation workflows
- Windows Server health checks and operational reporting
- RDS / Terminal Server troubleshooting
- Group Policy troubleshooting and validation
- PowerShell automation with CSV-friendly output and clear error handling

## Highlighted Projects

### Active Directory Reporting

Includes scripts for reviewing user account status, exporting group members, and identifying inactive accounts. These examples support access reviews, account cleanup planning, and help desk escalation documentation.

### Exchange Online Permission Review

Includes scripts to check mailbox FullAccess and Send As permissions. These are useful for troubleshooting shared mailbox access, delegation issues, and permission review requests.

### Endpoint, Intune, and BitLocker Operations

Includes a BitLocker status reporting script and runbooks/checklists for endpoint compliance and recovery key escrow validation. The focus is on safe validation, not exposing recovery keys or sensitive device information.

### Windows Server, RDS, and GPO Support

Includes server health reporting, RDP service checks, an RDS troubleshooting runbook, and a Group Policy troubleshooting checklist. These examples reflect common support scenarios such as user connection issues, slow logons, and policy application problems.

### Monitoring and Reporting

Includes scripts for disk space reporting, pending reboot checks, and recent Windows event summaries. These examples show practical operational reporting that can help with maintenance, patching preparation, and incident triage.

## Repository Structure

| Folder | Purpose |
| --- | --- |
| `01-Active-Directory` | AD user, group, and inactive account reporting |
| `02-Microsoft-365-Exchange` | Exchange Online permission checks and mailbox troubleshooting |
| `03-Endpoint-Intune-BitLocker` | Endpoint compliance, BitLocker status, and key escrow runbooks |
| `04-Windows-Server-RDS-GPO` | Windows Server health, RDS checks, and GPO troubleshooting |
| `05-Monitoring-Reporting` | Disk, reboot, and Windows event reporting |
| `docs` | Sample outputs and job-application portfolio material |

## Security & Privacy

All scripts, examples, and sample outputs are sanitized for portfolio use. The repository does not include real company names, domains, IP addresses, server names, usernames, email addresses, credentials, secrets, tenant details, recovery keys, or internal data.

The scripts are mostly read-only and reporting-focused. Any real-world use would require review, testing, and approval within the target environment. The examples are intended to demonstrate practical administration skills and safe automation habits, not claim ownership of full enterprise architecture or production systems.

## Suitable Roles

This portfolio is relevant for roles such as System Administrator, Microsoft 365 Administrator, IAM Administrator, Cloud Support Engineer, Endpoint Administrator, Help Desk / SysDesk Administrator, and Junior Cloud or Security Administrator.
