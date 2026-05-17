# GPO Troubleshooting Checklist

## Initial Scope

- Confirm the affected user, device, OU, and expected policy.
- Check whether the issue affects one user, one device, one OU, or many systems.
- Confirm recent changes to GPOs, group membership, WMI filters, or OU placement.

## gpresult

- Run `gpresult /r` for a quick applied policy view.
- Run `gpresult /h gpresult.html` for detailed review.
- Confirm whether the expected user and computer policies are applied or denied.

## gpupdate

- Run `gpupdate /force` after confirming network connectivity.
- Restart or sign out/in if the policy requires it.
- Check for processing errors after update.

## Security Filtering

- Confirm the user or computer has permission to apply the GPO.
- Review group membership used for filtering.
- Check whether Authenticated Users read permission is still present where required.

## WMI Filtering

- Review the WMI filter linked to the GPO.
- Validate that the target computer matches the WMI condition.
- Temporarily test with a known simple target in a lab or controlled scope when appropriate.

## Loopback Processing

- Confirm whether loopback processing is enabled.
- Determine whether it is set to Merge or Replace.
- Review RDS or kiosk scenarios where loopback is commonly used.

## OU Placement

- Confirm the user and computer objects are in the expected OUs.
- Review blocked inheritance and enforced links.
- Check link order where multiple GPOs apply.

## Mapped Drives

- Confirm drive mapping preference item targeting.
- Check whether the user has permissions to the file share.
- Review reconnect settings and item-level targeting.

## Always Wait for the Network

- Review whether slow network logon behavior affects policy processing.
- Check the policy setting: Always wait for the network at computer startup and logon.
- Consider startup timing for laptops, Wi-Fi, VPN, and remote users.

## Event Logs

- Review GroupPolicy operational logs in Event Viewer.
- Check System and Application logs for related network, DNS, or authentication errors.
- Document error IDs and timestamps before escalation.
