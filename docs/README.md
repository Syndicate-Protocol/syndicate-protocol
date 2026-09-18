# Syndicate Protocol Documentation

<p align="center">
  <img src="./images/syndicate-protocol.svg" alt="Syndicate Protocol Logo" width="160" />
</p>

Welcome to the official documentation for **Syndicate Protocol** — the Single Source of Truth (SSOT) and governance operating system for multi-agent and multi-contributor software engineering.

---

## Architecture at a Glance

Syndicate Protocol establishes an automated, sub-10ms governance loop that unites human engineers and autonomous AI agents around an unshakeable Single Source of Truth.

```mermaid
flowchart TD
    subgraph Agents ["Collaborative Swarm (Humans & Autonomous AI Agents)"]
        Human["Human Engineer"]
        Claude["Claude Code"]
        Cursor["Cursor AI"]
        AGY["Google Antigravity"]
        Copilot["GitHub Copilot"]
    end

    subgraph Protocol ["The 5 Living Root Documents"]
        SSOT["SSOT.md\n(Authority & Invariants)"]
        TASK["TASK.md\n(Single Task Truth)"]
        HANDOFF["HANDOFF.md\n(Session State Pointer)"]
        AGENTS["AGENTS.md\n(Rules of Engagement)"]
        README["README.md\n(Public Orientation)"]
    end

    subgraph Engine ["High-Speed Native Engine ('syn' CLI)"]
        Doctor["syn doctor\n(Health Diagnostics)"]
        Verify["syn verify\n(Anti-Drift AST Audit)"]
        Harden["syn harden\n(Rule 6 Adversarial Gate)"]
        Dashboard["syn web / syn dash\n(Live Visual Telemetry)"]
    end

    Human & Claude & Cursor & AGY & Copilot -->|Read & Update| Protocol
    Protocol -->|Automated Inspection| Engine
    Engine -->|Enforce Zero-Debt & Zero-Drift| Agents
```

---

## Why Syndicate Protocol?

| Capability | Standard AI Pair Programming | With Syndicate Protocol |
|---|---|---|
| **Context Retention** | Lost between chat sessions or prompt limits | Persistent, unbroken continuity across sessions |
| **Task Tracking** | Hallucinated progress, duplicate trackers | Single Source of Truth (`TASK.md`); shadow trackers blocked |
| **Code Staleness** | Documentation drifts within days of code changes | AST signature analysis flags mismatched code exports |
| **Task Completion Quality** | Phantom "done" flags on stubs and mocks | Adversarial Rule 6 hardening gate halts pipelines on stubs |
| **Multi-Agent Coordination** | Agents overwrite each other's work blindly | Isolated worktrees (`syn worktree`) with atomic lease locking |
| **Tooling Footprint** | Heavy cloud lock-in or proprietary subscriptions | Zero cloud dependencies; standalone native Go binary |

---

## Quick Navigation

### 🚀 Getting Started

- [**Quickstart Guide**](./getting-started/quickstart.md) — Get up and running in under 2 minutes.
- [**Installation Guide**](./getting-started/installation.md) — Install the `syn` CLI globally on Windows, macOS, or Linux.
- [**Project Adoption**](./getting-started/adoption.md) — Adopt the protocol in an existing codebase or initialize a new project.

### 📖 Reference & Manuals

- [**CLI Command Reference**](./cli/commands.md) — Complete user guide for all `syn` CLI commands and options.
- [**Multi-Agent Integration**](./guides/multi-agent.md) — Connect Claude Code, Cursor, Antigravity, and GitHub Copilot.
- [**Cybernetic Web Dashboard**](./guides/web-dashboard.md) — Launch and navigate the embedded React 19 visual dashboard.
- [**Contributing Guide**](../CONTRIBUTING.md) — How to contribute to templates, specifications, and documentation.

---

## The Core Contributor Cycle

Every collaborative session follows a predictable, highly disciplined four-step cadence:

```mermaid
sequenceDiagram
    autonumber
    actor Contributor as Contributor / AI Agent
    participant CLI as syn CLI
    participant Repo as Living Root Documents

    Contributor->>CLI: syn start
    CLI->>Repo: Audit baseline & find next task
    CLI-->>Contributor: Active roadmap milestone & task prompt

    Note over Contributor: Implement code & write tests

    Contributor->>CLI: syn verify --deep
    CLI->>Repo: Verify AST signatures & file references
    CLI-->>Contributor: Verification PASSED (Zero drift)

    Contributor->>CLI: syn harden
    CLI->>Repo: Scan for stubs, mocks, and placeholders
    CLI-->>Contributor: Hardening APPROVED (100% integrity)

    Contributor->>CLI: syn handoff
    CLI->>Repo: Update HANDOFF.md & stage clean git commit
```

---

## Community & Open Access

Syndicate Protocol's templates, living documents, specifications, and documentation are 100% open and free under the [Syndicate Community Source License](../LICENSE). Pre-compiled standalone binaries are distributed free of charge for all supported operating systems.
