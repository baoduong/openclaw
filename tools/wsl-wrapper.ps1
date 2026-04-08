<#
PowerShell helper to run OpenClaw commands inside WSL.
Usage:
  .\wsl-wrapper.ps1 -Distro Ubuntu -ProjectPath /home/you/openclaw -Cmd 'pnpm build'
If -Cmd omitted, defaults to 'cd <ProjectPath> && pnpm dev'.
#>
param(
  [string]$Distro = "",
  [string]$ProjectPath = "",
  [Parameter(ValueFromRemainingArguments=$true)]
  [string[]]$Cmd
)

if (-not $Distro) {
  # Pick first installed distro if none provided
  $list = wsl -l -q | Out-String
  $first = $list -split "\r?\n" | Where-Object { $_ -ne "" } | Select-Object -First 1
  if ($first) { $Distro = $first.Trim() } else { $Distro = "Ubuntu" }
}

if (-not $ProjectPath) {
  $ProjectPath = "/home/$env:USERNAME/openclaw"
}

if ($Cmd.Length -gt 0) {
  $joined = $Cmd -join ' '
} else {
  $joined = "cd $ProjectPath && pnpm dev"
}

Write-Host "Running in WSL distro: $Distro" -ForegroundColor Green
wsl -d $Distro -- bash -lc "$joined"
