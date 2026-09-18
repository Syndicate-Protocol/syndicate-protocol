# Project Adoption Guide

You can adopt Syndicate Protocol in any codebase — new or existing — in under 60 seconds.

---

## Method 1: Automated Adoption via CLI (Recommended)

Navigate to your project's root folder and run:

```bash
syn adopt
```

The interactive wizard will:
1. Scan your project files to automatically detect language, package managers, and tools.
2. Ask for your project's canonical name, description, and primary maintainer.
3. Automatically generate the **5 Living Root Documents**:
   - `SSOT.md`: Single Source of Truth authority rules and architecture invariants.
   - `README.md`: Public orientation and documentation map.
   - `TASK.md`: Living task and milestone progress tracker.
   - `HANDOFF.md`: Operational hand-off state between sessions.
   - `AGENTS.md`: Contributor and AI coding agent guidelines.
4. Set up `ssot.config.json` and a lightweight Node.js/Go verification gate.

---

## Method 2: Manual Template Kit Copy

If you prefer not to use the interactive CLI or want to inspect the templates first:

1. Browse the [`syndicate-protocol-kit/`](https://github.com/Syndicate-Protocol/syndicate-protocol/tree/main/syndicate-protocol-kit) directory in the repository.
2. Copy the template files into your project root:
   - `SSOT.template.md` → `SSOT.md`
   - `TASK.template.md` → `TASK.md`
   - `HANDOFF.template.md` → `HANDOFF.md`
   - `AGENTS.template.md` → `AGENTS.md`
   - `ssot.config.example.json` → `ssot.config.json`
3. Replace all `[PLACEHOLDER]` tokens with your project details.
4. Run `syn verify` to confirm your configuration is clean.

---

## What Happens After Adoption?

Once adopted:
- Your team (and any AI agents you pair with) will have a persistent, structured memory of the codebase.
- You can run `syn verify` at any time to catch documentation staleness or broken file links.
- You can run `syn harden` to prevent "fake completion" PRs before merging.
