#!/bin/bash
set -euo pipefail

# ═══════════════════════════════════════════════════════════════════════
# YOLA — Instalación universal para Linux/macOS
# ═══════════════════════════════════════════════════════════════════════
# Uso: curl -fsSL https://yolabysayri.com/install.sh | bash
# O:   curl -fsSL https://yolabysayri.com/install.sh | bash -s -- -b /usr/local/bin
#
# ⚠ ESTADO REAL (2026-08): yola-cli es un CLI TypeScript/Bun — todavía NO
# existe un binario standalone publicado. El binario oficial se publicará en
# la release 24.09.2026 (GitHub Releases). Patrón de URL:
#   https://github.com/ROSALDEV-SAC/yola-cli/releases/latest/download/yola-cli-<os>-<arch>
# Este script es honesto: solo descarga si el binario ya está publicado.
# ═══════════════════════════════════════════════════════════════════════

VERSION="0.1.4"
RELEASE_URL="https://github.com/ROSALDEV-SAC/yola-cli/releases/latest/download"

# ── Colores ──────────────────────────────────────────────────────────
BOLD='\033[1m'
DIM='\033[2m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ── Parsear flags ─────────────────────────────────────────────────────
INSTALL_DIR="/usr/local/bin"
while getopts "b:" opt; do
  case "$opt" in
    b) INSTALL_DIR="$OPTARG" ;;
    *) ;;
  esac
done

# ── Detectar OS/Arch ─────────────────────────────────────────────────
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$ARCH" in
  x86_64|amd64)  ARCH="x64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *)
    echo -e "${RED}✖${NC} Arquitectura no soportada: $ARCH"
    exit 1
    ;;
esac

case "$OS" in
  linux)  ASSET="yola-cli-linux-$ARCH" ;;
  darwin) ASSET="yola-cli-macos-$ARCH" ;;
  *)
    echo -e "${RED}✖${NC} SO no soportado: $OS (en Windows usá install.ps1)"
    exit 1
    ;;
esac

# ── Determinar destino ────────────────────────────────────────────────
if [ ! -d "$INSTALL_DIR" ]; then
  # Fallback a ~/.local/bin si el directorio no existe (macOS sin permisos)
  INSTALL_DIR="$HOME/.local/bin"
fi
mkdir -p "$INSTALL_DIR"
DEST="$INSTALL_DIR/yola-cli"

# ── Verificar si ya existe ────────────────────────────────────────────
if [ -f "$DEST" ]; then
  echo -e "${PURPLE}ℹ${NC} yola ya está instalado en $DEST"
  echo -e "   Para actualizar: rm '$DEST' y ejecutá el comando de nuevo"
  exit 0
fi

# ── Descargar (solo si la release ya existe) ──────────────────────────
URL="$RELEASE_URL/$ASSET"
echo -e "${BOLD}⬇${NC} Buscando YOLA CLI $VERSION en la release..."
echo -e "   ${DIM}$URL${NC}"

if ! curl -fsSL "$URL" -o "$DEST" 2>/dev/null; then
  rm -f "$DEST"
  echo ""
  echo -e "${YELLOW}📦 YOLA CLI todavía no está publicado como binario.${NC}"
  echo -e "   El binario oficial estará disponible en la release ${BOLD}24.09.2026${NC}."
  echo -e "   Patrón de URL: ${DIM}$URL${NC}"
  echo -e "   Mientras tanto podés usar la UI web: ${DIM}https://yolabysayri.com/yola-os/${NC}"
  exit 1
fi

chmod +x "$DEST"
echo -e "${GREEN}✔${NC} Instalado en $DEST"

echo ""
echo -e "   Ejecutá 'yola-cli' para empezar" 
echo -e "   O 'yola-cli serve' para la UI web"
