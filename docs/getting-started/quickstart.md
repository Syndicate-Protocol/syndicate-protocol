---
layout: default
title: 5-Minute Quickstart
description: Get up and running with Syndicate Protocol in your terminal in under 2 minutes
---

# Quickstart Guide

Get up and running with Syndicate Protocol in your terminal in under 2 minutes.


---

## The Quickstart Journey

```mermaid
flowchart LR
    Step1["1. Install CLI\n(~10 seconds)"] --> Step2["2. Adopt Project\n('syn adopt')"]
    Step2 --> Step3["3. Verify Health\n('syn doctor')"]
    Step3 --> Step4["4. Start Task\n('syn start')"]
    Step4 --> Step5["5. Gate & Handoff\n('syn handoff')"]
```

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
3. Setting up your automated verification script (`ssot.config.json`).

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

Every session follows a predictable four-step cadence:

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

---

## Quickstart Command Summary

| Phase | Command | What It Does | Typical Time |
|---|---|---|---|
| **Setup** | `syn adopt` | Scans tech stack and bootstraps living documents | ~30s |
| **Diagnostics** | `syn doctor` | Validates repository health, path, and security | <1s |
| **Session Start** | `syn start` | Onboards agent/human, surfaces active tasks | <1s |
| **Anti-Drift** | `syn verify` | AST signature audit and file reference validation | <15ms |
| **Integrity** | `syn harden` | Adversarial scan for unfinished stubs and mocks | <50ms |
| **Session End** | `syn handoff` | Cleans worktrees, updates state, and stages git | ~5s |

---

## Next Steps

- [Deep Dive into CLI Commands](../cli/commands.md)
- [Configure Multi-Agent AI Swarms](../guides/multi-agent.md)
- [Launch the Cybernetic Web Dashboard](../guides/web-dashboard.md)
