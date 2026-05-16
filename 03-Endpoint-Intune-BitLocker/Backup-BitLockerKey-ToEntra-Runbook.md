# Backup BitLocker Key to Entra Runbook

## Purpose

Document a safe process for validating that BitLocker recovery keys are escrowed to Entra ID for managed Windows devices.

## Prerequisites

- Administrative authorization to review the device.
- Device is Microsoft Entra joined or hybrid joined as required by the environment.
- Device is managed by Intune or another approved MDM path where applicable.
- BitLocker is enabled and a recovery password protector exists.
- Administrator has access to validate recovery keys in the Entra admin center or Intune admin center.

## Checking Local BitLocker Protectors

1. Open an elevated PowerShell session on the device.
2. Run:

```powershell
Get-BitLockerVolume
```

3. Identify the protected operating system volume, usually `C:`.
4. Review the `KeyProtector` entries.

## Identifying the RecoveryPassword Protector

1. Look for a key protector with type `RecoveryPassword`.
2. Note the KeyProtectorId value.
3. Do not copy or expose the recovery password in tickets, screenshots, chat, or documentation.

## BackupToAAD-BitLockerKeyProtector Concept

When the device is eligible and policy allows it, administrators can use the built-in BitLocker cmdlet conceptually as follows:

```powershell
BackupToAAD-BitLockerKeyProtector -MountPoint "C:" -KeyProtectorId "{example-key-protector-id}"
```

Use this only with proper authorization and after confirming the target device, volume, and protector ID. Treat recovery key material as sensitive data.

## Validation in Entra Admin Center

1. Open the Entra admin center.
2. Locate the device object.
3. Review BitLocker recovery keys from the approved device recovery workflow.
4. Confirm the expected key exists and the timestamp aligns with the remediation activity.
5. Document validation without exposing the recovery key value.

## Common Troubleshooting Issues

- Device is not Entra joined or hybrid joined as expected.
- MDM enrollment is missing or broken.
- User or device is not targeted by the expected BitLocker policy.
- Recovery password protector does not exist.
- Network connectivity prevents policy sync or key escrow.
- Administrator does not have permission to view recovery key metadata.
- Device object mismatch exists between local device identity and cloud directory object.

## Safety Notes

- Never paste BitLocker recovery passwords into tickets or public documentation.
- Validate the device identity before taking action.
- Follow organization policy for recovery key access and auditing.
- Do not remove or rotate protectors unless explicitly approved.
