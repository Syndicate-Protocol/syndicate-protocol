# Cybernetic Web Dashboard Guide

Syndicate Protocol embeds a high-performance **React 19 + Tailwind CSS + Vite** visual dashboard directly inside the standalone CLI binary.

---

## Launching the Dashboard

To launch the dashboard and automatically open it in your default web browser, run:

```bash
syn web --open
```

By default, the server runs on `http://localhost:3000`. You can customize the port:

```bash
syn web --port 8080 --open
```

---

## Key Dashboard Features

### 1. Live Task Board & Epistemic Tracking
- Interactive Kanban view of milestones and tasks declared in `TASK.md`.
- Real-time status badges for completed, in-progress, and pending work.
- Quick filtering by milestone or keyword.

### 2. Multi-Agent Telemetry
- Inspect active Git worktrees and agent leases.
- Monitor anti-drift scores and Rule 6 hardening compliance in real time.
- View symbol AST dependency graphs.

### 3. Integrated Web Terminal Bridge
- Execute protocol commands directly from your browser.
- Real-time streaming command output with ANSI terminal emulation.
- Localhost security protections preventing unauthorized cross-origin requests.

### 4. Cybernetic Visual Themes
- Choose between curated dark mode themes: Cyan, Violet, Emerald, and Amber.
- Smooth transitions and zero cloud telemetry dependencies.
