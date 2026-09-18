#!/usr/bin/env bash
# Syndicate Protocol — macOS & Linux Global Installer
# One-liner (Stable):  curl -fsSL https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/master/scripts/install.sh | bash
# One-liner (Beta):    curl -fsSL https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/master/scripts/install.sh | bash -s -- --channel beta
# One-liner (Version): curl -fsSL https://raw.githubusercontent.com/Syndicate-Protocol/syndicate-protocol/master/scripts/install.sh | bash -s -- --version v0.2.0-beta.1

set -euo pipefail

CHANNEL="stable"
VERSION=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --channel)
            CHANNEL="$2"
            shift 2
            ;;
        --version)
            VERSION="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

CYAN='\033[0;36m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

echo ""
echo -e "${CYAN}  _____                 _ _            _                 ${NC}"
echo -e "${CYAN} / ____|               | (_)          | |                ${NC}"
echo -e "${CYAN}| (___  _   _ _ __   __| |_  ___ __ _| |_ ___            ${NC}"
echo -e "${CYAN} \___ \| | | | '_ \ / _\` | |/ __/ _\` | __/ _ \           ${NC}"
echo -e "${CYAN} ____) | |_| | | | | (_| | | (_| (_| | ||  __/           ${NC}"
echo -e "${CYAN}|_____/ \__, |_| |_|\__,_|_|\___\__,_|\__\___|           ${NC}"
echo -e "${CYAN}         __/ |                                           ${NC}"
echo -e "${CYAN}        |___/      Single Source of Truth & Anti-Drift OS${NC}"
echo ""

SYNDICATE_HOME="${HOME}/.syndicate"
BIN_DIR="${SYNDICATE_HOME}/bin"
TARGET_BIN="${BIN_DIR}/syn"

mkdir -p "${BIN_DIR}"
mkdir -p "${HOME}/.local/bin"

# Detect OS and Architecture
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

case "${ARCH}" in
    x86_64)  ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
    arm64)   ARCH="arm64" ;;
    *) echo "Unsupported architecture: ${ARCH}"; exit 1 ;;
esac

BINARY_NAME="syn-${OS}-${ARCH}"

# Locate or download binary
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
LOCAL_BIN="${SCRIPT_DIR}/../bin/syn"

if [ -f "${LOCAL_BIN}" ]; then
    echo -e "${GREEN}📦 Installing from local build: ${LOCAL_BIN}${NC}"
    cp "${LOCAL_BIN}" "${TARGET_BIN}"
    chmod +x "${TARGET_BIN}"
else
    RELEASE_URL=""
    if [ -n "${VERSION}" ]; then
        echo -e "${CYAN}🎯 Target requested: Version ${VERSION} (${BINARY_NAME})${NC}"
        RELEASE_URL="https://github.com/Syndicate-Protocol/syndicate-protocol/releases/download/${VERSION}/${BINARY_NAME}"
    elif [ "${CHANNEL}" = "stable" ]; then
        echo -e "${CYAN}🎯 Target requested: Latest Stable Release (${BINARY_NAME})${NC}"
        RELEASE_URL="https://github.com/Syndicate-Protocol/syndicate-protocol/releases/latest/download/${BINARY_NAME}"
    else
        echo -e "${CYAN}🎯 Target requested: Channel '${CHANNEL}' (${BINARY_NAME})${NC}"
        TARGET_TAG=$(curl -fsSL -H "User-Agent: Syndicate-Installer" "https://api.github.com/repos/Syndicate-Protocol/syndicate-protocol/releases" 2>/dev/null | grep -o '"tag_name": "[^"]*' | grep -- "-${CHANNEL}" | head -n 1 | cut -d'"' -f4 || echo "")
        if [ -n "${TARGET_TAG}" ]; then
            echo -e "   Found matching release: ${GREEN}${TARGET_TAG}${NC}"
            RELEASE_URL="https://github.com/Syndicate-Protocol/syndicate-protocol/releases/download/${TARGET_TAG}/${BINARY_NAME}"
        else
            echo -e "${GRAY}   Falling back to latest release endpoint...${NC}"
            RELEASE_URL="https://github.com/Syndicate-Protocol/syndicate-protocol/releases/latest/download/${BINARY_NAME}"
        fi
    fi

    echo -e "${CYAN}⬇️  Downloading Syndicate Protocol binary from GitHub...${NC}"
    echo -e "${GRAY}   ${RELEASE_URL}${NC}"
    if curl -fsSL "${RELEASE_URL}" -o "${TARGET_BIN}" 2>/dev/null; then
        chmod +x "${TARGET_BIN}"
    elif [ -f "./bin/syn" ]; then
        echo -e "${GRAY}   Falling back to local ./bin/syn...${NC}"
        cp "./bin/syn" "${TARGET_BIN}"
        chmod +x "${TARGET_BIN}"
    else
        echo "Could not download ${RELEASE_URL}. Please build locally with 'go build -o bin/syn ./cmd/syn'."
        exit 1
    fi
fi

# Symlink to ~/.local/bin/syn
ln -sf "${TARGET_BIN}" "${HOME}/.local/bin/syn"

# Configure shell profiles
SHELL_PROFILES=("${HOME}/.bashrc" "${HOME}/.zshrc" "${HOME}/.profile" "${HOME}/.bash_profile")
PATH_EXPORT="export SYNDICATE_HOME=\"${SYNDICATE_HOME}\"\nexport PATH=\"${BIN_DIR}:${HOME}/.local/bin:\$PATH\""

for prof in "${SHELL_PROFILES[@]}"; do
    if [ -f "${prof}" ]; then
        if ! grep -q "SYNDICATE_HOME" "${prof}"; then
            echo -e "\n# Syndicate Protocol CLI\n${PATH_EXPORT}" >> "${prof}"
            echo -e "   ${GREEN}✓ Updated ${prof}${NC}"
        fi
    fi
done

# Fish shell configuration
FISH_CONFIG="${HOME}/.config/fish/config.fish"
if [ -d "${HOME}/.config/fish" ]; then
    mkdir -p "${HOME}/.config/fish"
    if [ -f "${FISH_CONFIG}" ] && ! grep -q "SYNDICATE_HOME" "${FISH_CONFIG}"; then
        echo -e "\n# Syndicate Protocol CLI\nset -gx SYNDICATE_HOME \"${SYNDICATE_HOME}\"\nfish_add_path \"${BIN_DIR}\" \"${HOME}/.local/bin\"" >> "${FISH_CONFIG}"
        echo -e "   ${GREEN}✓ Updated ${FISH_CONFIG}${NC}"
    fi
fi

echo ""
echo -e "${GREEN}🎉 Syndicate Protocol installed successfully!${NC}"
echo -e "   Binary:  ${TARGET_BIN}"
echo -e "   Symlink: ${HOME}/.local/bin/syn"
echo -e "   Home:    ${SYNDICATE_HOME}"
echo ""
echo -e "${CYAN}To start using immediately, run:${NC}"
echo -e "   export PATH=\"${BIN_DIR}:${HOME}/.local/bin:\$PATH\""
echo -e "   syn version"
echo -e "   syn doctor"
echo ""
