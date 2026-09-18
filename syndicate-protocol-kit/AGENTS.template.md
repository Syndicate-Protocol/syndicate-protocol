<!--
  TEMPLATE — copy to <repo-root>/AGENTS.md and fill in every [PLACEHOLDER].
  Section 2 and 3 are the most project-specific — replace their contents entirely
  with your actual stack and layout rather than trying to keep the placeholders generic.
-->

# AGENTS.md — Agent & Contributor Guidelines for [PROJECT_NAME]

> **Role & Purpose**: This document establishes the guidelines, operational rules, coding standards, and architectural integrity invariants that every AI coding agent or human contributor working on the [PROJECT_NAME] project must strictly adhere to.

---

## 1. Operating Rules & Core Guidelines

0. **Strict Single Source of Truth (SSOT) Authority**:
   - Every contributor MUST read and obey [`SSOT.md`](./SSOT.md).
   - In any scenario of doubt, follow the authority hierarchy defined there.
   - Never create parallel shadow trackers (`TODO.md`, `NOTES.md`). `TASK.md` is the exclusive truth for task status.

1. **Maintain Living Documentation**:
   - Every major task or architectural component implemented must immediately be reflected in `TASK.md` (status updates, notes) and any relevant reference docs under `docs/`.
   - Never write orphaned code that isn't mapped to a task in `TASK.md`.

2. **Work in Small, Manageable, Tested Chunks**:
   - Break large features into logical, self-contained units.
   - Implement, verify (tests/typecheck/build), update documentation, and commit after each task completion.

3. **Commit Disciplined, Meaningful Git History**:
   - Every completed sub-task warrants a clean commit with a clear conventional commit message (`feat: ...`, `fix: ...`, `docs: ...`, `refactor: ...`, `test: ...`).
   - Do not batch multiple unrelated components into one opaque commit.

4. **Multi-Contributor Hand-Off Protocol**:
   - Multiple contributors — human and/or AI — may collaborate on this codebase across sessions.
   - Every contributor must consult `HANDOFF.md` upon arrival to inspect the latest state, invariants, and next tasks.
   - After completing any major feature, task, or milestone, every contributor MUST:
     1. Run the full verification pipeline (tests, typecheck, build, syn verify, syn harden) to ensure a green baseline.
     2. Update `TASK.md` (mark tasks checked — only if genuinely complete, see Rule 7).
     3. Update `HANDOFF.md` (record the completed work and outline the next steps).
     4. Commit with a clear conventional commit message.
     5. Present a comprehensive review and walkthrough that MUST structuredly outline:
         - **Innovations Cataloged**: State the count and status of suggestions and enhancements documented in [`docs/INNOVATION.md`](./docs/INNOVATION.md) (do not list raw ideas inline to prevent developer confusion and recursive loops), pointing to `syn discover list` or the web dashboard.
         - **Fixes**: Any identified bugs, rough edges, warnings, or technical debt needing mandatory immediate remediation to preserve Rule 6 zero-debt compliance.
         - **Next-Steps**: The immediate, ordered actionable tasks to tackle next.

5. **`[OPTIONAL — delete this rule if not applicable]` Toolchain Agnosticism**:
   - Always write standard code and use standard scripts declared in the project's manifest (`package.json`, `pyproject.toml`, etc.).
   - Never introduce scripts or tooling that only work with one specific package manager/toolchain, if the project intends to support more than one.

6. **`[OPTIONAL — replace with your project's actual security invariants, or delete]` Privacy & Security Invariants**:
   - `[e.g. NEVER store credentials in plaintext — use the platform's secret storage]`
   - `[e.g. NEVER send user data to a third-party service without explicit consent]`

7. **No Stub, Fake, or Dummy Implementations**:
   - Every implementation must be real, functional code that does what it claims — never a placeholder, mocked fallback, or UI element masquerading as the real thing.
   - Forbidden: catching a failed dependency/connection and silently substituting fabricated data while reporting success; UI elements or confirmations that claim a capability (e.g. "verified," "secure," "connected") they don't actually provide; structured output fields hardcoded to empty/default values while claiming to be derived from real data; commands or handlers wired to a placeholder instead of the real subsystem they're declared for.
   - If a real implementation isn't ready yet, the corresponding task stays `[ ]` in `TASK.md` — never `[x]`. Code that is genuinely unfinished and must ship partially must fail loudly (throw/error) rather than silently degrade to fake success.
   - See [`SSOT.md`](./SSOT.md) Anti-Drift Rule 6.

---

## 2. Technical Stack & Conventions

*(Replace this entire section with your project's actual stack.)*

- **Language**: `[LANGUAGE_AND_VERSION]`
- **Runtime**: `[RUNTIME_ENVIRONMENT]`
- **Build tool**: `[BUILD_TOOL]`
- **`[Add any other stack-defining conventions: UI framework, parser libraries, driver interfaces, etc.]`**

---

## 3. Directory Conventions

*(Replace this entire section with your project's actual directory layout — keep it accurate, this is what tells a new contributor where to look.)*

- `docs/`: Central reference documentation hub.
- `[SRC_DIR_1]`: `[what lives here]`
- `[SRC_DIR_2]`: `[what lives here]`
- `[TEST_DIR]`: Automated test suites.
