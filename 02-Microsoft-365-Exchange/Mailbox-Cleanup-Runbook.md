# Mailbox Cleanup Runbook

## Purpose

Provide a safe, documented process for reviewing and reducing mailbox storage usage in Microsoft 365 without making destructive purge actions the default approach.

## Symptoms

- User receives mailbox quota warnings.
- Outlook or OWA reports limited available storage.
- Mailbox search, sync, or send/receive performance is degraded.
- Large folders such as Deleted Items, Sent Items, Archive, or Inbox contain old or oversized messages.

## Initial Checks

1. Confirm the affected mailbox identity, such as `user@contoso.com`.
2. Check mailbox storage usage in the Microsoft 365 admin center or Exchange admin center.
3. Review whether the mailbox has an archive mailbox enabled.
4. Confirm whether retention policies, litigation hold, eDiscovery hold, or Purview retention settings apply.
5. Validate whether the issue affects OWA, Outlook desktop, or both.

## OWA Storage Cleanup

1. Ask the user to sign in to Outlook on the web.
2. Open mailbox storage settings.
3. Review large folders such as Deleted Items, Sent Items, Inbox, and Archive.
4. Sort mail by size and age where appropriate.
5. Move business records to approved storage locations if required by policy.
6. Empty Deleted Items only after confirming the user understands the impact and organizational policy allows it.

## Retention Considerations

- Confirm the mailbox is not subject to retention requirements that prevent deletion.
- Review organization policy before advising users to delete old mail.
- Archive may be preferable to deletion where long-term retention is required.
- Managed Folder Assistant and retention labels may affect when items move or expire.

## eDiscovery / Purview Considerations

- Mailboxes involved in legal, HR, audit, or compliance reviews may be under hold.
- Do not purge or permanently delete content without compliance approval.
- If a mailbox is on hold, visible deletion may not reduce backend storage as expected.
- Coordinate with compliance, legal, or security teams before taking high-impact actions.

## Compliance Warning

Do not run destructive purge actions as a default cleanup step. Permanent deletion can violate retention, legal hold, or business record requirements. Escalate to the appropriate compliance owner before any irreversible action.

## Validation Steps

1. Recheck mailbox storage usage after cleanup.
2. Confirm whether quota warnings are resolved.
3. Test OWA and Outlook behavior.
4. Confirm archive status if archive was part of the remediation.
5. Document the actions taken, user approval, and any compliance review performed.
