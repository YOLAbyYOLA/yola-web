# downloads/ — Binarios YOLA

Estado real verificado contra los repositorios (2026-08-09). La regla: **no se
sirve ningún binario que no exista**. Los binarios oficiales se publican el
**24.09.2026** en GitHub Releases.

## Contenido actual

| Archivo | Versión | Origen |
|---|---|---|
| `yola-daemon-0.1.4-windows-amd64.exe` | 0.1.4 | `CUERPOS_YOLA/yola-daemon/target/release/yola-daemon.exe` (build 2026-08-09, Rust) |

`yola-daemon` es el motor (Rust): el engine que orquesta agentes, sesiones y
la UI. Es el mismo binario que `yola-server` empaqueta en Docker y el que
`yola-releases` publica como `yola-daemon-win.exe`.

## Binarios que se publicarán en la release 24.09.2026

Estos repos aún **no producen binario publicado** — se documenta de dónde saldrá cada uno:

| Binario | Estado hoy | Dónde se compilará |
|---|---|---|
| `yola-cli` | CLI **TypeScript/Bun** (v0.1.4, `bin: yola → dist/cli.js`). Solo fuente, sin binario standalone | `ROSALDEV-SAC/yola-cli` (bun build --compile) |
| `yola-tui` | **Rust** — solo existe build `target/debug` (artefacto de desarrollo, no release) | `ROSALDEV-SAC/yola-tui` (cargo build --release) |
| `yola-server` | Sin binario en el repo: es un **wrapper Docker** que empaqueta `yola-daemon` | `ROSALDEV-SAC/yola-server` (imagen Docker) |
| `yola-daemon` (linux/macos/android) | Solo existe el binario Windows local | CI `ROSALDEV-SAC/yola-daemon` → publica en `yola-releases` |

## Patrón de URL de la release (GitHub Releases)

```
https://github.com/ROSALDEV-SAC/<repo>/releases/latest/download/<asset>
```

Convención de nombres de asset propuesta (coherente con la usada por
`install.ps1` / `install.sh`):

- `yola-cli-windows-x64.exe` · `yola-cli-windows-arm64.exe`
- `yola-cli-linux-x64` · `yola-cli-linux-arm64`
- `yola-cli-macos-x64` · `yola-cli-macos-arm64`

## Retirado (2026-08-09)

| Elemento | Motivo |
|---|---|
| `yolaavisa.apk` | No es YOLA — APK sin repositorio en el ecosistema |
| `yolavigila/` (4 binarios Bun 1.3.14) | Sin repositorio en el ecosistema — binarios huérfanos (~311 MB) |
| `yola-cli/` (5 binarios Go v0.1.0) | Línea muerta: yola-cli es ahora TypeScript/Bun. Los binarios Go servían un binario que ya no corresponde al estado real |

## Nota para instaladores

`install.ps1` / `install.sh` apuntan al futuro release de GitHub
(`releases/latest/download`). Si el binario aún no existe, los scripts avisan
con honestidad y no descargan nada falso.
