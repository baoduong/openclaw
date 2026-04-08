#!/usr/bin/env bash
set -euo pipefail

# Minimal WSL setup script for OpenClaw
# Runs nvm install (Node 22+), installs pnpm, deps, runs checks and build.

echo "[openclaw] WSL installer starting"

# Load nvm if present, otherwise install
if [ -z "${NVM_DIR:-}" ]; then
  export NVM_DIR="$HOME/.nvm"
fi

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  echo "nvm not found — installing nvm"
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.6/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
else
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# Ensure Node 22 is installed
echo "Installing Node 22 (LTS) via nvm"
nvm install 22 >/dev/null
nvm use 22 >/dev/null

# Install pnpm globally
echo "Installing pnpm"
npm install -g pnpm@latest --silent

# Ensure inside project root
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

echo "Repository dir: $REPO_DIR"

# Install dependencies and run checks/build
echo "Installing dependencies (pnpm)"
pnpm install --frozen-lockfile

echo "Running pnpm check (lint/type/test)"
if pnpm check; then
  echo "Checks passed"
else
  echo "pnpm check failed — fix locally and re-run"
  exit 1
fi

# Run tests (optional, may take time)
if command -v pnpm >/dev/null 2>&1; then
  echo "Running a focused test set (fast)"
  pnpm test --silent || echo "Tests had failures — investigate locally"
fi

# Build
echo "Building project"
pnpm build

echo "OpenClaw WSL install complete. Reminder: keep the repo on WSL filesystem (not /mnt/c) for best performance."
