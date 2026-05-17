# Endpoint Compliance Checklist

## Device Join State

- Run `dsregcmd /status` and confirm Microsoft Entra join or hybrid join state.
- Confirm the device object exists in Entra ID.
- Check whether the signed-in user is the expected primary or assigned user where relevant.

## MDM Enrollment

- Confirm the device is enrolled in MDM.
- Review enrollment account and enrollment date.
- Check for duplicate or stale device records.
- Validate that the device appears in Intune admin center.

## Intune Sync

- Trigger a manual sync from Company Portal or Windows settings.
- Review device sync status in Intune admin center.
- Check local MDM event logs for enrollment or policy errors.

## BitLocker Status

- Run `Get-BitLockerVolume`.
- Confirm protection is enabled on the operating system volume.
- Confirm encryption percentage and protection status.
- Confirm recovery key escrow through the approved admin portal workflow.

## Compliance Policies

- Review assigned compliance policies.
- Confirm whether the device is marked compliant, noncompliant, or not evaluated.
- Check grace periods and policy evaluation timestamps.
- Review specific failed settings instead of relying only on the summary status.

## User vs Device Targeting

- Confirm whether the policy is assigned to users, devices, or groups.
- Validate group membership and dynamic group rules.
- Check whether the expected user is licensed for Intune and related services.

## Common Troubleshooting Commands

```powershell
dsregcmd /status
Get-BitLockerVolume
gpresult /r
```

```cmd
whoami /upn
```

Review Event Viewer logs under device management, BitLocker, and Windows enrollment categories as needed.

Do not paste device identifiers, recovery keys, tenant details, or user data into public tickets or portfolio screenshots.
