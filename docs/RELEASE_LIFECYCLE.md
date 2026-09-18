# 🚀 Syndicate Protocol — Release Lifecycle & Distribution Architecture

> **Role & Purpose**: This document establishes the formal release lifecycle (**Alpha**, **Beta**, **RC**, **Stable**), feature flag governance, and automated zero-cost build, staging, and distribution pipeline for the **Syndicate Protocol** ecosystem.

---

## 📑 Table of Contents

- [1. Release Lifecycle Stages](#1-release-lifecycle-stages)
- [2. Feature Flags & Lifecycle Matrix](#2-feature-flags--lifecycle-matrix)
- [3. How GitHub Actions Works (Beginner's Guide)](#3-how-github-actions-works-beginners-guide)
- [4. Automated Multi-Arch Release Pipeline](#4-automated-multi-arch-release-pipeline)
- [5. How to Cut a Release (Step-by-Step)](#5-how-to-cut-a-release-step-by-step)
- [6. Channel-Aware Installation & Upgrades](#6-channel-aware-installation--upgrades)
- [7. Zero-Cost Open Source Infrastructure Guarantee](#7-zero-cost-open-source-infrastructure-guarantee)

---

## 1. Release Lifecycle Stages

Syndicate Protocol follows Semantic Versioning 2.0 (`vMAJOR.MINOR.PATCH[-PRERELEASE]`):

```text
                     ┌───────────┐
  Bleeding Edge ───► │   ALPHA   │  (v*.*.*-alpha.*) — Internal / Experimental
                     └─────┬─────┘
                           │ Feature Complete
                           ▼
                     ┌───────────┐
  Public Preview ──► │   BETA    │  (v*.*.*-beta.*)  — Hardening & Feedback
                     └─────┬─────┘
                           │ Code Freeze / Zero-Debt
                           ▼
                     ┌───────────┐
  Staging Gate ────► │    RC     │  (v*.*.*-rc.*)    — Release Candidate
                     └─────┬─────┘
                           │ Adversarial Gate Verified
                           ▼
                     ┌───────────┐
  Production ──────► │  STABLE   │  (v*.*.*)         — General Availability
                     └───────────┘
```

### Stage Specifications

| Stage | Tag Pattern | Stability | Audience | GitHub Release Flag | Default Features |
|---|---|---|---|---|---|
| **Alpha** | `v*.*.*-alpha.*` | Experimental | Core contributors & early testers | `prerelease: true` | Alpha, Beta, RC, Stable enabled |
| **Beta** | `v*.*.*-beta.*` | Hardening | Community adopters, ecosystem testers | `prerelease: true` | Beta, RC, Stable enabled |
| **Release Candidate (RC)** | `v*.*.*-rc.*` | Pre-production | Staging systems, CI/CD qualification | `prerelease: true` | RC and Stable enabled |
| **Stable** | `v*.*.*` | Production | General developers, enterprise swarms | `prerelease: false`, `latest: true` | Only verified Stable features enabled |

---

## 2. Feature Flags & Lifecycle Matrix

Syndicate Protocol utilizes a Single Source of Truth (SSOT) feature flag system managed in Go via `internal/feature/` and exposed via the CLI command `syn feature`.

### Registered Features

| Feature Key | Stage | Default | Description |
|---|---|---|---|
| `rule7-enforce` | **STABLE** | `ACTIVE` | Strict automated validation of Suggestions, Enhancements, Fixes, Next-Steps |
| `remote-attestation` | **RC** | `OFF` | Remote breach attestation reporting to protocol.syntaxsyndicate.com CMS (disabled in Alpha) |
| `telemetry-export` | **RC** | `OFF` | OpenTelemetry protocol gRPC/HTTP remote streaming for agent trace spans |
| `lsp-server` | **BETA** | `OFF` | Native LSP server enabling live in-editor SSOT linting for VS Code & Cursor |
| `wasm-engine` | **BETA** | `OFF` | Portable Wasm runtime for sandboxed polyglot AST code signature analysis |
| `zk-attest` | **ALPHA** | `OFF` | Cryptographic zero-knowledge anti-drift verification proofs |
| `crdt-sync` | **ALPHA** | `OFF` | Distributed real-time multi-agent conflict-free state synchronization |

### Managing Feature Flags

```bash
# List all features with their lifecycle stage and active state
syn feature list

# Check active release channel and summary
syn feature status

# Persistently enable an experimental feature (stored in ~/.syndicate/features.json)
syn feature enable crdt-sync

# Persistently disable a feature
syn feature disable crdt-sync

# Override a feature per-session via environment variable
export SYNDICATE_FEATURE_CRDT_SYNC=1     # POSIX (bash/zsh)
$env:SYNDICATE_FEATURE_CRDT_SYNC="1"     # PowerShell
```

---

## 3. How GitHub Actions Works (Beginner's Guide)

If you are new to CI/CD and GitHub Actions, here is how the automated workflow operates:

1. **What is GitHub Actions?**  
   GitHub Actions is a free automation service provided by GitHub. Instead of needing a dedicated build computer running 24/7, GitHub automatically spins up virtual computers ("runners") in the cloud whenever an event happens in your repository.

2. **What is a Workflow File?**  
   Workflows are defined in YAML files inside the `.github/workflows/` folder (such as `.github/workflows/release.yml`). They tell GitHub *when* to run and *what commands* to execute.

3. **Key Concepts**:
   - **Trigger (`on:`)**: The event that wakes up the workflow. In our release pipeline, pushing any git tag starting with `v` (e.g. `git push origin v0.2.0-beta.1`) triggers the workflow.
   - **Runner (`runs-on: ubuntu-latest`)**: A clean, temporary Linux virtual machine created on demand by GitHub.
   - **Steps (`steps:`)**: Sequential commands executed on the runner (checking out your code, setting up the Go compiler, running builds, uploading binaries).
   - **Secrets & Permissions**: GitHub automatically supplies a secure `GITHUB_TOKEN` allowing the workflow to create GitHub Releases without exposing personal passwords or API keys.

---

## 4. Automated Multi-Arch Release Pipeline

When a tag is pushed, `.github/workflows/release.yml` automatically executes the following pipeline:

```
                                Tag Pushed (e.g. v0.2.0-beta.1)
                                              │
                                              ▼
                             GitHub Actions Runner Initialized
                                              │
                    ┌─────────────────────────┴─────────────────────────┐
                    ▼                                                   ▼
         Parse Release Metadata                               Setup Go 1.24 Environment
      (Detect Alpha / Beta / RC / Stable)                               │
                    └─────────────────────────┬─────────────────────────┘
                                              │
                                              ▼
                             Compile Native syn & Generate A-BOM
                                  (bom.cyclonedx.json)
                                              │
                                              ▼
                          Cross-Compile 6 Architecture Binaries
                    ┌─────────────────────────┬─────────────────────────┐
                    ▼                         ▼                         ▼
            Windows (amd64/arm64)      Linux (amd64/arm64)       macOS (amd64/arm64)
                    └─────────────────────────┬─────────────────────────┘
                                              │
                                              ▼
                             Generate Cryptographic Checksums
                                      (checksums.txt)
                                              │
                                              ▼
                                   Publish GitHub Release
                            (Binaries + Checksums + A-BOM)
```

### Release Artifacts Published
Every release automatically contains:
1. `syn-windows-amd64.exe` (Windows 64-bit Intel/AMD)
2. `syn-windows-arm64.exe` (Windows 64-bit ARM / Snapdragon)
3. `syn-linux-amd64` (Linux 64-bit Intel/AMD)
4. `syn-linux-arm64` (Linux 64-bit ARM / Raspberry Pi / Graviton)
5. `syn-darwin-amd64` (macOS Intel)
6. `syn-darwin-arm64` (macOS Apple Silicon M1/M2/M3/M4)
7. `syndicate-abom.json` & `bom.cyclonedx.json` (Zero-trust Agent Software Bill of Materials)
8. `checksums.txt` (SHA256 checksums for supply chain verification)

---

## 5. How to Cut a Release (Step-by-Step)

Cutting a release requires zero manual compilation or file uploads. Follow this simple protocol:

### Step 1: Verify Zero-Drift Baseline
Before cutting any release, ensure the codebase is 100% verified:
```bash
npm run verify:ssot
syn verify --deep
syn harden
```

### Step 2: Create and Push a Git Tag
Select the appropriate lifecycle stage:

```bash
# For an Alpha release:
git tag v0.2.0-alpha.1
git push origin v0.2.0-alpha.1

# For a Beta release:
git tag v0.2.0-beta.1
git push origin v0.2.0-beta.1

# For a Release Candidate:
git tag v0.2.0-rc.1
git push origin v0.2.0-rc.1

# For a Production Stable release:
git tag v0.2.0
git push origin v0.2.0
```

### Step 3: Monitor the Automation
Visit your repository on GitHub under the **Actions** tab. You will see the **Syndicate Protocol Release & Distribution** workflow building all 6 binaries and publishing the release to the **Releases** page automatically!

---

## 6. Channel-Aware Installation & Upgrades

Users and automated AI agent swarms can install or switch channels with a single terminal command:

### Windows (PowerShell)

```powershell
# Default: Installs Latest Production Stable
irm https://raw.githubusercontent.com/syntax-syndicate/Syndicate_Protocol/master/scripts/install.ps1 | iex

# Install Public Beta Channel
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/syntax-syndicate/Syndicate_Protocol/master/scripts/install.ps1))) -Channel beta

# Install Release Candidate Channel
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/syntax-syndicate/Syndicate_Protocol/master/scripts/install.ps1))) -Channel rc

# Install Specific Pinned Version
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/syntax-syndicate/Syndicate_Protocol/master/scripts/install.ps1))) -Version v0.2.0-beta.1
```

### macOS & Linux (Bash / Zsh)

```bash
# Default: Installs Latest Production Stable
curl -fsSL https://raw.githubusercontent.com/syntax-syndicate/Syndicate_Protocol/master/scripts/install.sh | bash

# Install Public Beta Channel
curl -fsSL https://raw.githubusercontent.com/syntax-syndicate/Syndicate_Protocol/master/scripts/install.sh | bash -s -- --channel beta

# Install Release Candidate Channel
curl -fsSL https://raw.githubusercontent.com/syntax-syndicate/Syndicate_Protocol/master/scripts/install.sh | bash -s -- --channel rc

# Install Specific Pinned Version
curl -fsSL https://raw.githubusercontent.com/syntax-syndicate/Syndicate_Protocol/master/scripts/install.sh | bash -s -- --version v0.2.0-beta.1
```

---

## 7. Zero-Cost Open Source Infrastructure Guarantee

All services utilized in the Syndicate Protocol release lifecycle are strictly free and open-source:

- **GitHub Actions**: 100% free and unlimited build minutes for public open-source repositories.
- **GitHub Releases**: 100% free unlimited storage and global CDN distribution for release binaries and checksums.
- **Zero Third-Party SaaS**: No paid continuous deployment services, proprietary feature flag platforms, or external telemetry dependencies.
