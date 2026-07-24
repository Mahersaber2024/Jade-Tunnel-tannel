#!/usr/bin/env bash
# =============================================================================
#  Jade-Tunnel-tannel — one-command installer
#  Repo   : https://github.com/Mahersaber2024/Jade-Tunnel-tannel
#  Usage  : bash <(curl -fsSL https://raw.githubusercontent.com/Mahersaber2024/Jade-Tunnel-tannel/main/install.sh)
# =============================================================================
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/Mahersaber2024/Jade-Tunnel-tannel/main"
SCRIPT_NAME="manager-backhaul.sh"
INSTALL_PATH="/usr/local/bin/jadetunnel"

# ── must be root ─────────────────────────────────────────────────────────────
if [[ $EUID -ne 0 ]]; then
    echo "Please run as root (use: sudo bash <(curl -fsSL ...))" >&2
    exit 1
fi

# ── make sure curl or wget exists ────────────────────────────────────────────
if command -v curl &>/dev/null; then
    FETCH() { curl -fsSL "$1" -o "$2"; }
elif command -v wget &>/dev/null; then
    FETCH() { wget -q "$1" -O "$2"; }
else
    echo "Installing curl..." 
    (apt-get update -qq && apt-get install -y curl -qq) || \
    (yum install -y curl) || \
    (dnf install -y curl) || {
        echo "Could not install curl automatically. Please install curl or wget manually." >&2
        exit 1
    }
    FETCH() { curl -fsSL "$1" -o "$2"; }
fi

# ── make sure openssl exists (needed for wssmux certs) ───────────────────────
if ! command -v openssl &>/dev/null; then
    echo "Installing openssl..."
    (apt-get update -qq && apt-get install -y openssl -qq) || \
    (yum install -y openssl) || \
    (dnf install -y openssl) || \
    echo "Warning: could not install openssl automatically — WSSMUX cert generation may fail."
fi

# ── fetch the manager script ─────────────────────────────────────────────────
echo "Downloading Jade Tunnel manager..."
FETCH "$REPO_RAW/$SCRIPT_NAME" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo ""
echo "Installed successfully."
echo "Run it anytime with:  jadetunnel"
echo ""

# ── launch immediately ────────────────────────────────────────────────────────
exec "$INSTALL_PATH"
