## 📋 Description

Provide a clear and concise summary of the changes proposed in this Pull Request.
Explain the *why* behind the change and reference any relevant issue(s).

Fixes #(issue) / Relates to #(issue)

---

## 🏷️ Type of Change

Select all that apply:

- [ ] 🐛 **Bug fix** (non-breaking change fixing an issue)
- [ ] ✨ **New feature** (non-breaking change adding functionality)
- [ ] 💥 **Breaking change** (fix or feature causing existing functionality to not work as expected)
- [ ] 📝 **Documentation** (updates to living docs, guides, or specifications)
- [ ] ♻️ **Refactoring** (code improvements without functional changes)
- [ ] 🧪 **Tests / CI** (adding or updating test suites, CI workflows, or verification gates)
- [ ] ⚡ **Performance** (optimizations improving execution speed or memory efficiency)

---

## 🛡️ SSOT & Governance Verification Checklist

Before requesting a review, verify that your branch satisfies all repository invariants:

- [ ] **Developer Certificate of Origin (DCO)**: All commits are signed off (`git commit -s`).
- [ ] **Anti-Commercialism & Anti-SaaS Compliance**: Changes comply with the [Syndicate Community Source License](https://github.com/Syndicate-Protocol/syndicate-protocol/blob/main/LICENSE) (no SaaS backdoors, telemetry without opt-in, or commercial paywalls).
- [ ] **Rule 6 (No Fake Complete Status)**: All implementations are real, functional, working code — zero stubs, mocked fallbacks, or dummy placeholders.
- [ ] **Atomic Living Documentation**: `TASK.md` and `HANDOFF.md` reflect current progress and are updated within the same commit.
- [ ] **Decoupled Innovations**: Any non-immediate suggestions or future enhancement ideas have been cataloged into `docs/INNOVATION.md` rather than mixed into active tasks.
- [ ] **SSOT Integrity**: `pnpm run verify:ssot` passes with zero errors.
- [ ] **Deep AST Signatures**: `syn verify --deep` passes with zero AST or signature drift.
- [ ] **Adversarial Hardening**: `syn harden --strict` passes with 100.0% integrity score.
- [ ] **Unit Tests**: `go test ./...` passes all tests.
- [ ] **Web Dashboard**: If modifying `web/`, frontend builds cleanly (`pnpm --dir web build`).
- [ ] **Clean Git Working Tree**: No untracked artifacts, temporary files, or `.reference__items/` committed.

---

## 🧪 Testing & Verification Performed

Describe the testing performed to verify these changes:

```bash
# Example verification commands executed:
pnpm run verify:ssot
syn verify --deep
syn harden --strict
go test ./...
```

**Results / Output Summary**:
> (Paste terminal confirmation or test summary here)
