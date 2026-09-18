# CLI Command Reference

This document provides the authoritative user reference for all `syn` CLI commands and options.

---

## Command Overview

| Command | Description |
|---|---|
| [`syn doctor`](#syn-doctor) | Run comprehensive repository health diagnostics. |
| [`syn adopt`](#syn-adopt) | Interactively onboard an existing project to the protocol. |
| [`syn verify`](#syn-verify) | Execute high-speed anti-drift and Single Source of Truth verification. |
| [`syn harden`](#syn-harden) | Run adversarial Rule 6 audit scanning for stubs and fake completions. |
| [`syn start`](#syn-start) | Session onboarding: view active milestones, pending tasks, and innovations. |
| [`syn handoff`](#syn-handoff) | Session wrap-up: clean worktree leases, verify invariants, and stage changes. |
| [`syn web`](#syn-web) | Launch the embedded React 19 cybernetic visual dashboard in your browser. |
| [`syn dash`](#syn-dash) | Launch the full-screen terminal TUI monitoring dashboard. |
| [`syn adapt`](#syn-adapt) | Compile agent configs and slash commands for Claude, Cursor, Copilot, etc. |
| [`syn worktree`](#syn-worktree) | Manage isolated Git worktrees for concurrent AI agent swarms. |
| [`syn update`](#syn-update) | Compile workspace binary and update global installation in system PATH. |

---

## Detailed Command Reference

### `syn doctor`

Performs a full audit of your local repository configuration:
- Confirms presence and placement of living root documents (`SSOT.md`, `README.md`, `TASK.md`, `HANDOFF.md`, `AGENTS.md`).
- Confirms centralized documentation hub index.
- Verifies every file referenced in completed tasks exists on disk.
- Scans for unauthorized shadow trackers (`TODO.md`, `NOTES.md`).
- Checks environment PATH and active binary location.
- Audits AI skills and agent rule files for hygiene.

```bash
syn doctor
```

---

### `syn adopt`

Launches the interactive project adoption wizard. Automatically detects project stack, creates living root documents, sets up `ssot.config.json`, and verifies setup.

```bash
syn adopt
```

---

### `syn verify`

Sub-10ms anti-drift verification engine. Validates living root documents, checks file references in `TASK.md`, and detects shadow trackers.

```bash
# Standard verification
syn verify

# Deep AST code signature audit + Git staleness analysis
syn verify --deep

# Verify living document template compliance
syn verify --templates

# Machine-readable JSON output for CI pipelines
syn verify --json
```

---

### `syn harden`

Adversarial hardening gate enforcer (Rule 6). Scans recently completed tasks in `TASK.md` and their referenced source files for unimplemented stubs, mock fallbacks, or placeholder markers (`TODO`, `FIXME`, `placeholder`, `dummyData`).

```bash
# Run adversarial hardening gate audit
syn harden

# Output structured report in JSON
syn harden --json
```

---

### `syn start`

Canonical session start command. Onboards human contributors or autonomous AI agents by inspecting active milestones, detecting the next pending task, and prompting to begin work or inspect documented innovations.

```bash
syn start
```

---

### `syn handoff`

Canonical session wrap-up command. Cleans expired worktree leases, runs automated pre-handoff verification, prompts for session hand-off notes, updates `HANDOFF.md`, and stages changes cleanly.

```bash
syn handoff
```

---

### `syn web`

Launches the embedded React 19 cybernetic dashboard on `localhost:3000` with visual telemetry, interactive task boards, dependency graphs, and a real-time web terminal bridge.

```bash
# Launch server and automatically open your default browser
syn web --open

# Launch on a specific custom port
syn web --port 8080
```

---

### `syn dash`

Launches a terminal-native full-screen TUI monitoring dashboard powered by Charm Bubble Tea, Lip Gloss, and Glamour.

```bash
syn dash
```

---

### `syn adapt`

Compiles and synchronizes governance rules, instructions, and slash commands across supported AI coding agents.

```bash
# Compile configurations for all detected agents
syn adapt

# Target a specific agent
syn adapt --agent claude
syn adapt --agent cursor
syn adapt --agent antigravity
syn adapt --agent copilot
```

---

### `syn worktree`

Manages isolated Git worktrees for concurrent, parallel multi-agent development swarms, complete with automatic lease management and cleanup.

```bash
# Create an isolated worktree for a task
syn worktree create <branch-name>

# List active worktree leases
syn worktree list

# Remove and clean an expired worktree
syn worktree remove <branch-name>
```

---

### `syn update`

Compiles the current workspace binary and updates the globally installed binary at `~/.syndicate/bin/syn`, utilizing atomic swap mechanics to guarantee zero in-use file lock errors.

```bash
syn update
```
