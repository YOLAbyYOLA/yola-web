# 📦 Descargas de YOLA

> **Estado 2026-08-14:** los binarios públicos se publican en el **release 24.09**
> firmados con checksums. Los binarios viejos (09-10/08) fueron retirados por
> no ser reproducibles desde el workspace — la integridad primero.

## Binarios verificados (builds locales actuales)

| Binario | SHA256 (build 2026-08-14) |
|---|---|
| `yola-daemon.exe` (32MB, Windows) | `12c67b2e24ccf537b2f7124fe0183d57e868686bea60af2620f219d004a9dca9` |

## Instaladores de productos

| Producto | Cómo se obtiene |
|---|---|
| **YOLA Secrets** (Secret Manager) | Repo `NO-OPEN-YOLA/yola-secrets` → `install.ps1` (compila e instala CLI + app) |
| **YOLA OS / daemon** | Release 24.09 (GitHub Releases, firmado) |

## ⚠️ Integridad

- Los binarios **oficiales** saldrán **firmados** (tauri signer) con `.sig` + checksums publicados
- **Nunca ejecutes** un binario YOLA descargado sin verificar su SHA256 contra el publicado
- Este directorio solo contiene el README — los binarios NO viven en el repo de la web
  (se sirven desde GitHub Releases, que permite firma y checksums)
