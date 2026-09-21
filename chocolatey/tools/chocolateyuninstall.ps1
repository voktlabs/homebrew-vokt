$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Remove the vokt executable
$exePath = Join-Path $toolsDir "vokt.exe"
if (Test-Path $exePath) {
    Remove-Item $exePath -Force -ErrorAction SilentlyContinue
    Write-Host "Vokt binary removed."
} else {
    Write-Warning "Vokt executable not found at: $exePath"
}

Write-Host "Vokt has been uninstalled."
