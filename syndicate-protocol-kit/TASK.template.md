<!--
  TEMPLATE — copy to <repo-root>/TASK.md and replace the example milestone with your real ones.
  Keep the legend and the file-path-in-backticks convention in task descriptions — the
  verification script (scripts/verify-ssot.mjs) parses backtick-quoted paths in completed
  tasks to confirm the files they claim to touch actually exist on disk.
-->

# TASK.md — Living Implementation Task Tracker

> **Project**: [PROJECT_NAME]
> **Status Tracking**: Updated in real time across every implementation task
> **Legend**:
> - `[ ]` Pending
> - `[/]` In Progress
> - `[x]` Completed & Committed — real, working code only (see `AGENTS.md` Rule 7). Never mark a task `[x]` for a stub, placeholder, or mock.

---

## Milestone 1: [MILESTONE_1_NAME]
- [ ] **Task 1.1**: `[Description of the task. Reference specific files in backticks, e.g. ` + "`src/example.ts`" + `, so the verification gate can confirm they exist once this is checked off.]`
- [ ] **Task 1.2**: `[...]`
- [ ] **Task 1.3**: `[...]` — run the full verification pipeline; commit Phase 1.

---

## Milestone 2: [MILESTONE_2_NAME]
- [ ] **Task 2.1**: `[...]`

---

<!--
  Recommended pattern (see README.md § "The Adversarial Hardening Gate Pattern"):
  after a batch of milestones that build real functionality, insert a milestone
  like the one below whose only job is an adversarial review of everything marked
  [x] so far — and that BLOCKS the next milestone until it closes. Delete this
  example if you don't want to use the pattern yet; add it back when you do.
-->

## Milestone N: Correctness & Hardening Review (Blocking Gate)
> Origin: `[independent review — self, peer, or agent — of milestones 1 through N-1, date]`. Convert every finding from that review into a task below. This milestone blocks the next phase of work until it closes.

- [ ] **Task N.1**: `[finding — with file:line evidence if available]`
