# Syndicate Protocol — 31-Repository Architectural Synthesis Matrix

> **Target**: Elevate **Syndicate Protocol** into an ultra-robust, cross-agent, anti-drift operating system by synthesizing architectural breakthroughs from 31 cutting-edge repositories across the AI agent, security scanner, and developer tooling ecosystem.

---

## Executive Summary of Inspected Repositories

### Group 1: Agent Architecture, Memory & Orchestration (Repos 1–19)

| # | Repository | Core Superpower | Primary Synergy for Syndicate Protocol |
|---|---|---|---|
| 1 | **syntax-syndicate/backpass** | Transcript loss gradient descent | Automatically distill recurring agent mistakes into SSOT rules and anti-drift rules |
| 2 | **syntax-syndicate/metaharness** | Ed25519 witness manifests & Pareto cascade | Cryptographically sign task completions; cost-optimized multi-model routing |
| 3 | **syntax-syndicate/SkillRadar** | Skill security grading & Budget Doctor | Audit `.agents/skills/` for safety violations (Profiles A-D) & prevent context window bloat |
| 4 | **syntax-syndicate/GitNexus** | Tree-sitter AST graph & blast radius | Compute precise impact radius of agent file edits before applying changes |
| 5 | **syntax-syndicate/luvus** | UHP 1.0 & Worktree path leases | Prevent multi-agent file edit collisions via lease locks; detect live agent token spend |
| 6 | **syntax-syndicate/rome** | Git-tracked executable actions | Compound environments with version-controlled, reusable developer commands |
| 7 | **syntax-syndicate/distilly** | 5-tool MCP model & bounded budgets | Keep MCP servers ultra-lean, deterministic, and within context budgets |
| 8 | **syntax-syndicate/crm** | Turborepo multi-app topology | Clean package/app isolation for protocol CLI, daemon, web dashboard, and plugins |
| 9 | **mattpocock/sandcastle** | Docker/Firecracker isolated worktrees | Execute dangerous agent commands and tests in ephemeral throwaway sandboxes |
| 10 | **syntax-syndicate/memmy-agent** | Cross-agent task continuity relay | Relay project context seamlessly across Claude Code, DeepSeek, Codex, Cursor |
| 11 | **syntax-syndicate/open-brain** | Epistemic status & authority hierarchy | Strict ranking of truth (User > Tool > Inferred); memory lifecycle state machine |
| 12 | **memgraph/memgraph** | High-performance in-memory Cypher graph | Graph-native querying for codebase dependencies, rule inheritance, and session lineage |
| 13 | **syntax-syndicate/hermes-agent** | Persona (`SOUL.md`), context compression | Deep agent identity framing, `/compress` context management, multi-channel gateways |
| 14 | **syntax-syndicate/hermes-ecosystem** | Living ecosystem map & hybrid search | Ecosystem registry with security reviews, star trends, and hybrid BM25+vector RAG |
| 15 | **syntax-syndicate/hermes-atlas-mcp** | Universal one-command MCP installer | Auto-detect developer IDE configurations (Claude, Cursor, Codex) and mount servers |
| 16 | **syntax-syndicate/hermes-skill-factory** | Autonomous meta-skill generator | Silently observe agent workflows and propose automated, reusable skills on demand |
| 17 | **syntax-syndicate/agency-agents** | 230+ agent roster & cross-tool compiler | Universal cross-tool agent generator for Antigravity, Claude Code, Cursor, Windsurf, etc. |
| 18 | **syntax-syndicate/mempalace** | Spatial memory palace & temporal KG | Wings/Rooms/Drawers structure, pre-compaction hooks, temporal validity windows |
| 19 | **syntax-syndicate/mempalace-triage** | Heuristic classifier & diff red flags | Scan agent PRs and proposed deltas for security red flags and noise before review |

### Group 2: Agent Security, Skill Antivirus & Defense-in-Depth (Repos 20–31)

