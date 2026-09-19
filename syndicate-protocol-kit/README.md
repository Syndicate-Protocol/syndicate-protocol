<p align="center">
  <img src="./assets/syndicate-protocol.png" alt="Syndicate Protocol Logo" width="160" />
</p>

# Syndicate Protocol Kit

A drop-in kit for adopting **the Syndicate Protocol** — the multi-agent / multi-contributor SSOT methodology described in [`README.md`](../README.md) — in **any other project**. Every file here is generic — no project-specific content, only `[PLACEHOLDER]` markers and instructional comments.

## What's in this kit

```
syndicate-protocol-kit/
├── README.md                    ← you are here
├── SSOT.template.md             → copy to <repo-root>/SSOT.md
├── AGENTS.template.md           → copy to <repo-root>/AGENTS.md
├── TASK.template.md             → copy to <repo-root>/TASK.md
├── HANDOFF.template.md          → copy to <repo-root>/HANDOFF.md
├── ssot.config.example.json     → copy to <repo-root>/ssot.config.json
└── scripts/
    └── verify-ssot.mjs          → copy to <repo-root>/scripts/verify-ssot.mjs
```

Your project's own `README.md` (public overview/quick start) is not templated here — you already have one, and it's the fifth living root file per the methodology.

## Install steps

1. **Copy the four living documents** to your repository root, dropping `.template` from the filename:
   ```bash
   cp syndicate-protocol-kit/SSOT.template.md     ./SSOT.md
   cp syndicate-protocol-kit/AGENTS.template.md   ./AGENTS.md
   cp syndicate-protocol-kit/TASK.template.md     ./TASK.md
   cp syndicate-protocol-kit/HANDOFF.template.md  ./HANDOFF.md
   ```

2. **Copy the verification script and config**:
   ```bash
   mkdir -p scripts
   cp syndicate-protocol-kit/scripts/verify-ssot.mjs   ./scripts/verify-ssot.mjs
   cp syndicate-protocol-kit/ssot.config.example.json  ./ssot.config.json
   ```

3. **Fill in every `[PLACEHOLDER]`** in the four copied documents:
   - `[PROJECT_NAME]`, `[ONE_LINE_DESCRIPTION]` — basic identity.
   - `[NON_NEGOTIABLE_1..N]` in `SSOT.md` — your project's actual constitutional invariants (if you don't have any yet, that's fine — start with an empty list and add them as they come up).
   - `[TECH_STACK_*]`, `[DIRECTORY_*]` in `AGENTS.md` — your actual language/framework/build tool and folder layout.
   - `[MILESTONE_1_NAME]`, etc. in `TASK.md` — your actual first milestones. Delete the example tasks once you've replaced them with real ones.
   - `[COMMIT_HASH]`, `[DATE]` in `HANDOFF.md` — update these every session; they're meant to be edited constantly.

4. **Edit `ssot.config.json`** to match your actual file layout — which docs live in your `docs/` hub, where your test files live, what your build config file is called (see comments in `ssot.config.example.json` for every field).

5. **Wire the verification script into your package manager's scripts.** In `package.json` (or equivalent):
   ```json
   {
     "scripts": {
       "verify:ssot": "node scripts/verify-ssot.mjs",
       "verify": "node scripts/verify-ssot.mjs"
     }
   }
   ```
   Adjust for your actual test/typecheck/build commands and package manager.

   > [!TIP]
   > **Package Linter Hygiene (Knip / Antigravity IDE / VS Code)**: If you invoke `syn` directly inside `package.json` scripts (e.g. `"verify:syn": "syn verify --deep"`), configure `knip.ignoreBinaries` in `package.json` or run `syn doctor --fix` to prevent "Unlisted binary: syn" warnings:
   > ```json
   > {
   >   "knip": {
   >     "ignoreBinaries": ["syn"]
   >   }
   > }
   > ```

6. **Run it once** against your filled-in baseline to confirm it passes clean:
   ```bash
   node scripts/verify-ssot.mjs
   ```

7. **Adopt the onboarding sequence** from [`AGENTS.md`](../AGENTS.md) and [`README.md`](../README.md) as the first thing every contributor — human or AI — does at the start of a session on this project. Consider linking to it (or a copy of it) from your own `README.md`.

## Customizing beyond the template

The four templated documents intentionally keep the same five-document structure and six anti-drift rules as the reference methodology — that consistency is what makes the pattern easy to recognize across projects. Within that structure, everything is yours to adapt: add sections to `AGENTS.md` for your team's specific standards, extend `TASK.md`'s legend if you need more states than pending/in-progress/complete, add fields to `HANDOFF.md` if your hand-off process needs more than what's here. What you shouldn't do is drop the core discipline — one authoritative task tracker, one authoritative hand-off pointer, an automated verification gate, and the no-fake-complete rule are what make the rest of it actually hold up under pressure.
