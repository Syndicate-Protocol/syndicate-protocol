# Security Policy

> **Role & Purpose**: This document establishes the official security policy, supported release versions, responsible disclosure process, and vulnerability management procedures for **Syndicate Protocol**.

---

## 1. Supported Versions

We provide active security updates, vulnerability patches, and coordinated disclosure advisories for the following versions:

| Version | Release Channel | Supported | Notes |
| :--- | :--- | :---: | :--- |
| `0.2.x-alpha` | **Alpha Early Access** | ✅ | Current active development line; receives rapid security hotfixes. |
| `< 0.2.0` | **Pre-Alpha / Experimental** | ❌ | Deprecated early prototypes; please upgrade immediately to latest. |

---

## 2. Reporting a Vulnerability

We take the security of Syndicate Protocol and the teams relying on its governance operating system seriously. If you believe you have discovered a security vulnerability, **please do not disclose it publicly or open a public GitHub issue.**

Instead, please use one of our two confidential reporting channels:

### Option A: GitHub Private Vulnerability Reporting (Preferred)

We have enabled **GitHub Private Vulnerability Reporting** on our public repository. This provides a direct, cryptographically encrypted channel between security researchers and repository maintainers:

1. Navigate to: [**https://github.com/Syndicate-Protocol/syndicate-protocol/security/advisories/new**](https://github.com/Syndicate-Protocol/syndicate-protocol/security/advisories/new)
2. Fill out the advisory details:
   - **Summary**: Concise title of the vulnerability.
   - **Severity**: Estimated CVSS score or severity tier (Low, Medium, High, Critical).
   - **Vulnerable Component**: Subsystem affected (CLI core, web dashboard, template compiler, etc.).
   - **Proof of Concept (PoC)**: Step-by-step reproduction instructions or code samples.
3. Click **Submit report**. Maintainers will be notified immediately, and a private collaboration workspace will be provisioned.

---

### Option B: Confidential Security Email (Fallback)

If you do not have a GitHub account or prefer direct email communication:

- **Email Address**: [`security@syntaxsyndicate.com`](mailto:security@syntaxsyndicate.com)
- **Subject Line**: `[SECURITY VULNERABILITY] <Component>: <Brief Description>`
- **Content**: Please include reproduction steps, environment details (OS, architecture, CLI version), and remediation suggestions.

> [!NOTE]
> **License & Anti-SaaS Violations**:
> If you are reporting an unauthorized commercial use, SaaS paywall, or license breach, do **not** use the security inbox. Please submit reports to our dedicated legal desk: **[`splv@syntaxsyndicate.com`](mailto:splv@syntaxsyndicate.com)** with the subject line *'Syndicate Protocol License Violation'*.

---

## 3. Coordinated Disclosure & Response SLAs

When a vulnerability report is submitted, our maintainers adhere to the following strict timeline:

```text
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│   48 Hours      │  ──►  │ 5 Business Days │  ──►  │    14 Days      │  ──►  │   30–90 Days    │
│ Initial Triage  │       │ Severity & CVSS │       │ Remediation Fix │       │ Public Release  │
│ Acknowledgment  │       │ Determination   │       │ in Private Fork │       │  & CVE Credit   │
└─────────────────┘       └─────────────────┘       └─────────────────┘       └─────────────────┘
```

1. **Initial Acknowledgment (within 48 hours)**: We confirm receipt of your report and assign a primary security coordinator.
2. **Triage & Assessment (within 5 business days)**: We reproduce the issue, determine exploitability, assign a CVSS v3.1 score, and verify impact across supported platforms.
3. **Remediation & Testing (within 14 days)**: We author a fix in a temporary private GitHub fork and invite the reporter to review and validate the patch.
4. **Coordinated Release & Advisory (within 30–90 days)**:
   - A patched binary release is compiled and signed across all 6 architectures.
   - A public **GitHub Security Advisory** is published with an official **CVE identifier** (requested via GitHub as a CNA).
   - The security researcher is formally credited in the advisory, release notes, and hall of fame.

---

## 4. Scope & Security Invariants

### In-Scope Systems
- **Core CLI Engine (`syn`)**: Execution privilege safety, path traversal prevention, arbitrary file overwrite defenses during `syn init` or `syn adopt`.
- **Cybernetic Web Dashboard (`syn web`)**: Localhost origin enforcement (`isLocalOrigin`), DNS rebinding protection, Cross-Site Request Forgery (CSRF) defenses, and terminal WebSocket bridge command injection guards.
- **Universal Multi-Agent Compilers (`syn adapt`)**: Shell command injection sanitization when compiling configs for Claude, Cursor, Antigravity, Copilot, and Codex.
- **Supply Chain & Build Integrity**: Standalone binary tampering, cryptographic checksum validation (`checksums.txt`), and CycloneDX Software Bill of Materials (`syndicate-abom.json`) provenance.
- **SSOT Anti-Drift Engines**: Tampering or evasion attacks where fake task completions or mocked fallback data circumvent the Rule 6 adversarial hardening gate.

### Out-of-Scope Items
- Denial of Service (DoS) attacks targeting local developer machines caused by intentionally massive or circular directory structures.
- Social engineering, phishing, or physical attacks targeting maintainers or contributors.
- Reports concerning third-party dependencies where no plausible exploit vector exists in Syndicate Protocol.
- Issues in unsupported, unreleased, or heavily customized third-party forks.

---

## 5. Safe Harbor Statement

We consider security research conducted under this policy to be:
- **Authorized**: Conducted with full permission of the maintainers.
- **Exempt from Legal Action**: We will not pursue legal claims or initiate law enforcement investigations against researchers who adhere to this policy.
- **Responsible**: If your activities accidentally access sensitive or internal data, please stop immediately and notify us without retaining, sharing, or copying the data.

Thank you for helping keep Syndicate Protocol and our community secure!
