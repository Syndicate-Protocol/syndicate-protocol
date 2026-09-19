# Living Innovation Registry — Suggestions & Architectural Enhancements

> **Purpose**: Decouple immediate bug fixes from future architectural ideas. Fixes are resolved immediately at task/milestone close-out (maintaining the Rule 6 zero-debt invariant); suggestions, enhancements, and feature opportunities are cataloged here for on-demand review and deliberate promotion into `TASK.md`.
> **Last Updated**: `{{DATE}}`

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

<!-- Innovation candidates discovered via syn discover or syn-task-done are recorded here -->

---

## 3. History of Promoted & Completed Innovations

| ID | Title | Promoted Date | Milestone / Task | Status |
| :--- | :--- | :--- | :--- | :--- |
