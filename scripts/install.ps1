# Syndicate Protocol — Windows Global Installer
# One-liner (Stable):  irm https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/master/scripts/install.ps1 | iex
# One-liner (Beta):    & ([scriptblock]::Create((irm https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/master/scripts/install.ps1))) -Channel beta
# One-liner (Version): & ([scriptblock]::Create((irm https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/master/scripts/install.ps1))) -Version v0.2.0-beta.1

param(
    [string]$Channel = "stable",
    [string]$Version = ""
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "  _____                 _ _            _                 " -ForegroundColor Cyan
Write-Host " / ____|               | (_)          | |                " -ForegroundColor Cyan
Write-Host "| (___  _   _ _ __   __| |_  ___ __ _| |_ ___            " -ForegroundColor Cyan
Write-Host " \___ \| | | | '_ \ / _` | |/ __/ _` | __/ _ \           " -ForegroundColor Cyan
Write-Host " ____) | |_| | | | | (_| | | (_| (_| | ||  __/           " -ForegroundColor Cyan
Write-Host "|_____/ \__, |_| |_|\__,_|_|\___\__,_|\__\___|           " -ForegroundColor Cyan
Write-Host "         __/ |                                           " -ForegroundColor Cyan
Write-Host "        |___/      Single Source of Truth & Anti-Drift OS" -ForegroundColor DarkCyan
Write-Host ""

$SyndicateHome = Join-Path $env:USERPROFILE ".syndicate"
$BinDir = Join-Path $SyndicateHome "bin"
$TargetExe = Join-Path $BinDir "syn.exe"

# 1. Create target directories
if (-not (Test-Path $BinDir)) {
    New-Item -ItemType Directory -Path $BinDir -Force | Out-Null
}

# 2. Detect CPU Architecture
$Arch = if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") { "arm64" } else { "amd64" }
$BinaryName = "syn-windows-$Arch.exe"

# 3. Locate or download binary
$LocalBuild = Join-Path $PSScriptRoot "..\bin\syn.exe"
if (Test-Path $LocalBuild) {
    Write-Host "[+] Installing from local workspace build: $LocalBuild" -ForegroundColor Green
    Copy-Item -Path $LocalBuild -Destination $TargetExe -Force
} else {
    $ReleaseUrl = ""
    if ($Version -ne "") {
        Write-Host "[*] Target requested: Version $Version ($Arch)" -ForegroundColor Cyan
        $ReleaseUrl = "https://github.com/Syndicate-Protocol/syndicate-protocol/releases/download/$Version/$BinaryName"
    } elseif ($Channel -eq "stable") {
        Write-Host "[*] Target requested: Latest Stable Release ($Arch)" -ForegroundColor Cyan
        $ReleaseUrl = "https://github.com/Syndicate-Protocol/syndicate-protocol/releases/latest/download/$BinaryName"
    } else {
        Write-Host "[*] Target requested: Channel '$Channel' ($Arch)" -ForegroundColor Cyan
        try {
            $ReleasesApi = "https://api.github.com/repos/Syndicate-Protocol/syndicate-protocol/releases"
            $Releases = Invoke-RestMethod -Uri $ReleasesApi -UseBasicParsing -Headers @{ "User-Agent" = "Syndicate-Installer" }
            $TargetRelease = $Releases | Where-Object { $_.tag_name -like "*-$Channel*" } | Select-Object -First 1
            if ($TargetRelease) {
                $Asset = $TargetRelease.assets | Where-Object { $_.name -eq $BinaryName } | Select-Object -First 1
                if ($Asset) {
                    $ReleaseUrl = $Asset.browser_download_url
                    Write-Host "    Found matching release: $($TargetRelease.tag_name)" -ForegroundColor Green
                }
            }
        } catch {
            Write-Warning "Could not query GitHub Releases API: $_"
        }

        if (-not $ReleaseUrl) {
            Write-Warning "Falling back to latest release endpoint..."
            $ReleaseUrl = "https://github.com/Syndicate-Protocol/syndicate-protocol/releases/latest/download/$BinaryName"
        }
    }

    Write-Host "[*] Downloading Syndicate Protocol binary ($BinaryName)..." -ForegroundColor Cyan
    Write-Host "    $ReleaseUrl" -ForegroundColor DarkGray
    try {
        Invoke-WebRequest -Uri $ReleaseUrl -OutFile $TargetExe -UseBasicParsing
    } catch {
        Write-Warning "Failed downloading from GitHub Releases. Looking for local binary fallback..."
        if (Test-Path ".\bin\syn.exe") {
            Copy-Item -Path ".\bin\syn.exe" -Destination $TargetExe -Force
        } else {
            throw "Could not acquire syn.exe. Please build locally with 'go build -o bin/syn.exe ./cmd/syn'."
        }
    }
}

# 4. Configure Win32 Registry Environment
Write-Host "[*] Configuring User Environment Variables and PATH..." -ForegroundColor Cyan
[Environment]::SetEnvironmentVariable("SYNDICATE_HOME", $SyndicateHome, "User")

$CurrentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($null -eq $CurrentPath) { $CurrentPath = "" }
if ($CurrentPath -notlike "*$BinDir*") {
    $NewPath = if ($CurrentPath -eq "") { $BinDir } else { "$CurrentPath;$BinDir" }
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    Write-Host "    + Added $BinDir to User PATH in Registry." -ForegroundColor Green
} else {
    Write-Host "    + $BinDir already present in User PATH." -ForegroundColor DarkGray
}

# 5. Configure PowerShell Profile
$ProfilePath = $PROFILE
if (-not [string]::IsNullOrEmpty($ProfilePath)) {
    $ProfileDir = Split-Path -Parent $ProfilePath
    if (-not (Test-Path $ProfileDir)) {
        New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
    }
    $AliasLine = "`n# Syndicate Protocol CLI`nSet-Alias -Name syn -Value `"$TargetExe`" -Scope Global -ErrorAction SilentlyContinue`n"
    $ExistingProfile = if (Test-Path $ProfilePath) { Get-Content $ProfilePath -Raw } else { "" }
    if ($ExistingProfile -notlike "*Set-Alias -Name syn*") {
        Add-Content -Path $ProfilePath -Value $AliasLine
        Write-Host "    + Registered 'syn' alias in PowerShell Profile" -ForegroundColor Green
    }
}

# 6. Broadcast WM_SETTINGCHANGE
try {
    $cSharpSource = @'
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
}
'@
    Add-Type -TypeDefinition $cSharpSource -ErrorAction SilentlyContinue
    $result = [UIntPtr]::Zero
    [Win32]::SendMessageTimeout([IntPtr]0xffff, 0x001A, [UIntPtr]::Zero, "Environment", 2, 5000, [ref]$result) | Out-Null
} catch {
    # Non-fatal if broadcast fails
}

# 7. Verify Installation
Write-Host ""
Write-Host "[OK] Syndicate Protocol installed successfully!" -ForegroundColor Green
Write-Host "     Binary:  $TargetExe" -ForegroundColor White
Write-Host "     Home:    $SyndicateHome" -ForegroundColor White
Write-Host ""
Write-Host "To start using immediately in this session, run:" -ForegroundColor Cyan
Write-Host "     `$env:PATH += `";$BinDir`"" -ForegroundColor Yellow
Write-Host "     syn version" -ForegroundColor Yellow
Write-Host "     syn doctor" -ForegroundColor Yellow
Write-Host ""
