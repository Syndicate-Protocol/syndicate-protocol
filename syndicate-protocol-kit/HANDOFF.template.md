<!--
  TEMPLATE — copy to <repo-root>/HANDOFF.md and fill in every [PLACEHOLDER].
  This file is meant to be edited almost every session — treat stale content
  here as a bug, not a formality.
-->

# HANDOFF.md — Contributor & Agent Hand-Off Document

> **Project**: [PROJECT_NAME]
> **Repository Root**: `[REPO_PATH]`
> **Last Updated**: `[DATE]` (`[what happened this session, in a few words]`)
> **Active Commit**: `[COMMIT_HASH]` (`[clean/dirty working tree, verification status]`)

---

## 1. Quick Orientation for Incoming Contributors

Welcome! You are contributing to **[PROJECT_NAME]**. `[One or two sentences on what the project does.]`

### Critical Invariants to Obey:
0. **Single Source of Truth Mandate**: Always consult [`SSOT.md`](./SSOT.md) first. `TASK.md` is the exclusive truth for task completion status. `HANDOFF.md` is the exclusive truth for active hand-off state. Do NOT create shadow trackers.
1. `[Any project-specific hard invariants — e.g. zero plaintext secrets, no closed-source dependencies, etc.]`
2. **Discipline & Living Documentation**:
   - Update `TASK.md` in real time as tasks progress.
   - Update `HANDOFF.md` after every major task so the next contributor can resume seamlessly.
   - Run the full verification pipeline before committing.
   - Commit after each completed task/milestone without needing to be asked (see `AGENTS.md` Rule 3/4).

---

## 2. Current State of the Codebase

### Completed Milestones & Components:
- **Milestone 1: `[NAME]`** (`commit [HASH]`)
  - `[Component]`: `[one-line description]`.
- `[...]`

---

## 3. Active Next Milestone

`[Name and number of the milestone currently being worked, and a short description of what it covers and why it matters now.]`

- **Tasks to Implement**: See [`TASK.md`](./TASK.md) Milestone `[N]`, Tasks `[X.1–X.N]`.

### This Session's SEFN Review Summary (`[DATE]`)
- **Innovations Cataloged**: `[State count of suggestions & enhancements recorded in docs/INNOVATION.md (do not list raw ideas inline)]`
- **Fixes**: `[Any identified bugs, warnings, or technical debt requiring mandatory immediate remediation]`
- **Next-Steps**: `[The immediate, ordered actionable tasks to tackle next]`

### Recommended Start Order for the Next Session
1. `[Task X.Y]` — `[why this one first: smallest/highest-impact/least design ambiguity/etc.]`
2. `[...]`

---

## 4. Verification Commands (Always Run Before Hand-Off)

```bash
# Complete all-in-one verification pipeline:
[PACKAGE_MANAGER] run verify

# Or individually:
[TEST_COMMAND]
[TYPECHECK_COMMAND]
[BUILD_COMMAND]
[PACKAGE_MANAGER] run verify:ssot
```

---

## 5. Resumption Instructions

When picking this back up:
1. Run the verification pipeline to confirm a green baseline.
2. Open [`TASK.md`](./TASK.md) and confirm which milestone is active.
3. Follow the "Recommended Start Order" in Section 3 above.
4. As each task lands: check it `[x]` in `TASK.md` (only if genuinely complete — see `AGENTS.md` Rule 7), run the verification pipeline, commit, then update this file's commit-hash pointer.
