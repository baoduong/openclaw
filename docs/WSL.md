OpenClaw — WSL Installation and Shipping Guide

Quick checklist

1. On Windows:
   - Install WSL2 and a distro (Ubuntu recommended).
   - Add C:\\Users\\<you>\\.wslconfig with recommended resources (memory, processors, swap).

2. In WSL:
   - Keep repo inside WSL FS: /home/<you>/openclaw
   - Run: scripts/install-wsl.sh
   - Use `pnpm dev` for development, `pnpm build` to produce dist/ output.

Systemd

- To enable: add to /etc/wsl.conf:
  [boot]
  systemd=true
  Then run `wsl --shutdown` from Windows and restart the distro.

Docker

- Use Docker Desktop with WSL integration or install Docker inside WSL.

Windows wrapper

- A simple wrapper `tools/wsl-wrapper.ps1` exists to run commands in WSL from PowerShell.

CI / Releases

- GitHub Actions workflow (.github/workflows/release.yml) runs checks, builds, packages a tarball, builds Docker image (if available), and uploads artifacts.

Notes

- Keep large, frequently changed files on WSL FS to avoid I/O and watcher issues.
- For GUI editing, use VS Code Remote - WSL to open the project from the distro.
