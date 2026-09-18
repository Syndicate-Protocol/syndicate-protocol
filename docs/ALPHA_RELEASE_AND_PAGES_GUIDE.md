# Syndicate Protocol — Alpha Release Distribution & Documentation Setup Guide

> **Role & Purpose**: This document provides an authoritative, step-by-step operational handbook for building and uploading Alpha releases of Syndicate Protocol, distributing cross-platform standalone binaries to external testers, and establishing user documentation using GitHub Pages versus GitHub Wiki.

---

## 1. Overview & Distribution Architecture

Syndicate Protocol utilizes a **hybrid distribution model**:

- The core CLI engine (`cmd/syn/`, `internal/`) is developed in a private monorepo and compiled into signed, standalone, multi-architecture binaries.
- Binary assets and release artifacts are published to **GitHub Releases** on the public repository ([`Syndicate-Protocol/syndicate-protocol`](https://github.com/Syndicate-Protocol/syndicate-protocol)).
- Global installers (`scripts/install.ps1` and `scripts/install.sh`) query the GitHub Releases API, detect the target operating system and CPU architecture, download the binary into `~/.syndicate/bin/`, and configure the system `PATH`.
- User documentation can be hosted via **GitHub Pages**, providing a branded documentation portal with optional custom domain mapping to `protocol.syntaxsyndicate.com`.

```text
┌────────────────────────────────────────────────────────┐
│             Private Monorepo (Local Machine)           │
│  - Builds 6 cross-platform binaries into ./dist        │
│  - Generates CycloneDX A-BOM + SHA-256 checksums       │
└───────────────────────────┬────────────────────────────┘
                            │ gh release create v0.2.0-alpha.1
                            ▼
┌────────────────────────────────────────────────────────┐
│     Public GitHub Releases (Syndicate-Protocol)        │
│  - syn-windows-amd64.exe     - syn-linux-amd64         │
│  - syn-windows-arm64.exe     - syn-linux-arm64         │
│  - syn-darwin-arm64          - syn-darwin-amd64        │
│  - syndicate-abom.json       - checksums.txt           │
└───────────────────────────┬────────────────────────────┘
                            │ 1-liner curl / irm installer
                            ▼
┌────────────────────────────────────────────────────────┐
│            End-User / External Developer               │
│  - Auto-detects OS & CPU architecture (x64 vs ARM64)   │
│  - Downloads binary directly into ~/.syndicate/bin/     │
│  - Ready to run 'syn doctor', 'syn verify', etc.       │
└────────────────────────────────────────────────────────┘
```

---

## 2. Building and Uploading the Alpha Release

### Step 1: Cross-Compile the Release Matrix

The repository includes a native, zero-Docker cross-compilation pipeline in `scripts/run-ci-local.ps1` (Windows) and `scripts/run-ci-local.sh` (POSIX).

Run the local pipeline with the `-Matrix` flag:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/run-ci-local.ps1 -Matrix
```

This generates all target binaries and provenance metadata into the `./dist/` folder:

| File | Platform | Architecture | Description |
| --- | --- | --- | --- |
| `syn-windows-amd64.exe` | Windows | AMD64 (x86_64) | Standard 64-bit Windows systems |
| `syn-windows-arm64.exe` | Windows | ARM64 | Windows Surface / Snapdragon laptops |
| `syn-linux-amd64` | Linux | AMD64 (x86_64) | Ubuntu, Debian, CentOS, Fedora, Arch |
| `syn-linux-arm64` | Linux | ARM64 (aarch64) | AWS Graviton, Raspberry Pi, Linux ARM |
| `syn-darwin-amd64` | macOS | AMD64 (x86_64) | Intel-based Macs |
| `syn-darwin-arm64` | macOS | ARM64 (Apple Silicon) | M1 / M2 / M3 / M4 Macs |
| `syndicate-abom.json` | Any | Metadata | CycloneDX Attestation Software Bill of Materials |
| `checksums.txt` | Any | SHA-256 | Cryptographic integrity hashes for all assets |

---

### Step 2: Publish the Release to GitHub

You can publish the release either through the GitHub CLI (`gh`) or through the GitHub web UI.

#### Option A: One-Command Upload via GitHub CLI (Recommended)

Since the `gh` CLI is authenticated on your workstation, you can publish the Alpha release directly from PowerShell:

```powershell
gh release create v0.2.0-alpha.1 dist/* `
  --repo Syndicate-Protocol/syndicate-protocol `
  --title "Syndicate Protocol v0.2.0-alpha.1 (Alpha Preview)" `
  --notes "First public alpha release of Syndicate Protocol CLI and Single Source of Truth governance engine." `
  --prerelease
```

#### Option B: Via the GitHub Web Interface

1. Open your browser and navigate to:
   [`https://github.com/Syndicate-Protocol/syndicate-protocol/releases/new`](https://github.com/Syndicate-Protocol/syndicate-protocol/releases/new)
2. In the **Choose a tag** dropdown, type: `v0.2.0-alpha.1` and click **Create new tag: v0.2.0-alpha.1 on main**.
3. Set the **Release title** to: `Syndicate Protocol v0.2.0-alpha.1 (Alpha Preview)`.
4. Check the box marked **Set as a pre-release** (identifies the release as Alpha/Beta).
5. In the **Attach binaries** drop area, drag and drop all files from your local `./dist/` folder:
   - `dist/syn-windows-amd64.exe`
   - `dist/syn-windows-arm64.exe`
   - `dist/syn-linux-amd64`
   - `dist/syn-linux-arm64`
   - `dist/syn-darwin-amd64`
   - `dist/syn-darwin-arm64`
   - `dist/syndicate-abom.json`
   - `dist/checksums.txt`
6. Click **Publish release**.

---

### Step 3: Verifying External Installation

Once uploaded, anyone can install the Alpha globally with a single terminal command:

#### Windows PowerShell

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/main/scripts/install.ps1))) -Channel alpha
```

#### macOS and Linux Bash

```bash
curl -fsSL https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/main/scripts/install.sh | bash -s -- --channel alpha
```

#### Installing a Specific Version Tag

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/main/scripts/install.ps1))) -Version v0.2.0-alpha.1
```

The installer will:

1. Detect their operating system and hardware architecture.
2. Query GitHub's release assets for matching binaries.
3. Download the binary into `~/.syndicate/bin/`.
4. Ensure `~/.syndicate/bin` is in their user PATH.
5. Verify execution by running `syn --version`.

---

## 3. User Documentation Strategy: GitHub Pages vs. GitHub Wiki

When publishing documentation for developer tools, choosing the right platform determines long-term discoverability, maintainability, and user experience.

### Direct Comparison

| Criteria | **GitHub Pages** (Recommended 🏆) | **GitHub Wiki** |
| --- | --- | --- |
| **Branding & Look** | Rich modern typography, dark mode, custom CSS, badges | Plain default GitHub wiki layout |
| **Custom Domain** | Full support for `protocol.syntaxsyndicate.com` with free SSL | No custom domain support (locked to `github.com/.../wiki`) |
| **Git Synchronization** | Lives in the repo (`docs/`), updated via Git commits & PRs | Lives in a disconnected secondary git repo |
| **Search & Indexing** | Full-text instant client-side search across all documents | Basic keyword search in GitHub |
| **Code Highlighting** | Syntax highlighting with copy buttons for multiple languages | Basic markdown code blocks |
| **Interactive Components** | Can embed terminal demos, search bars, interactive forms | Static markdown only |

> **Conclusion**: **GitHub Pages** is the clear choice for Syndicate Protocol. It integrates with your version control, can host the `docs/` folder directly, and allows mapping your planned custom subdomain (`protocol.syntaxsyndicate.com`).

---

## 4. How to Set Up GitHub Pages

### Approach 1: Instant Native `/docs` Deployment (Zero Build Tools)

Because this repository already contains a centralized [`docs/`](./) directory with complete specifications, you can turn on GitHub Pages in under 60 seconds without writing any build configurations.

#### Steps

1. Open the repository on GitHub:
   [`https://github.com/Syndicate-Protocol/syndicate-protocol`](https://github.com/Syndicate-Protocol/syndicate-protocol)
2. Click **Settings** (top navigation bar) -> select **Pages** (left sidebar).
3. Under **Build and deployment**:
   - **Source**: Select `Deploy from a branch`.
   - **Branch**: Select `main`.
   - **Folder**: Select `/docs`.
4. Click **Save**.
5. Wait 30–60 seconds for GitHub's background runner.
6. Your documentation will be live at:
   `https://syndicate-protocol.github.io/syndicate-protocol/`

---

### Approach 2: Polished Documentation Portal (VitePress or Astro Starlight)

If you want a documentation website matching modern developer tools (like Astro, Tailwind, or Vite) with dark mode, deep-links, and search:

1. A lightweight GitHub Actions workflow (`.github/workflows/deploy-docs.yml`) is placed in the repository.
2. Whenever documentation in `docs/` is updated and merged to `main`, GitHub Actions automatically compiles the static site and deploys it to the `gh-pages` branch.
3. Users get an interactive documentation portal with table-of-contents sidebars, search, and mobile responsiveness.

---

## 5. Connecting Your Custom Subdomain (`protocol.syntaxsyndicate.com`)

When your Plesk VPS server or DNS is ready, you can point `protocol.syntaxsyndicate.com` to GitHub Pages:

### Step 1: DNS Configuration in Plesk / Domain Registrar

Add a `CNAME` record in your DNS zone:

```text
Type:  CNAME
Host:  protocol
Value: syndicate-protocol.github.io.
TTL:   300 (or Automatic)
```

### Step 2: Configure Custom Domain in GitHub Pages

1. In your GitHub repository, go to **Settings** -> **Pages**.
2. Under **Custom domain**, enter: `protocol.syntaxsyndicate.com`.
3. Click **Save**. GitHub will verify DNS propagation.
4. Check the box **Enforce HTTPS** (GitHub provisions a free Let's Encrypt SSL certificate automatically).

Now, navigating to `https://protocol.syntaxsyndicate.com` will serve the official documentation portal.

---

## 6. Release Day Checklist

Before uploading the Alpha release, complete this checklist:

- [x] **Verify Baseline**: Run `pnpm run verify:ssot`, `syn verify --deep`, and `syn harden`.
- [x] **Compile Matrix**: Run `powershell -ExecutionPolicy Bypass -File scripts/run-ci-local.ps1 -Matrix`.
- [x] **Inspect Checksums**: Check `dist/checksums.txt` to ensure hashes were computed.
- [x] **Publish Release**: Run `gh release create v0.2.0-alpha.1 dist/* --prerelease`.
- [x] **Test 1-Liner Installer**: Test the PowerShell and Bash install commands on a separate machine or clean environment.
- [x] **Enable GitHub Pages**: Activate GitHub Pages pointing to `/docs` on branch `main`.
