# YOLA - Instalacion preview (Windows PowerShell)
# Uso: iwr -useb https://yolabysayri.com/install.ps1 | iex
#
# PREVIEW 2026-08: instala el DAEMON real (el binario estable) desde los
# downloads oficiales. La campana del 24.09 traera la version completa.

$VERSION = "preview"
$URL = "https://yolabysayri.com/downloads/yola-daemon-windows-amd64.exe"
$DEST = "$env:LOCALAPPDATA\yola"
$FILE = "$DEST\yola-daemon.exe"

Write-Host "YOLA Preview - instalando el daemon..." -ForegroundColor Cyan
if (!(Test-Path $DEST)) { New-Item -Type Directory $DEST -Force | Out-Null }

Write-Host "Descargando el daemon (28 MB)..."
Invoke-WebRequest -Uri $URL -OutFile $FILE -UseBasicParsing
if (!(Test-Path $FILE)) { Write-Host "[X] Fallo la descarga" -ForegroundColor Red; exit 1 }

Write-Host "Iniciando YOLA..."
Start-Process -FilePath $FILE -ArgumentList "start --port 7779 --foreground" -WorkingDirectory $DEST
Start-Sleep -Seconds 4
Write-Host "Abriendo el YOLA OS..."
Start-Process "http://localhost:7779/ui/"
Write-Host "YOLA viva. Pega tu key o nace la tuya. La conquista es todos los dias." -ForegroundColor Green
