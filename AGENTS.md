# AGENTS.md

Instructions for future Codex tasks in this repository:

- Keep scripts readable, safe, and practical for IT administration portfolios.
- Prefer read-only reporting scripts unless a change action is explicitly requested.
- Use comment-based help for every PowerShell script.
- Avoid real organization data, including real domains, server names, usernames, emails, IP addresses, customer names, secrets, credentials, tenant IDs, device IDs, and internal identifiers.
- Use generic examples only, such as `contoso.com`, `user@contoso.com`, `SERVER01`, `DC01`, and `EXCH01`.
- Include practical error handling with clear warnings or error records.
- Return clear PowerShell objects instead of relying on `Write-Host`.
- Prefer objects that are friendly to `Export-Csv`.
- Any script that makes changes must include a clear warning, comments, and `-WhatIf` support where possible.
- Keep README files recruiter-friendly and technical-manager-friendly: professional, concise, and grounded in realistic sysadmin work.
- Do not exaggerate ownership or claim full architecture responsibility for enterprise systems.
- Position this portfolio around practical IT, sysadmin, Microsoft 365, identity, endpoint, and Windows administration automation.