| # | Repository | Core Superpower | Primary Synergy for Syndicate Protocol |
|---|---|---|---|
| 20 | **syntax-syndicate/agent-skill-scanner** | Cisco AI Defense: YARA, AST dataflow, pipeline taint, CEL rules | Multi-stage pipeline taint analysis checking shell pipelines and AST dataflow in skills |
| 21 | **syntax-syndicate/skill-sentinel** | Enkrypt AI: OWASP Agentic Top 10 scanner | Multi-provider fallback detection for data exfiltration, command injection, and transitive trust abuse |
| 22 | **syntax-syndicate/SkillSpector-v0** | NVIDIA: Static + LLM analysis & live OSV.dev CVEs | Real-time unauthenticated dependency CVE checks via OSV.dev batch API; OMS signature recognition |
| 23 | **syntax-syndicate/agent-scan** | Snyk / Invariant Labs: MCP server & skill scanner | Scans `mcp.json` configs for toxic flows, tool poisoning attacks, and secret leakage with consent prompts |
| 24 | **syntax-syndicate/repo-forensics** | Zero-dependency ~18ms pre-exec shell gate | Blocks pipe-to-shell, sensitive file reads, and malicious installs before shell execution runs |
| 25 | **syntax-syndicate/SkillWard** | Fangcun AI: 3-stage sandbox verification | Docker sandbox execution catching runtime credential theft and cron/SSH persistence missed by static scans |
| 26 | **syntax-syndicate/skillsentry** | Zero-dep behavior chains & evasion scanner | Detection of composite attack chains (`READ + NETWORK + DELETE`), RTLO, homoglyphs, zero-width spaces |
| 27 | **syntax-syndicate/skillhawk** | Node.js rule engine (`SH001`-`SH013`) | Structured rule IDs with exact line number, code snippet match, and remediation guidance |
| 28 | **syntax-syndicate/AI-Infra-Guard** | Tencent Zhuque Lab: AI Red Teaming platform | SkillJack persistent backdoor defense and MCP Unchained tool-poisoning detection |
| 29 | **syntax-syndicate/medusa-ai-security-scanner** | Pantheon Security: 40k+ rules across 79 analyzers | AI editor config poisoning detection (28+ tools), UCP/AP2/ACP agent protocol security checks |
| 30 | **syntax-syndicate/claude-skill-antivirus** | 9-engine modular scanner | SSRF/cloud metadata checks (169.254.169.254), sub-agent task loop abuse, dangerous tool combinations |
| 31 | **syntax-syndicate/ai-skill-scanner** | Differential PR security scanner (`--ci-pr`) | PR-level delta security auditing: identifies whether a PR adds, worsens, or fixes vulnerabilities |

### Group 3: Enterprise Agent Identity, Multi-Session Harness, Spec-Driven SDLC & Provenance Security (Repos 32–35)

| # | Repository | Core Superpower | Primary Synergy for Syndicate Protocol |
|---|---|---|---|
| 32 | **syntax-syndicate/zeroid** | Autonomous Agent Identity Management System (AAIMS) | WIMSE/SPIFFE agent identity URIs (`spiffe://syndicate/{project}/agent/{id}`), standard coding agent scope vocabulary (`tools:read`, `tools:write`, `tools:execute`), scope attenuation, and cascade revocation |
| 33 | **syntax-syndicate/codeoid** | Multi-Agent Coding Harness (Bun/Rust Cockpit) | Worktree session isolation, zero-trust loopback token guard, background lease daemon watcher (`syn lease watch`), and lease heartbeat renewals (`syn lease heartbeat`) |
| 34 | **syntax-syndicate/ai-factory** | Spec-Driven SDLC (`/spec → /proceed → /ship`) | Deterministic CI/CD pull request gate (`.github/workflows/syndicate.yml`), pre-commit security filtering, template drift detection (`syn verify --templates`), and adversarial review bench |
| 35 | **syntax-syndicate/palisade-scan** | Zero-Trust ML & Supply Chain Security | Zero-trust artifact verification, Agent Software Bill of Materials (A-BOM: `syn bom`), SLSA provenance attestations, and GitHub Action security workflows |

---

## Core Architectural Pillars for Syndicate Protocol

### Pillar 1: Epistemic SSOT & Memory Architecture
*Derived from: `open-brain`, `mempalace`, `memmy-agent`, `backpass`*

1. **Epistemic Authority Hierarchy**:
   $$\text{Direct User Statement} > \text{User-Curated SSOT} > \text{Tool / Test Observation} > \text{Provider Inference} > \text{Protocol Inference} > \text{Agent Claim}$$
2. **Epistemic Status Labeling**:
   Tag assertions across `HANDOFF.md`, `TASK.md`, and memory items:
   - `[user_confirmed]`
   - `[tool_observed]`
   - `[curated_ssot]`
   - `[inferred]`
   - `[stale]`
   - `[contradicted]`
3. **Memory Palace Structure**:
   Organize protocol context into Wings, Rooms, and Drawers.
4. **Pre-Compaction Hooks**:
   Snapshot active session state before context compression.

---

### Pillar 2: Swarm Concurrency & Worktree Leases
*Derived from: `luvus`, `sandcastle`, `metaharness`, `codeoid`*

1. **Path Leases (`syn lease`)**:
   Prevent multi-agent file collisions in parallel swarms by acquiring path-level leases in `.syndicate/leases.json`:
   ```bash
   syn lease acquire --paths "internal/web/**" --agent "agent-alpha" --ttl 30m
   ```
2. **Lease Heartbeat & Background Watcher Daemon (`syn lease heartbeat` / `syn lease watch`)**:
   `syn lease heartbeat --id <lease-id> --ttl 45m` extends TTL for long-running workflows; `syn lease watch` cleans expired leases in the background.
3. **Cryptographic Witness Signatures**:
   Sign milestones and change packages with local Ed25519 keys for tamper evidence.

---

### Pillar 3: Blast-Radius Analysis & Diff Triage
*Derived from: `GitNexus`, `mempalace-triage`, `ai-skill-scanner`*

