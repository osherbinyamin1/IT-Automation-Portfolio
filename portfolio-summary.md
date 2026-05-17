# IT Automation Portfolio Summary

## Professional Summary

I am an IT / SysDesk Administrator with hands-on experience supporting Windows-based business environments, Microsoft 365, Active Directory, Entra ID, Intune/MDM, BitLocker, Exchange Online, Windows Server, RDS/Terminal Servers, GPO, endpoint administration, and PowerShell troubleshooting. This portfolio demonstrates practical automation and documentation patterns for common administration tasks: reporting, access validation, health checks, endpoint compliance review, and structured troubleshooting.

The repository is intended for recruiters and technical reviewers who want to see how I approach realistic operational scenarios. It emphasizes readable scripts, safe defaults, CSV-friendly output, clear runbooks, and sanitized examples that can be reviewed without exposing real organization data.

## Key Technical Areas

- Active Directory user and group reporting
- Exchange Online mailbox permission validation
- Microsoft 365 mailbox cleanup and troubleshooting workflows
- Endpoint compliance and BitLocker operational checks
- Windows Server health, RDS connectivity, and GPO troubleshooting
- Monitoring reports for disk space, pending reboots, and Windows events
- PowerShell object output, error handling, and reusable parameters

## Highlighted Project 1: Active Directory User Status Reporting

### Business / IT Scenario

IT teams often need a quick and reliable way to review user account status during audits, onboarding reviews, access cleanup, or troubleshooting. Manual checks in ADUC can be slow and inconsistent when reviewing many users.

### What the Automation Does

`Get-ADUserStatusReport.ps1` generates a CSV-friendly report of Active Directory users with useful account details such as enabled state, department, title, last logon date, password status, account expiration, and distinguished name. The script supports optional search base filtering and optional CSV export.

### Technologies Used

- PowerShell
- Active Directory module
- `Get-ADUser`
- CSV reporting

### Example Use Case

A sysadmin can export user account status from a specific OU before an access review and provide the output to a manager or senior administrator for validation.

### Value Delivered

This reduces manual lookup time, standardizes the report format, and creates a repeatable process that can be reused during audits and cleanup activities.

## Highlighted Project 2: Exchange Online Mailbox Permission Checks

### Business / IT Scenario

Mailbox delegation issues are common in Microsoft 365 environments. Users may report that they cannot access a shared mailbox, cannot send as another mailbox, or still have permissions after a role change.

### What the Automation Does

`Check-MailboxPermissions.ps1` reviews FullAccess permissions for a mailbox, while `Check-SendAsPermissions.ps1` checks Send As permissions. Both scripts assume the administrator is already connected to Exchange Online PowerShell and return structured output that can be exported to CSV.

### Technologies Used

- Exchange Online PowerShell
- `Get-MailboxPermission`
- `Get-RecipientPermission`
- PowerShell filtering and object output

### Example Use Case

An administrator can quickly validate who has access to `shared-mailbox@contoso.com` before troubleshooting Outlook behavior or approving a permission cleanup request.

### Value Delivered

The scripts make permission review faster, easier to document, and less dependent on manual portal navigation.

## Highlighted Project 3: BitLocker Status and Key Escrow Validation

### Business / IT Scenario

Endpoint administrators need confidence that devices are encrypted and that recovery keys are safely escrowed before device handoff, hardware repair, or compliance review.

### What the Automation / Runbook Does

`Get-BitLockerStatusReport.ps1` reports BitLocker volume status locally or remotely. `Backup-BitLockerKey-ToEntra-Runbook.md` documents a safe validation process for checking protectors, identifying recovery password protectors, and confirming key escrow in Entra ID.

### Technologies Used

- PowerShell
- BitLocker module
- `Get-BitLockerVolume`
- PowerShell remoting
- Entra ID / Intune operational concepts

### Example Use Case

An endpoint administrator can check a device group for encryption status and confirm that the expected recovery key workflow is in place before marking a device as compliant.

### Value Delivered

The workflow supports endpoint security operations, reduces risk during recovery scenarios, and improves audit readiness.

## Highlighted Project 4: Windows Server and RDS Health Checks

### Business / IT Scenario

RDS and Windows Server issues can affect many users at once. Support teams need a structured way to check server health, RDP services, uptime, memory, disk state, and connectivity before escalating.

### What the Automation / Runbook Does

`Get-ServerHealthReport.ps1` generates a basic server health report using CIM. `Check-RDPServices.ps1` checks the Remote Desktop service and basic port connectivity. `RDS-Troubleshooting-Runbook.md` provides a step-by-step troubleshooting flow for user connection issues.

### Technologies Used

- PowerShell
- CIM cmdlets
- Windows services
- `Test-NetConnection`
- RDS and Windows Server troubleshooting concepts

### Example Use Case

A support engineer can check `SERVER01` after users report intermittent connection failures and quickly separate service, network, profile, and policy-related causes.

### Value Delivered

This improves triage speed, creates consistent troubleshooting steps, and helps document evidence before escalation.

## Highlighted Project 5: Monitoring and Operational Reporting

### Business / IT Scenario

Routine operational checks help prevent avoidable incidents, especially around disk capacity, pending reboots, and repeated Windows errors.

### What the Automation Does

The monitoring scripts report disk free space, common pending reboot indicators, and recent Windows event errors. Each script is designed to return objects that can be displayed, filtered, or exported to CSV.

### Technologies Used

- PowerShell
- CIM
- Registry checks
- Windows Event Log
- CSV reporting

### Example Use Case

A sysadmin can run weekly checks against a small server list and produce a simple report showing systems needing attention.

### Value Delivered

The scripts support proactive maintenance, reduce repetitive manual checks, and provide a foundation for more advanced monitoring later.

## Notes for Recruiters and Technical Reviewers

This portfolio is intended to show practical IT administration habits: safe automation, clear documentation, structured troubleshooting, and realistic Microsoft ecosystem scenarios. The scripts are mostly read-only by design and focus on reporting, validation, and support workflows. They are portfolio/lab examples, not full production frameworks. All examples use fictional data and generic names, so the repository can be reviewed publicly without exposing employer or customer information.
