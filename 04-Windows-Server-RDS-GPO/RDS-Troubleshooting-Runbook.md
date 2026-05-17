# RDS Troubleshooting Runbook

## Purpose

Provide a structured process for troubleshooting a user who cannot connect to a Remote Desktop Session Host or terminal server.

## User Cannot Connect to Terminal Server

1. Confirm the target server name, such as `SERVER01`.
2. Capture the exact error message and screenshot if available.
3. Confirm whether the user is connecting through VPN, internal network, RD Gateway, or another approved path.
4. Check whether the issue affects one user or multiple users.

## Test with Another User or Device

- Test the same user from another device.
- Test another authorized user from the same device.
- Test another authorized user from another device if available.
- Use the results to separate account, endpoint, network, and server-side issues.

## NLA Considerations

- Confirm whether Network Level Authentication is required.
- Check whether the client supports NLA.
- Review account lockout, password expiration, and MFA or conditional access dependencies where relevant.

## Defender and Firewall Checks

- Confirm Windows Defender Firewall allows the expected RDP path.
- Validate that security tools are not blocking the connection.
- Check whether recent firewall or endpoint policy changes occurred.

## RDP Services

- Check the Remote Desktop Services service status.
- Confirm the server is listening on the expected port.
- Review whether the server is in drain mode or otherwise unavailable for new sessions.
- Do not restart services without change approval.

## Broker / Load Balancing Concept

- If using an RDS collection, verify whether the connection broker is healthy.
- Confirm the user is routed to an available session host.
- Review load balancing behavior at a high level before focusing on a single server.

## User Profile Issues

- Check for temporary profile messages.
- Review FSLogix or roaming profile status where used.
- Confirm the user profile disk or profile path is available.
- Test with a new or known-good profile only after approval.

## Event Viewer Checks

- Review TerminalServices logs.
- Review System and Application logs around the failed connection time.
- Check authentication, profile, licensing, and service-related events.
- Document event IDs, timestamps, and error messages before escalation.
