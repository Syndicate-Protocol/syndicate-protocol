# AGENTS.md — Agent & Contributor Guidelines for Syndicate Protocol

> **Role & Purpose**: This document establishes the guidelines, operational rules, coding standards, and architectural integrity invariants that every AI coding agent or human contributor working on the **Syndicate Protocol** repository must strictly adhere to.

---

## 1. Operating Rules & Core Guidelines

0. **Strict Single Source of Truth (SSOT) Authority**:
   - Every contributor MUST read and obey [`SSOT.md`](./SSOT.md).
   - In any scenario of doubt, follow the authority hierarchy defined there.
   - Never create parallel shadow trackers (`TODO.md`, `NOTES.md`). `TASK.md` is the exclusive truth for task status.

1. **Maintain Living Documentation**:
   - Every major task or architectural component implemented must immediately be reflected in `TASK.md` (status updates, notes) and relevant reference docs under `docs/`.
   - Never write orphaned code that isn't mapped to a task in `TASK.md`.

2. **Work in Small, Manageable, Tested Chunks**:
   - Break large features into logical, self-contained units.
   - Implement, verify (tests/typecheck/build/verify:ssot), update documentation, and commit after each task completion.

3. **Commit Disciplined, Meaningful Git History**:
   - Every completed sub-task warrants a clean commit with a clear conventional commit message (`feat: ...`, `fix: ...`, `docs: ...`, `refactor: ...`, `test: ...`).
   - Do not batch multiple unrelated components into one opaque commit.

4. **Multi-Contributor Hand-Off Protocol**:
   - Multiple contributors — human and/or AI — may collaborate on this codebase across sessions.
   - Every contributor must consult `HANDOFF.md` upon arrival to inspect the latest state, invariants, and next tasks.
   - After completing any major feature, task, or milestone, every contributor MUST:
     1. Run `pnpm run verify:ssot`, `syn verify`, and `syn harden` to ensure a green baseline.
     2. Update `TASK.md` (mark tasks checked — only if genuinely complete, see Rule 7).
     3. Update `HANDOFF.md` (record the completed work and outline the next steps).
     4. Commit with a clear conventional commit message.
     5. Present a comprehensive review and walkthrough that MUST provide a direct clickable link to the generated `walkthrough.md` and structuredly outline:
        - **Continuous Review & Discovery**: Confirm that the codebase was audited for enhancements, suggestions, fixes, and new feature opportunities.
        - **Security Audit & Immediate Fixes**: Any identified security risks, bugs, rough edges, lint warnings, or potential issues MUST be documented in `walkthrough.md` for immediate developer review and remediated immediately to preserve Rule 6 zero-debt compliance.
        - **Innovations Cataloged**: State the count and status of all other suggestions, architectural enhancements, and feature opportunities added to [`docs/INNOVATION.md`](./docs/INNOVATION.md) (do not list raw ideas inline to prevent developer confusion and recursive loops), pointing to `syn discover list` or the web dashboard.
        - **Next-Steps**: Clear, prioritized, actionable tasks for the upcoming active roadmap milestone.

5. **Toolchain Agnosticism & Platform Compatibility**:
   - Scripts and tooling must run reliably on standard Node.js (>= 20) across both Windows (PowerShell/cmd) and POSIX (Linux/macOS) shells.
   - Do not assume bash-only syntax when authoring scripts or documentation.

6. **Privacy & Security Invariants**:
   - NEVER commit API keys, tokens, or credentials.
   - Core CLI tools and validators will never transmit telemetry or repository contents to remote servers without explicit user opt-in.
   - The `.reference__items/` directory must never be tracked or committed to git.

7. **No Stub, Fake, or Dummy Implementations**:
   - Every implementation must be real, functional code that does what it claims — never a placeholder, mocked fallback, or UI element masquerading as the real thing.
   - Forbidden: catching a failed dependency and silently substituting fabricated data while reporting success; structured output fields hardcoded to empty/default values while claiming to be derived from real data; commands or handlers wired to a placeholder instead of the real subsystem.
   - If a real implementation isn't ready yet, the corresponding task stays `[ ]` in `TASK.md` — never `[x]`.
   - See [`SSOT.md`](./SSOT.md) Anti-Drift Rule 6.

8. **Anti-Commercialism & Anti-SaaS Invariant**:
   - Syndicate Protocol is governed by the **Syndicate Community Source License** ([`LICENSE`](./LICENSE)).
   - The protocol specification, templates, living documents, and distribution kit (`syndicate-protocol-kit/`) are 100% open-source under the Syndicate Community Source License.
   - The core CLI engine is maintained in this private monorepo and distributed free of charge as pre-compiled, signed standalone binaries.
   - Contributors must never implement features, APIs, or architectural backdoors intended to operate Syndicate Protocol as a commercial SaaS, cloud API, or paid subscription service.
   - No bundling into commercial paid products is allowed.
   - All human and AI contributors must follow the [**Contributor Guide & Standards (`CONTRIBUTING.md`)**](./CONTRIBUTING.md).

---

## 2. Technical Stack & Conventions

- **Go CLI Engine**:
  - Language: Go (`>= 1.22`, target `1.27`)
  - Frameworks: Cobra (CLI commands), Charm (Lip Gloss styling, Bubble Tea TUI, Glamour markdown, Huh forms)
- **Cybernetic Web Dashboard**:
  - Framework: React 19 + TypeScript (strict mode) + Vite
  - Styling: Tailwind CSS v4, custom theme presets (Cyan, Violet, Emerald, Amber)
  - Icons: Lucide React
- **Governance & Scripts**:
  - Runtime: Node.js (`>= 20.0.0`, ESM `"type": "module"`)
  - Package Manager: pnpm (`>= 9.0.0`)

---

## 3. Directory Conventions

- `cmd/syn/`: Native Go binary entrypoint.
- `internal/`: Core engines (validator, auditor, security, ast, lease, web, innovation, detector).
- `web/`: Embedded React 19 cybernetic live dashboard.
- `docs/`: Central reference documentation hub (blueprints, guides, specifications).
- `scripts/`: Operational scripts, installers, and Node.js SSOT validators.
- `syndicate-protocol-kit/`: The distribution template kit for external projects.
- `.worktrees/`: Isolated swarm worktrees created via `syn worktree create`.
