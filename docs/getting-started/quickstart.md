# Quickstart Guide

Get up and running with Syndicate Protocol in your terminal in under 2 minutes.

---

## 1. Install the CLI

Install the native `syn` CLI globally with a single command:

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/main/scripts/install.ps1 | iex
```

### macOS & Linux (Bash)

```bash
curl -fsSL https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/main/scripts/install.sh | bash
```

Verify your installation:

```bash
syn --version
```

---

## 2. Initialize in Any Project

Navigate to any existing repository or a new directory and run:

```bash
syn adopt
```

The interactive wizard will guide you through:
1. Detecting your project's technology stack (TypeScript, Go, Python, Rust, etc.).
2. Generating the **5 Living Root Documents** tailored to your project.
3. Setting up your automated verification script.

---

## 3. Verify Repository Health

Run the diagnostic scanner to verify that your repository is configured properly:

```bash
syn doctor
```

Run anti-drift verification:

```bash
syn verify
```

---

## 4. Daily Contributor Workflow

Every session follows four simple steps:

```bash
# 1. Onboard / Resume: Inspect active tasks and orient yourself
syn start

# 2. Develop your feature or bug fix...

# 3. Verify documentation & code alignment
syn verify --deep
syn harden

# 4. Wrap up session: Prepare hand-off state for the next contributor
syn handoff
```

Next: [Explore CLI Commands](../cli/commands.md) or [Configure AI Coding Agents](../guides/multi-agent.md).
