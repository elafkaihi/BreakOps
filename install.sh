#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="/usr/local/bin"
BREAKOPS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "💥 Installing BreakOps..."

# Check Docker
if ! command -v docker &>/dev/null; then
  echo "❌ Docker is required but not installed. See https://docs.docker.com/get-docker/"
  exit 1
fi

# Make CLI executable
chmod +x "$BREAKOPS_DIR/breakops"

# Symlink to PATH
if [[ -w "$INSTALL_DIR" ]]; then
  ln -sf "$BREAKOPS_DIR/breakops" "$INSTALL_DIR/breakops"
else
  sudo ln -sf "$BREAKOPS_DIR/breakops" "$INSTALL_DIR/breakops"
fi

echo "✅ BreakOps installed!"
echo ""
echo "Try it:"
echo "  breakops list"
echo "  breakops start linux-001"
