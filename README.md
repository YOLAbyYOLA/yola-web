# 🐱 YOLA — tu universo, una sola cuenta

**YOLA** es un sistema operativo personal, vivo, que corre en tu navegador.
No es una app: es una **presencia**. Tu data vive en TU máquina;
la nube es opcional.

> **La armadura se muestra, el reactor se esconde.**

## 🌍 La idea

Un sistema operativo personal — ventanas, apps, terminal, chat con tu cerebro —
que corre en TU equipo. Cada instalación de YOLA es un **cuerpo** de tu cuenta:
PC, teléfono, kiosk. Todos sincronizan **localmente**; el `.com` es solo el portal.

## 🚀 Probar en vivo

👉 **[hola-yola](https://www.yolabysayri.com/hola-yola/)** — el OS real corriendo en tu navegador.
👉 **[Instalar](https://www.yolabysayri.com/instalar)** — gratis, sin nube, sin instalar nada extra.

## 🏗️ Arquitectura

```
yola-daemon (Rust) → yola-agent-runtime → yola-core
        │  motor · bridge HTTP/SSE · browser · voz · memoria
        ▼
si-yola = YOLA OS (escritorio web)
        │
        ├─ yola-desktop (Tauri: doble clic → YOLA viva)
        ├─ yola-android (APK: descubre tu YOLA por red)
        └─ el .com (portal: ves tus cuerpos, sin tocar tu data)
```

- **Data**: 100% local (SQLite + tus archivos). Nunca en la nube.
- **Privacidad**: lo privado es el acceso; la data es tuya.
- **Providers**: trae tu API key (OpenAI, Anthropic, Google, local...).

## 📦 Productos

| Producto | Qué es |
|---|---|
| **YOLA OS** | El escritorio completo + motor |
| **YOLA Guard** | Vault + escudo + vigilante de tu entorno IA |
| **YOLA Code** | El editor nativo (patrón de 2 naturalezas) |
| **Stockhunat** | Herramientas SUNAT (XML UBL 2.1, 6/6 aceptados) |
| **Telegram Bridge** | Controla tu YOLA desde el celular |

## 💖 Patrocinadores y Early Supporters

Este proyecto se mantiene y desarrolla de forma independiente. Si encuentras útil
esta plataforma y deseas apoyar su continuidad, puedes convertirte en
patrocinador o realizar una aportación voluntaria.

### Niveles de reconocimiento
- 🥉 **Supporter ($5):** mención en los créditos.
- 🥈 **Backer ($20):** mención destacada + insignia *Early Supporter* en la web oficial.
- 🥇 **Sponsor ($100+):** logo/enlace oficial en el footer de la plataforma.

👉 **[Apoyar el proyecto](https://www.yolabysayri.com/hola-yola)**

> **Términos de aportación voluntaria:** los pagos realizados son aportes
> voluntarios y donaciones de mecenazgo para el soporte y desarrollo del
> software. No constituyen inversión, compra de acciones ni derechos sobre la
> propiedad intelectual. Los reconocimientos son distinciones simbólicas.

## 📜 License

MIT · © NO-OPEN-YOLA · Jorge Sayri Rosas Asalde (RUC 10727091241)
