# Installation Guide

Syndicate Protocol is distributed as a single, zero-dependency standalone binary (`syn`) for Windows, macOS, and Linux across Intel/AMD and ARM architectures.

---

## Automated Global Installation

The recommended method is using our official one-line installer:

### Windows (PowerShell)

Open PowerShell and execute:

```powershell
irm https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/main/scripts/install.ps1 | iex
```

To install an experimental or pre-release channel (e.g. `alpha` or `beta`):

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/main/scripts/install.ps1))) -Channel alpha
```

### macOS & Linux (Bash)

Open terminal and execute:

```bash
curl -fsSL https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/main/scripts/install.sh | bash
```

To install an experimental or pre-release channel:

```bash
curl -fsSL https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/main/scripts/install.sh | bash -s -- --channel alpha
```

---

## Where Binaries Are Installed

The installer copies the binary into a centralized user directory:
- **Windows**: `C:\Users\<User>\.syndicate\bin\syn.exe`
- **Linux & macOS**: `~/.syndicate/bin/syn`

The script automatically configures your system `PATH`. If you need to manually add it to your profile:

```bash
export PATH="$HOME/.syndicate/bin:$PATH"
```

---

## Verifying Installation

Verify that the CLI is accessible and healthy:

```bash
syn --version
syn doctor
```

---

## Updating the CLI

When a new version is released, you can re-run the install one-liner or update directly:

```bash
syn update
```
