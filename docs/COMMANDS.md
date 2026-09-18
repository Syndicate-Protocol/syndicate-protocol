<p align="center">
  <img src="./images/syndicate-protocol.svg" alt="Syndicate Protocol Logo" width="180" />
</p>

# 📖 Syndicate Protocol (`syn`) — Complete CLI Command & Testing Reference

> **Role & Purpose**: This reference manual provides a detailed catalog of every command, subcommand, flag, and testing scenario available in the **Syndicate Protocol** native Go CLI (`syn`). It is structured as an authoritative operational guide for daily development, quality assurance testing, and multi-agent coordination.

---

## 📑 Table of Contents

- [🚀 Quick Reference & Daily Testing Workflows](#-quick-reference--daily-testing-workflows)
- [1. Core Governance & Anti-Drift Engine](#1-core-governance--anti-drift-engine)
  - [`syn start`](#syn-start)
  - [`syn verify`](#syn-verify)
  - [`syn harden`](#syn-harden)
  - [`syn doctor`](#syn-doctor)
  - [`syn next`](#syn-next)
  - [`syn handoff`](#syn-handoff)
  - [`syn hook`](#syn-hook)
- [2. Project Adoption, Scaffolding & CI/CD](#2-project-adoption-scaffolding--cicd)
  - [`syn init`](#syn-init)
  - [`syn adopt`](#syn-adopt)
  - [`syn adapt`](#syn-adapt)
  - [`syn ci`](#syn-ci)
- [3. Multi-Agent Swarm Concurrency & Isolation](#3-multi-agent-swarm-concurrency--isolation)
  - [`syn worktree`](#syn-worktree)
  - [`syn lease`](#syn-lease)
- [4. Delta Specifications & Innovation Engine](#4-delta-specifications--innovation-engine)
  - [`syn change`](#syn-change)
  - [`syn discover`](#syn-discover)
- [5. Security, Supply Chain & Code Safety](#5-security-supply-chain--code-safety)
  - [`syn scan`](#syn-scan)
  - [`syn triage`](#syn-triage)
  - [`syn bom`](#syn-bom)
  - [`syn blast-radius`](#syn-blast-radius)
- [6. Visual Dashboards, TUIs & Agent Bridges](#6-visual-dashboards-tuis--agent-bridges)
  - [`syn web`](#syn-web)
  - [`syn dash`](#syn-dash)
  - [`syn shell`](#syn-shell)
  - [`syn ui`](#syn-ui)
  - [`syn mcp`](#syn-mcp)
- [7. System, Binary Maintenance & Feature Flags](#7-system-binary-maintenance--feature-flags)
  - [`syn update`](#syn-update)
  - [`syn install`](#syn-install)
  - [`syn version`](#syn-version)
  - [`syn feature`](#syn-feature)
  - [`syn env`](#syn-env)
  - [`syn completion`](#syn-completion)

---

## 🚀 Quick Reference & Daily Testing Workflows

### The Daily Contributor Loop
```bash
# 1. Onboard / start session: Verify baseline, inspect active milestone & next task, prompt to begin or review innovations
syn start

# 2. Work on tasks in small, tested chunks...

# 3. Audit working changes for stubs, fake status, and mock fallbacks (Rule 6)
syn harden

# 4. Wrap up session: Enforce clean environment gates, update HANDOFF.md, and stage changes
syn handoff
```

### The CI / PR Quality Gate Suite
```bash
syn verify --deep --json
syn harden --strict --report HARDENING_REPORT.md
syn scan --fail-on high
syn bom --json
```

---

## 1. Core Governance & Anti-Drift Engine

### `syn start`
The canonical onboarding and session resumption command for Syndicate Protocol projects.
It performs an initial baseline health check, parses `HANDOFF.md` and `TASK.md` to identify the active milestone and immediate next task, inspects `docs/INNOVATION.md`, and interactively prompts the developer whether to **Begin Next Task** (marking it `[/]` in `TASK.md` and staging it) or **Review Documented Possible Innovations** (with instant promotion capability).

- **Syntax**: `syn start [flags]`
- **Flags**:
  - `-b, --begin`: Automatically marks the next pending task as in-progress (`[/]`) and stages `TASK.md` non-interactively.
  - `-i, --review-innovations`: Opens the cataloged innovations review menu immediately.
  - `-s, --status-only`: Prints onboarding status summary and exits without prompting.
  - `--json`: Outputs onboarding context and next task in structured JSON format.
  - `--skip-verify`: Skips baseline SSOT integrity verification pre-flight.
- **Testing Scenarios**:
  ```bash
  # Interactive onboarding and task resumption
  syn start

  # Non-interactively activate the next roadmap task and stage TASK.md
  syn start --begin

  # Directly review pending innovations cataloged in docs/INNOVATION.md
  syn start --review-innovations

  # Fast inspect without interactive prompt
  syn start --status-only

  # Machine-readable JSON output for agent automation
  syn start --json
  ```

---

### `syn verify`
Runs the primary Single Source of Truth (SSOT) integrity check, verifying all 5 living root documents, the `docs/` hub, task references, and absence of shadow trackers.

- **Syntax**: `syn verify [flags]`
- **Flags**:
  - `--deep`: Runs deep AST code signature checks and git staleness recency audits.
  - `--templates`: Audits living documents for template drift against standard kit.
  - `--json`: Emits results in machine-readable JSON format.
- **Testing Scenarios**:
  ```bash
  # Standard fast anti-drift verification (< 10ms)
  syn verify

  # Comprehensive AST signature and Git timestamp audit
  syn verify --deep

  # Audit compliance against syndicate-protocol-kit templates
  syn verify --templates

  # Output structured JSON for automation scripts
  syn verify --deep --json
  ```

---

### `syn harden`
Adversarial subagent clean-context audit checking all files referenced in completed `[x]` tasks in `TASK.md` to guarantee zero stubs, dummy mocks, or fake returns (Strict Rule 6 enforcement).

- **Syntax**: `syn harden [flags]`
- **Flags**:
  - `--strict`: Fails with non-zero exit code on any suspicious comment, stub, or placeholder.
  - `--report <file>`: Writes detailed adversarial gate audit report to markdown file.
  - `--task <task-name>`: Scopes verification to a specific named task in `TASK.md`.
- **Testing Scenarios**:
  ```bash
  # Standard gate verification
  syn harden

  # Enforce strict zero-debt gate with written audit artifact
  syn harden --strict --report HARDENING_REPORT.md
  ```

---

### `syn doctor`
High-speed repository diagnostic health check analyzing manifest validity, git hygiene, anti-drift health, and package manifest linter hygiene (`package.json`).

- **Syntax**: `syn doctor [flags]`
- **Flags**:
  - `--fix`: Automatically repairs remediable health issues such as configuring `knip.ignoreBinaries` in `package.json` to eliminate "Unlisted binary" linter warnings.
- **Testing Scenarios**:
  ```bash
  # Run repository health diagnostic
  syn doctor

  # Automatically repair package manifest hygiene issues
  syn doctor --fix
  ```

---

### `syn next`
Parses `HANDOFF.md` and `TASK.md` and renders the active milestone, immediate next tasks, and recommended start order using rich Glamour markdown terminal formatting.

- **Syntax**: `syn next`
- **Testing Scenario**:
  ```bash
  syn next
  ```

---

### `syn handoff`
Wraps up the active development session, executes comprehensive clean-environment verification gates (SSOT reference integrity, Rule 6 anti-mock audit, expired swarm lease cleanup, shadow tracker sweep), captures structured SEFN review notes, updates `HANDOFF.md` programmatically, and stages all changes into git ready to be handed off.

- **Syntax**: `syn handoff [flags]`
- **Flags**:
  - `-m, --summary <string>`: Accomplishments and completed tasks summary for this session.
  - `--fixes <string>`: Mandatory fixes, warnings, or debt remediated.
  - `--next <string>`: Immediate next roadmap task to tackle upon resumption.
  - `--idea <string>`: Optional suggestion/enhancement to pool into `docs/INNOVATION.md`.
  - `-c, --commit <string>`: Create a git commit with this message after staging.
  - `-f, --force`: Bypass verification gate failures and proceed with handoff.
  - `--no-stage`: Skip automated git staging (`git add -A`) upon session wrap-up.
  - `--non-interactive`: Execute wrap-up without interactive terminal prompts.
  - `--audit`: Audits epistemic status tags across `HANDOFF.md` (default: `true`).
  - `--audit-only`: Non-interactive mode that runs the tag audit without prompting for notes.
  - `--skip-env`: Skips clean-environment verification gates.
- **Testing Scenarios**:
  ```bash
  # Interactive handoff wrap-up (prompts for SEFN notes, verifies environment, updates HANDOFF.md, and stages)
  syn handoff

  # Non-interactive script wrap-up with commit
  syn handoff --non-interactive -m "Complete Milestone 17" --next "Start Milestone 18" -c "docs: handoff session"

  # Automated epistemic tag audit for CI
  syn handoff --audit-only
  ```

---

### `syn hook`
Manages automated Git pre-commit hooks that enforce `syn verify` and `syn harden` before any git commit can succeed.

- **Syntax**: `syn hook [command]`
- **Subcommands**:
  - `install`: Installs the executable pre-commit anti-drift and hardening hook into `.git/hooks/pre-commit`.
  - `status`: Checks whether the Syndicate pre-commit hook is active.
  - `uninstall`: Safely removes the Syndicate pre-commit hook.
- **Testing Scenarios**:
  ```bash
  # Check if hooks are active
  syn hook status

  # Install git hook
  syn hook install

  # Remove git hook
  syn hook uninstall
  ```

---

## 2. Project Adoption, Scaffolding & CI/CD

### `syn init`
Interactive terminal UI wizard that automatically inspects project manifests and initializes `SSOT.md`, `README.md`, `TASK.md`, `HANDOFF.md`, and `AGENTS.md`.

- **Syntax**: `syn init [flags]`
- **Flags**:
  - `-n, --name <string>`: Project name override.
  - `-y, --yes`: Non-interactive mode using auto-detected defaults.
- **Testing Scenarios**:
  ```bash
  # Interactive wizard (Huh TUI)
  syn init

  # Non-interactive silent initialization
  syn init -y --name "MyCoolProject"
  ```

---

### `syn adopt`
Brownfield adoption engine. Analyzes an existing repository (Go, Node.js, Python, Rust), detects tech stack, package managers, test runners, and entrypoints, and non-destructively scaffolds Syndicate Protocol governance without overwriting source code.

- **Syntax**: `syn adopt [target-directory] [flags]`
- **Flags**:
  - `-n, --name <string>`: Custom project name for adopted codebase.
- **Testing Scenarios**:
  ```bash
  # Adopt current directory
  syn adopt .

  # Adopt a specific external project
  syn adopt ../legacy-api --name "LegacyAPI"
  ```

---

### `syn adapt`
Universal Multi-Agent Adapter Compiler. Reads `AGENTS.md` and `SSOT.md` and compiles native configuration files, system rules, and slash command definitions for leading AI agent ecosystems.

- **Syntax**: `syn adapt [flags]`
- **Flags**:
  - `-a, --agent <ecosystem>`: Target agent system (`claude`, `antigravity`, `cursor`, `copilot`, `codex`, `all`) (default: `"all"`).
  - `-d, --dir <path>`: Repository root directory (default: `"."`).
- **Testing Scenarios**:
  ```bash
  # Compile adapters for all AI ecosystems (.claude/, .agents/, .cursor/, .github/)
  syn adapt

  # Compile specifically for Antigravity IDE
  syn adapt --agent antigravity

  # Compile specifically for Claude Code
  syn adapt --agent claude
  ```

---

### `syn ci`
Scaffolds and manages continuous integration workflows enforcing anti-drift, hardening, and security in remote CI/CD pipelines.

- **Syntax**: `syn ci [command]`
- **Subcommands**:
  - `init`: Generates `.github/workflows/syndicate-ci.yml` with automated anti-drift and security validation.
- **Testing Scenarios**:
  ```bash
  # Scaffold GitHub Actions workflow
  syn ci init
  ```

---

## 3. Multi-Agent Swarm Concurrency & Isolation

### `syn worktree`
Manages isolated Git worktrees under `.worktrees/`, allowing multiple AI agents or human contributors to execute tasks in parallel without branch collision or dirty tree interference.

- **Syntax**: `syn worktree [command]`
- **Subcommands**:
  - `create <branch-or-name>`: Spawns a new isolated worktree and checks out a working branch.
  - `list`: Lists all active swarm worktrees with commit hashes and branches.
  - `verify <name>`: Runs anti-drift validation inside the specified worktree.
  - `merge <name>`: Verifies SSOT integrity, merges worktree branch into current branch, and cleans up the worktree directory.
  - `remove <name>`: Force-removes a worktree and deletes its branch.
- **Testing Scenarios**:
  ```bash
  # Create a parallel agent workspace
  syn worktree create feature-auth

  # View all active worktrees
  syn worktree list

  # Validate worktree state
  syn worktree verify feature-auth

  # Merge and safely clean up
  syn worktree merge feature-auth
  ```

---

### `syn lease`
Universal Harness Protocol (UHP 1.0) path leases with ZeroID agent identity and capability scopes. Prevents concurrent swarm agents from making conflicting edits to overlapping files.

- **Syntax**: `syn lease [command]`
- **Subcommands**:
  - `acquire <path>`: Requests an exclusive or shared lease on a file or glob.
  - `check <path>`: Checks if a specific file or directory is currently locked.
  - `list`: Lists all active leases in the swarm with TTLs and agent IDs.
  - `heartbeat <lease-id>`: Renews or extends an active lease TTL.
  - `release <lease-id>`: Releases an active lease.
  - `watch`: Starts a background daemon watcher that monitors and purges expired leases.
- **Testing Scenarios**:
  ```bash
  # Acquire an exclusive path lease for agent-01
  syn lease acquire internal/auth/login.go --agent agent-01 --exclusive --ttl 10m

  # Check if a file is currently leased
  syn lease check internal/auth/login.go

  # List active swarm leases
  syn lease list

  # Send heartbeat renewal
  syn lease heartbeat <lease-id> --extend 15m

  # Release lease
  syn lease release <lease-id>

  # Launch daemon watcher
  syn lease watch
  ```

---

## 4. Delta Specifications & Innovation Engine

### `syn change`
Structured delta-specification engine implementing Open-Closed governance. Allows authoring, inspecting, and tracking formal delta proposals under `docs/changes/` before applying modifications to living core specs.

- **Syntax**: `syn change [command]`
- **Subcommands**:
  - `new <title>`: Generates a new RFC delta specification template.
  - `list`: Lists all pending, accepted, and superseded change deltas.
  - `apply <id>`: Marks change delta as applied and synchronizes core docs.
- **Testing Scenarios**:
  ```bash
  # Author new delta proposal
  syn change new "ast-caching-layer"

  # List active delta proposals
  syn change list
  ```

---

### `syn discover`
On-demand codebase innovation audit engine. Inspects the repository for architectural enhancements, security boundaries, performance bottlenecks, and developer ergonomics, cataloging discoveries into [`docs/INNOVATION.md`](file:///d:/projects/syntax_syndicate/Syndicate_Protocol/docs/INNOVATION.md).

- **Syntax**: `syn discover [flags]` or `syn discover [command]`
- **Flags**:
  - `--save`: Automatically appends discovered candidates to `docs/INNOVATION.md`.
  - `--json`: Emits discovery results in structured JSON format.
- **Subcommands**:
  - `list`: Displays cataloged suggestions and enhancements from `docs/INNOVATION.md`.
  - `add`: Interactively or via flags records a new suggestion or enhancement.
  - `promote <INN-ID>`: Promotes a cataloged innovation item into an active task in `TASK.md`.
- **Testing Scenarios**:
  ```bash
  # Run an on-demand innovation audit
  syn discover

  # Run audit and persist candidates to docs/INNOVATION.md
  syn discover --save

  # List all cataloged items
  syn discover list

  # Promote an idea into an active task in TASK.md
  syn discover promote INN-003
  ```

---

## 5. Security, Supply Chain & Code Safety

### `syn scan`
Zero-trust AI Skill & Agent Security Scanner based on the OWASP Agentic Top 10. Scans skills, agent instructions, shell scripts, and tool definitions for prompt injections, credential exfiltration, obfuscation, and dangerous shell pipelines.

- **Syntax**: `syn scan [targets...] [flags]`
- **Flags**:
  - `--fail-on <severity>`: Exits with non-zero code on findings at or above severity (`critical`, `high`, `medium`).
  - `--json`: Emits machine-readable JSON security report.
- **Testing Scenarios**:
  ```bash
  # Scan default agent skills (.agents/skills, .claude/commands)
  syn scan

  # Scan a specific directory and fail on high-severity findings
  syn scan ./scripts --fail-on high

  # Generate JSON report for CI
  syn scan --json
  ```

---

### `syn triage`
Heuristic diff classifier scanning git diffs or uncommitted changes for dangerous shell pipelines, credential leaks, SSRF patterns, and destructive filesystem operations before human review.

- **Syntax**: `syn triage`
- **Testing Scenario**:
  ```bash
  # Triage working tree diffs
  syn triage
  ```

---

### `syn bom`
Produces an authoritative, zero-trust Agent Software Bill of Materials (A-BOM) auditing all agent instructions, rules, skills, tools, and living root docs with SHA256 checksums, capability scopes, and provenance.

- **Syntax**: `syn bom [flags]`
- **Flags**:
  - `--json`: Outputs A-BOM in structured CycloneDX-compatible JSON format.
  - `--output <file>`: Writes A-BOM JSON to specified file path.
- **Testing Scenarios**:
  ```bash
  # Display formatted terminal summary of agent artifacts
  syn bom

  # Export signed CycloneDX JSON bill of materials
  syn bom --json --output bom.cyclonedx.json
  ```

---

### `syn blast-radius`
Computes the downstream AST blast radius of modified files, identifying all callers, structs, interfaces, and packages impacted by a proposed change.

- **Syntax**: `syn blast-radius [flags]`
- **Flags**:
  - `--files <comma-separated-paths>`: Target files to analyze.
- **Testing Scenario**:
  ```bash
  syn blast-radius --files "internal/validator/ssot.go,internal/security/bom.go"
  ```

---

## 6. Visual Dashboards, TUIs & Agent Bridges

### `syn web`
Starts a local, zero-dependency embedded web server serving the React 19 visual governance dashboard. Visualizes the 6-level authority hierarchy, drift metrics, A-BOM inventory, Innovation Registry promotion, and live Server-Sent Events (SSE) lease watcher feeds.

- **Syntax**: `syn web [flags]`
- **Flags**:
  - `-p, --port <int>`: Server listening port (default: `8080`).
  - `--open`: Automatically launches the default web browser.
- **Testing Scenarios**:
  ```bash
  # Start web server on port 8080 and open browser
  syn web --open

  # Start web server on custom port
  syn web --port 9090
  ```

---

### `syn dash`
Fullscreen terminal UI dashboard built with Bubble Tea. Displays live authority hierarchy, task completion status, handoff pointers, and anti-drift health score in terminal.

- **Syntax**: `syn dash`
- **Testing Scenario**:
  ```bash
  syn dash
  ```

---

### `syn shell`
Interactive continuous TUI prompt loop allowing rapid switching between `verify`, `doctor`, `next`, `dash`, and `harden` without restarting the CLI binary.

- **Syntax**: `syn shell`
- **Testing Scenario**:
  ```bash
  syn shell
  ```

---

### `syn ui`
Agent-to-Human terminal interface bridge (A2UI). Renders structured JSON prompt messages from autonomous AI agents into interactive Bubble Tea/Huh form prompts and returns user answers as structured JSON over stdout.

- **Syntax**: `syn ui [flags]`
- **Flags**:
  - `-m, --message <json-string>`: JSON payload from AI agent specifying prompt type, title, and options.
- **Testing Scenario**:
  ```bash
  syn ui -m '{"type":"confirm","title":"Deploy to production?","default":false}'
  ```

---

### `syn mcp`
Starts a native Model Context Protocol (MCP) server over stdio, allowing AI IDEs (Claude Desktop, Cursor, Antigravity, VS Code) to execute SSOT checks, inspect authority docs, and query handoff state as native tools.

- **Syntax**: `syn mcp [flags]` or `syn mcp [command]`
- **Subcommands**:
  - `install`: Automated 1-click universal installer writing MCP configuration directly to Claude Desktop, Cursor, and Claude Code.
- **Testing Scenarios**:
  ```bash
  # Run stdio MCP server
  syn mcp

  # 1-Click install MCP server to IDEs
  syn mcp install
  ```

---

## 7. System, Binary Maintenance & Feature Flags

### `syn update`
Recompiles the workspace `cmd/syn` source code into an optimized binary and synchronizes it directly to `~/.syndicate/bin/syn.exe`, guaranteeing global commands and git pre-commit hooks remain in sync with newly developed commands.

- **Syntax**: `syn update`
- **Testing Scenario**:
  ```bash
  syn update
  ```

---

### `syn install`
Installs the compiled binary to the user's system and persistently configures User/System environment variables and PATH across Windows (PowerShell/User Environment Registry), macOS, and Linux without requiring administrator privileges.

- **Syntax**: `syn install [flags]`
- **Flags**:
  - `--dry-run`: Simulates installation without writing files or modifying PATH.
- **Testing Scenarios**:
  ```bash
  # Simulate installation
  syn install --dry-run

  # Perform system PATH registration
  syn install
  ```

---

### `syn version` / `syn -v` / `syn --version`
Displays Syndicate Protocol CLI version, release channel (Alpha, Beta, RC, Stable, Development Build), git commit hash, build timestamp, platform architecture, and Go runtime version.

Development versions are prominently marked with `[DEVELOPMENT BUILD • UNRELEASED]` and commit provenance to set them unambiguously apart from official Alpha, Beta, RC, and Stable releases.

- **Syntax**:
  - `syn version [flags]`
  - `syn -v`
  - `syn --version`
- **Flags**:
  - `-v, --version`: Quick single-line version and build provenance label.
  - `--json`: Outputs full version metadata and build provenance in structured JSON format (`version_label`, `channel_label`, `is_dev`).
- **Testing Scenarios**:
  ```bash
  # Quick single-line version inspection
  syn -v
  syn --version

  # Display formatted terminal version summary banner & provenance table
  syn version

  # Output version in structured JSON for automation
  syn version --json
  ```

---

### `syn feature`
Inspects and manages release lifecycle feature flags across Alpha, Beta, RC, and Stable tiers.

- **Syntax**: `syn feature [command]`
- **Subcommands**:
  - `list`: Lists all available features, lifecycle stages, active status, and descriptions.
  - `status`: Displays active release channel and summary of enabled features.
  - `enable <key>`: Persistently enables a feature in user config (`~/.syndicate/features.json`).
  - `disable <key>`: Persistently disables a feature in user config.
- **Flags**:
  - `--json`: Outputs feature list in structured JSON format.
- **Testing Scenarios**:
  ```bash
  # List all feature flags
  syn feature list

  # Check active release channel summary
  syn feature status

  # Persistently enable an experimental feature
  syn feature enable crdt-sync

  # Disable a feature
  syn feature disable crdt-sync
  ```

---

### `syn env`
Audits and displays active Syndicate environment variables (`SYNDICATE_HOME`, `PATH` inclusion, and config status).

- **Syntax**: `syn env`
- **Testing Scenario**:
  ```bash
  syn env
  ```

---

### `syn completion`
Generates shell autocompletion scripts for `bash`, `zsh`, `fish`, or `powershell`.

- **Syntax**: `syn completion [bash|zsh|fish|powershell]`
- **Testing Scenarios**:
  ```bash
  # Generate PowerShell autocompletion
  syn completion powershell

  # Generate Bash autocompletion
  syn completion bash
  ```
