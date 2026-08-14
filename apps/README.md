# YOLA App Store — Catálogo de Internet (GitHub Pages)

El catálogo de apps es **data que vive en Internet**, no código hardcodeado.
YOLA lo descarga desde `https://yolabysayri.com/apps/catalog.json` (GitHub
Pages) con fallback al catálogo local (`public/apps/`) cuando está offline.

## Estructura que debe servir el sitio

```
yolabysayri.com/
└── apps/
    ├── catalog.json          ← el índice (YOLA lo descarga)
    └── <otra-app>/           ← fallback offline (dev)
```

## El repo GitHub es la fuente de verdad

Cada app del catálogo vive en su **repo público de GitHub**. El repo contiene
`manifest.json` + `app.js` en la raíz, y el catálogo lo referencia con
**jsDelivr CDN** (que sirve los `.js` con el MIME de módulo correcto —
`raw.githubusercontent.com` no puede):

```json
{
  "id": "yola-code",
  "repo": "github.com/SayriDevs/YolaCode",
  "manifestUrl": "https://cdn.jsdelivr.net/gh/SayriDevs/YolaCode@main/manifest.json"
}
```

- **Entrega** (instalación): jsDelivr — MIME correcto + CORS abierto
- **Verificación** (identidad): el bridge descarga del raw del repo y verifica
  que `manifest.repo` coincida y que el checksum del entry sea fiel
- **Integridad**: si jsDelivr sirviera contenido distinto al repo, el checksum
  falla → la instalación se rechaza

> ⚠️ jsDelivr cachea ~12h. Tras un push con cambios, purga con:
> `https://purge.jsdelivr.net/gh/SayriDevs/YolaCode@main/app.js`

## Cómo publicar (GitHub Pages)

1. Este repo (`si-yola`) o un repo dedicado publica la carpeta `public/apps/`
   como raíz del sitio (rama `gh-pages` o GitHub Actions con `actions/deploy-pages`).
2. El dominio personalizado `yolabysayri.com` apunta al sitio en
   **Settings → Pages → Custom domain** (con CNAME `yolabysayri.com`).
3. YOLA (App Store) descarga `https://yolabysayri.com/apps/catalog.json` automáticamente.

### Script de ayuda

```powershell
# Copia public/apps → ./dist-appstore (listo para subir como raíz del sitio)
.\scripts\publish-appstore.ps1
```

## Contrato de una app del catálogo

Cada entrada de `catalog.json`:

```json
{
  "id": "yola-code",
  "name": "YOLA Code",
  "icon": "🧑‍💻",
  "category": "Dev",
  "description": "…",
  "version": "0.1.0",
  "manifestUrl": "/apps/yola-code/manifest.json",
  "permissions": ["notify", "openApp"]
}
```

Y el `manifest.json` de la app declara su entry **con checksum sha256**:

```json
{
  "id": "yola-code",
  "entry": "app.js",
  "checksum": "e105bbb6…",
  "permissions": ["notify", "openApp"]
}
```

YOLA verifica el checksum del entry **antes** de importarlo: si el archivo
servido no coincide con lo que firmó el manifest, la instalación se rechaza.
