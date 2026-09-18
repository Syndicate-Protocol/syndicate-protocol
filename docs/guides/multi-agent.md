# Multi-Agent Integration Guide

Syndicate Protocol is designed from the ground up for multi-agent software engineering, ensuring consistent context, zero drift, and unified governance across different AI coding environments.

---

## Supported Agents & IDEs

| Agent / IDE | Integration Mechanism | Command |
|---|---|---|
| **Claude Code** | Custom slash commands (`.claude/commands/syn-*.md`) | `syn adapt --agent claude` |
| **Cursor** | MDC governance rules (`.cursor/rules/syndicate-protocol.mdc`) | `syn adapt --agent cursor` |
| **Google Antigravity** | Agent skills & rules (`.agents/skills/syn-*/SKILL.md`) | `syn adapt --agent antigravity` |
| **GitHub Copilot** | Custom workspace instructions (`.github/copilot-instructions.md`) | `syn adapt --agent copilot` |
| **OpenAI Codex** | AGENTS standard (`AGENTS.md`) | Automatic |

---

## Compiling Configurations

You can generate all necessary configuration files for your workspace in one step:

```bash
syn adapt
```

This inspects your project, detects installed agents, and generates tailored instruction files so that every agent immediately understands:
- The authority of `SSOT.md`.
- How to consult `TASK.md` before writing code.
- How to record handoffs in `HANDOFF.md`.
- The strict requirement of Rule 6 (no mocks or stubs).

---

## Using Slash Commands in Claude Code

When working with Claude Code, the following commands are available directly in your chat:

- `/syn-start`: Automatically runs baseline verification, inspects active tasks, and selects the next item on the roadmap.
- `/syn-verify`: Runs anti-drift verification on demand.
- `/syn-harden`: Executes the adversarial hardening gate to verify recent changes are real, functioning code.
- `/syn-handoff`: Wraps up the active session, updates `HANDOFF.md`, and stages git changes.

---

## Parallel Agent Development with Worktrees

When running multiple AI agents concurrently on different features, use `syn worktree` to provide each agent with an isolated working copy:

```bash
# Spawn an isolated worktree for an agent
syn worktree create feature/user-auth

# Inspect all active worktrees and leases
syn worktree list

# Clean up once the worktree branch is merged
syn worktree remove feature/user-auth
```