1. **AST Blast Radius (`syn blast-radius`)**:
   Calculate affected functions, types, and dependent files before changes merge.
2. **Diff Triage & Red Flags (`syn triage`)**:
   Scan proposed changes for sensitive file touches, unpinned dependencies, or dangerous shell patterns.
3. **Differential PR Scanning**:
   Only alert on newly introduced or worsened security risks in the current branch.

---

### Pillar 4: AI Skill & Agent Security Profiler
*Derived from: `agent-skill-scanner`, `SkillWard`, `skillsentry`, `skillhawk`, `medusa`, `claude-skill-antivirus`, `repo-forensics`*

1. **Integrated Static Security Scanner (`syn doctor --security` / `syn scan`)**:
   Zero-dependency Go security analyzer scanning `.agents/skills/`, `.claude/commands/`, and repo configs.
2. **Rule Categories**:
   - `SH001` Pipe-to-shell (`curl ... | bash`, `wget ... | sh`)
   - `SH002` Base64 / hex obfuscated command execution
   - `SH003` Destructive file operations (`rm -rf /`, `mkfs`)
   - `SH004` Credential harvesting (`.env`, `~/.ssh`, `~/.aws`, private keys)
   - `SH005` Persistence backdoor (`crontab`, startup scripts, systemd)
   - `SH006` Evasion & Steganography (Unicode homoglyphs, RTLO `\u202e`, zero-width characters)
   - `SH007` Behavior chains (`READ_SENSITIVE + NETWORK_SEND`)
   - `SH008` SSRF & Cloud Metadata (`169.254.169.254`)
   - `SH009` Prompt Injection & Role Overrides (`ignore previous instructions`, `<<SYS>>`, `[SYSTEM]`)
3. **Security Profiles**:
   - **Profile A (Safe)**: Read-only, idempotent.
   - **Profile B (Local Edit)**: File modification in leased paths.
   - **Profile C (Network)**: Outbound API calls to declared endpoints.
   - **Profile D (Privileged)**: Shell execution, system modification (Requires user confirmation).

---

### Pillar 5: Universal Ecosystem & 1-Click MCP Auto-Installer
*Derived from: `hermes-atlas-mcp`, `distilly`, `rome`, `agency-agents`*

1. **1-Click MCP Auto-Installer (`syn mcp install`)**:
   Auto-detects and updates:
   - Claude Desktop (`%APPDATA%\Claude\claude_desktop_config.json` / macOS / Linux)
   - Cursor (`~/.cursor/mcp.json` / `.cursor/mcp.json`)
   - Claude Code (`~/.claude.json`)
   - Antigravity / Gemini
2. **Safe Atomic Merge**:
   Non-destructive JSON patcher that merges Syndicate Protocol's MCP entry without modifying existing servers.
3. **Lean Bounded MCP Model**:
   Preserves context window by exposing 5-7 core tools.

---

### Pillar 6: Enterprise Agent Identity & Capability Scopes
*Derived from: `zeroid`, `codeoid`*

1. **WIMSE/SPIFFE Agent Identity URIs**:
   Standard format: `spiffe://syndicate/{project}/agent/{agent_id}`. Gives every autonomous agent an explicit, cryptographically verifiable identity distinct from human users.
2. **Standard Coding Agent Scope Vocabulary**:
   - `tools:read` — Read-only file inspection, grep, and directory listings.
   - `tools:write` — File mutations and content replacement.
   - `tools:execute` — Shell commands and terminal executions.
   - `tools:network` — Web requests, doc fetching, and web search.
   - `tools:agent` — Spawning or delegating to sub-agents.
   - `tools:vcs` — Git commits, branches, worktrees, and merges.
3. **Scope Attenuation & Lease Concurrency**:
   When an agent delegates a task or requests a sub-path lease, granted scopes are strictly attenuated by the parent agent's capability envelope.

---

### Pillar 7: Zero-Trust Provenance, A-BOM & Template Integrity
*Derived from: `palisade-scan`, `ai-factory`*

1. **Agent Software Bill of Materials (`syn bom`)**:
   Generates a cryptographically verifiable inventory of all agent skills, prompt commands, IDE rules, and SSOT living documents with SHA256 checksums, byte sizes, detected tool capability scopes, and provenance.
2. **Living Document Template Drift Engine (`syn verify --templates`)**:
   Audits workspace living documents against standard protocol templates (`syndicate-protocol-kit/`) to ensure no mandatory sections, anti-mock rules, or SEFN review standards are diluted or removed over time.
3. **Automated CI/CD Workflow Gate (`.github/workflows/syndicate.yml` & `syn ci init`)**:
   Enforces anti-drift (`syn verify --deep`), Rule 6 anti-mock verification (`syn harden`), and AI security profiler (`syn scan --fail-on HIGH`) on every pull request and push to main/master.
4. **Global Binary Synchronization (`syn update`)**:
   Provides instantaneous zero-friction workspace binary compilation and global PATH synchronization to ensure developer environments and automated pre-commit gates remain perfectly aligned.
