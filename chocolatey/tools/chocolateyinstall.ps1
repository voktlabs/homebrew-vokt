$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = '$DOWNLOAD_URL$'
$checksum64 = '$CHECKSUM$'

$packageArgs = @{
  packageName   = 'vokt-cli'
  fileType      = 'exe'
  url64bit      = $url64
  softwareName  = 'vokt*'
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = ''
  validExitCodes= @(0)
  destination   = $toolsDir
}

# Download the vokt binary
Get-ChocolateyWebFile @packageArgs

# Rename the downloaded file to vokt.exe
$exePath = Join-Path $toolsDir "vokt-windows-amd64.exe"
$targetPath = Join-Path $toolsDir "vokt.exe"

if (Test-Path $exePath) {
    Move-Item $exePath $targetPath -Force
}

Write-Host "Vokt installed successfully"
