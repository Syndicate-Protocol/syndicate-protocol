# Living Innovation Registry — Suggestions & Architectural Enhancements

> **Purpose**: Decouple immediate bug fixes from future architectural ideas. Fixes are resolved immediately at task/milestone close-out (maintaining the Rule 6 zero-debt invariant); suggestions, enhancements, and feature opportunities are cataloged here for on-demand review and deliberate promotion into `TASK.md`.
> **Last Updated**: `2026-09-16`

---

## 1. Operating Rules for Innovation Items

1. **No Unplanned Rabbit Holes**: Do not automatically implement suggestions or enhancements during active milestone execution unless explicitly promoted by the user.
2. **Standard Classification**:
   - `SUGGESTION`: Ergonomic, maintainability, or clean code refinement.
   - `ENHANCEMENT`: High-value capability extension or architectural expansion.
   - `FEATURE`: Standalone new user-facing functionality or CLI command.
3. **Promotion Flow**:
   - Use `syn discover` to run an on-demand codebase analysis and discover new innovations.
   - Use `syn discover list` to review pending innovations.
   - Use `syn discover promote --id INN-XXX` to promote an approved item into an active task in `TASK.md`.

---

## 2. Active Innovation Registry

### INN-001: Automatic CycloneDX A-BOM Verification on Agent Skill Ingestion

- **Type**: `ENHANCEMENT`
- **Category**: `security`
- **Impact**: `HIGH`
- **Status**: `PROMOTED`
- **Description**: Validate ingested skills against known SHA256 checksums in the A-BOM to detect untracked tampering.
- **Rationale**: Elevates zero-trust supply chain defenses for all multi-agent skill directories.

### INN-002: Live Real-Time Lease Watcher SSE Stream in Web Dashboard

- **Type**: `ENHANCEMENT`
- **Category**: `architecture`
- **Impact**: `HIGH`
- **Status**: `PROMOTED`
- **Description**: Stream background lease watcher prune and acquisition events over `/api/events` to dynamically re-render the dashboard monitor.
- **Rationale**: Eliminates manual polling and ensures developers see live swarm collisions in real time.

### INN-003: Ed25519 Cryptographic Witness Signing for Milestone Completions

- **Type**: `ENHANCEMENT`
- **Category**: `governance`
- **Impact**: `MEDIUM`
- **Status**: `PENDING`
- **Description**: Locally sign milestone transitions in `TASK.md` using developer Ed25519 keypairs (`.syndicate/identity.key`).
- **Rationale**: Provides tamper-evident proof of milestone approval across multi-agent swarms.

### INN-004: Interactive In-Browser AST Dependency Graph Visualizer

- **Type**: `FEATURE`
- **Category**: `dx`
- **Impact**: `MEDIUM`
- **Status**: `PENDING`
- **Description**: Render an interactive Force-Directed SVG dependency graph of AST symbols and files in the web dashboard.
- **Rationale**: Enhances blast-radius comprehension before applying complex multi-file delta changes.

### INN-005: Brownfield Repository Lint & Automated SSOT Repair (`syn doctor --fix`)

- **Type**: `SUGGESTION`
- **Category**: `dx`
- **Impact**: `HIGH`
- **Status**: `PENDING`
- **Description**: Automatically regenerate or fix missing SSOT sections, broken relative links, or outdated badges using `syn doctor --fix`.
- **Rationale**: Reduces onboarding friction for external repositories adopting Syndicate Protocol.

### INN-006: Distributed Delta Change Sync via Signed Git Bundles

- **Type**: `FEATURE`
- **Category**: `architecture`
- **Impact**: `HIGH`
- **Status**: `PENDING`
- **Description**: Allow distributed swarms across isolated network boundaries to export and import delta change packages (`docs/changes/`) as cryptographically signed git bundle packages (`syn change export` and `syn change import`).
- **Rationale**: Enables multi-agent swarms operating in air-gapped or separated git environments to synchronize governance changes with tamper-proof cryptographic attestation without central cloud servers.

### INN-007: Bidirectional WebSocket Pseudoterminal (PTY) Streaming

- **Type**: `ENHANCEMENT`
- **Category**: `dx`
- **Impact**: `MEDIUM`
- **Status**: `PENDING`
- **Description**: Upgrade `/api/terminal/exec` to a stateful WebSocket connection with full pseudoterminal (PTY) support, ANSI color pass-through, interactive input prompts, and dynamic window resize handling.
- **Rationale**: Replaces batch HTTP polling with a responsive, live terminal experience in the cybernetic web dashboard.

### INN-008: Multi-Agent Conflict Resolution Matrix via 3-Way AST Merge

- **Type**: `FEATURE`
- **Category**: `architecture`
- **Impact**: `HIGH`
- **Status**: `PENDING`
- **Description**: When two agents hold leases on related files or when git merge conflicts occur, use AST symbol graphs to perform semantic 3-way reconciliation rather than raw text conflict markers.
- **Rationale**: Drastically reduces merge collisions in swarm worktrees by understanding structural boundaries of classes, methods, and types.

### INN-009: Automated Private-to-Public Mirror & Multi-Arch Release Pipeline

- **Type**: `ENHANCEMENT`
- **Category**: `governance`
- **Impact**: `HIGH`
- **Status**: `PROMOTED`
- **Description**: Automated release & mirror pipeline that builds closed-source CLI binaries inside this private monorepo, generates SLSA provenance attestations and CycloneDX A-BOMs, and synchronizes the public kit and documentation to `https://github.com/Syndicate-Protocol/syndicate-protocol`.
- **Rationale**: Eliminates the "Two-Window Tax" allowing all engineering to happen in one private monorepo while automating public community distribution and release downloads.

### INN-010: Real-Time Swarm Topology & Agent Heartbeat Visualizer

- **Type**: `FEATURE`
- **Category**: `dx`
- **Impact**: `MEDIUM`
- **Status**: `PENDING`
- **Description**: In the React 19 web dashboard, display an animated network topology map showing active agent IDs, worktree branches, acquired file leases, and heartbeat liveness pings in real time.
- **Rationale**: Gives engineering leads immediate situational awareness of which agents are active and which files are currently locked.

---

## 3. History of Promoted & Completed Innovations

| ID | Title | Promoted Date | Milestone / Task | Status |
| :--- | :--- | :--- | :--- | :--- |
| `INN-001` | Automatic CycloneDX A-BOM Verification on Ingestion | 2026-09-16 | Milestone 13 / Task 13.1 | `COMPLETED` |
| `INN-002` | Live Real-Time Lease Watcher SSE Stream in Web Dashboard | 2026-09-16 | Milestone 13 / Task 13.2 | `COMPLETED` |

