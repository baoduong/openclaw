WSL Setup Notes for OpenClaw

Summary

- Use WSL2 (Windows 11 recommended).
- Keep the OpenClaw repo inside WSL filesystem (e.g., /home/<you>/openclaw). Avoid /mnt/c for performance and file-watcher reliability.
- Use Node 22+ and pnpm.
- Enable systemd in WSL if services are required (add `[boot]\n systemd=true` to /etc/wsl.conf and run `wsl --shutdown` from Windows).

Recommended .wslconfig (C:\\Users\\<you>\\.wslconfig):

[wsl2]
memory=8GB
processors=4
swap=2GB
localhostForwarding=true

Docker

- Use Docker Desktop with WSL integration or install Docker Engine inside WSL.

Notes

- If editing files from Windows editors, prefer opening the WSL distro via `wsl.exe -d <distro> -- code .` (Visual Studio Code Remote - WSL) so files live in the WSL FS.
- For GUI/tooling wrappers, use a PowerShell script that runs `wsl -d <distro> -- bash -lc 'cd /home/<you>/openclaw && pnpm dev'`.
