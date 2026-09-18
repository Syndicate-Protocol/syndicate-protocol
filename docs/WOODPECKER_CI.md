# Woodpecker CI — Local & Self-Hosted CI/CD Guide

> **Scope & Authority**: This document is the operational guide for executing, testing, and managing **Woodpecker CI** pipelines within the **Syndicate Protocol** repository. It details both native local runners and containerized self-hosted execution for 100% free, open-source, vendor-agnostic continuous integration.

---

## 1. Overview & Architectural Philosophy

[Woodpecker CI](https://woodpecker-ci.org/) is a community-driven, container-native continuous integration engine (licensed under Apache 2.0). Syndicate Protocol adopts Woodpecker as its primary open-source CI baseline because:

1. **100% Free & Open-Source**: Zero subscription tiers, no paywalled runners, and no telemetry.
2. **Local-First & Private Repository Friendly**: Fully functional on local workstations, private LANs, or behind firewalls without requiring code to be hosted publicly or tokens sent to third-party clouds.
3. **Container-Native Isolation**: Each step executes inside standard container images (`golang:1.24`, `node:20-alpine`) guaranteeing deterministic builds.
4. **Parity with Native Tooling**: Syndicate Protocol maintains parity between its containerized `.woodpecker.yaml` pipeline and native shell scripts (`scripts/run-ci-local.ps1` and `scripts/run-ci-local.sh`).

---

## 2. Execution Modes

Syndicate Protocol supports three complementary execution modes depending on your environment and requirements:

| Mode | Command | Docker Required? | Best For |
| :--- | :--- | :--- | :--- |
| **Mode A: Native Local Runner** | `powershell -File scripts/run-ci-local.ps1` or `bash scripts/run-ci-local.sh` | **No** | Fast day-to-day development, zero Docker overhead, rapid feedback (< 5s). |
| **Mode B: Woodpecker CLI Exec** | `powershell -File scripts/run-ci-local.ps1 -Woodpecker` | **Yes** | Ephemeral container testing before committing; tests pipeline in container without running a server. |
| **Mode C: Self-Hosted Server & Agent** | `docker compose -f docker-compose.woodpecker.yml up -d` | **Yes** | Full CI server with web UI (`http://localhost:8000`), job logs, webhook triggers, and multi-agent queuing. |

---

## 3. Mode A: Native Local Runner (Fastest & Zero Overhead)

If Docker is not running or you want sub-second test-and-verify loops, use the native local runner.

### Windows (PowerShell)

```powershell
# Standard fast check: Unit tests + binary build + SSOT verification + Rule 6 hardening
.\scripts\run-ci-local.ps1

# Full release matrix: Also compiles Windows/Linux/macOS AMD64 & ARM64 binaries + SHA256 checksums + A-BOM
.\scripts\run-ci-local.ps1 -Matrix
```

### POSIX (Linux / macOS / WSL)

```bash
# Standard fast check
./scripts/run-ci-local.sh

# Full release matrix
./scripts/run-ci-local.sh -Matrix
```

### Pipeline Steps Executed

1. **Unit Tests**: Runs `go test ./...` across all packages.
2. **Workspace Build**: Compiles `./cmd/syn` into `./bin/syn` (or `.exe`).
3. **SSOT Anti-Drift Verification**: Executes `syn verify --deep` checking all authority documents and AST signatures.
4. **Rule 6 Hardening Gate**: Executes `syn harden` to ensure zero stubs, mocks, or fake implementations exist.
5. **(Optional) Multi-Arch Matrix**: Cross-compiles for `windows/amd64`, `windows/arm64`, `linux/amd64`, `linux/arm64`, `darwin/amd64`, `darwin/arm64`, generates `dist/syndicate-abom.json` (CycloneDX A-BOM), and computes `dist/checksums.txt` (SHA256).

---

## 4. Mode B: Ephemeral Woodpecker CLI Execution

To run the container pipeline without standing up a persistent Woodpecker server, use the Woodpecker CLI `exec` engine inside Docker:

```powershell
.\scripts\run-ci-local.ps1 -Woodpecker
```

Or manually via Docker:

```bash
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$PWD:$PWD" \
  -w "$PWD" \
  woodpeckerci/woodpecker-cli:latest exec .woodpecker.yaml
```

Woodpecker spins up ephemeral containers for each pipeline step in `.woodpecker.yaml`, executes them sequentially, streams colored logs to your terminal, and tears down all containers upon completion.

---

## 5. Mode C: Self-Hosted Woodpecker Stack (Server + Agent)

To operate a persistent local CI server with a web dashboard, job history, and automated webhook builds:

### 1. Launch the Stack

```powershell
docker compose -f docker-compose.woodpecker.yml up -d
```

### 2. Access the Dashboard

Open your browser to:

```text
http://localhost:8000
```

### 3. Architecture & Services

The stack defined in [`docker-compose.woodpecker.yml`](../docker-compose.woodpecker.yml) includes:

- **`woodpecker-server`**:
  - Image: `woodpeckerci/woodpecker-server:v3`
  - Database: Local SQLite stored in `.woodpecker/server-data/` (ignored by git).
  - Port: `8000:8000` (Web UI & API), `9000:9000` (gRPC Agent communication).
  - Secret Token: Pre-configured shared secret for agent authentication.
- **`woodpecker-agent`**:
  - Image: `woodpeckerci/woodpecker-agent:v3`
  - Max Workflows: 2 concurrent pipelines.
  - Mounts: `/var/run/docker.sock` for spawning workflow step containers.

### 4. Stopping the Stack

```powershell
docker compose -f docker-compose.woodpecker.yml down
```

---

## 6. Pipeline Specification (`.woodpecker.yaml`)

The declarative pipeline configuration [`.woodpecker.yaml`](../.woodpecker.yaml) contains the following stages:

```yaml
steps:
  - name: test
    image: golang:1.24
    commands:
      - go version
      - go test -v -race ./...

  - name: verify-ssot
    image: golang:1.24
    commands:
      - go build -o bin/syn ./cmd/syn
      - ./bin/syn verify --deep

  - name: rule6-hardening
    image: golang:1.24
    commands:
      - ./bin/syn harden

  - name: release-matrix
    image: golang:1.24
    when:
      event: [tag, manual]
    commands:
      # Cross-compilation for Windows, Linux, macOS (AMD64 + ARM64)
      # Generates SHA256 checksums and CycloneDX A-BOM
```

---

## 7. Artifact Staging & Verification

When running with `-Matrix` or when triggered by a release tag, artifacts are staged in `./dist`:

```text
dist/
├── syn-windows-amd64.exe
├── syn-windows-arm64.exe
├── syn-linux-amd64
├── syn-linux-arm64
├── syn-darwin-amd64
├── syn-darwin-arm64
├── syndicate-abom.json    # CycloneDX Software Bill of Materials
└── checksums.txt          # Cryptographic SHA256 hashes
```

You can verify any binary against `checksums.txt` using:

```powershell
# Windows PowerShell
Get-FileHash dist\syn-windows-amd64.exe -Algorithm SHA256

# POSIX
sha256sum -c dist/checksums.txt
```

---

## 8. Summary of Benefits

- **Zero Cloud Costs**: Absolutely free, running entirely on your local hardware.
- **Air-Gapped Operation**: No outbound internet traffic is needed once container images are cached.
- **Strict SSOT Alignment**: Both native and containerized runners execute the exact same `syn verify --deep` and `syn harden` gates.
