# Exchange Troubleshooting Checklist

## Mail Flow

- Confirm the sender, recipient, timestamp, subject, and whether the issue is inbound, outbound, or internal.
- Run message trace in the Microsoft 365 admin center or Exchange admin center.
- Check whether the message was delivered, filtered, quarantined, deferred, or failed.
- Review transport rules, anti-spam policies, anti-phishing policies, and allowed/blocked sender settings.
- For hybrid environments, review connector health and mail routing direction.

## Send As Issues

- Confirm the user has Send As permission on the mailbox or recipient.
- Check whether the permission was recently added and allow time for propagation.
- Confirm the user is selecting the correct From address in Outlook or OWA.
- Test in OWA to separate client-side Outlook profile issues from service-side permission issues.

## Mailbox Permissions

- Validate FullAccess permissions with Exchange Online PowerShell.
- Confirm whether automapping is expected.
- Remove and re-add permissions only after approval and change documentation.
- Test access in OWA and Outlook.

## Outlook Profile / OST Issues

- Test mailbox behavior in OWA.
- Restart Outlook and confirm connectivity status.
- Rebuild or recreate the Outlook profile when local cache corruption is suspected.
- Check whether cached mode, shared mailbox caching, or OST size is contributing to the issue.

## Message Trace

- Collect sender, recipient, approximate time, and message subject.
- Run message trace for the relevant time range.
- Review delivery status and event details.
- Export trace results when documentation is needed.

## Queue Checks for Hybrid Environments

- Check on-premises Exchange transport queues generically where hybrid mail flow is used.
- Validate network connectivity between on-premises Exchange and Microsoft 365.
- Review connectors, certificates, and accepted domains.
- Confirm whether the issue affects only hybrid-routed mail or all mail flow.
