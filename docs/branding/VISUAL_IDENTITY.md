# Nzumari Studio visual identity

This file records the desktop application's first-party brand implementation. The official SVG source assets are preserved byte-for-byte from the Nzumari brand repository.

## Identity

- Product name: **Nzumari Studio**
- Brand line: **Compose · Preserve · Evolve · Distribute**
- Official icon: `resources/nzumari-icon.svg`
- Official wordmark: `resources/nzumari-wordmark.svg`

## Colour system

The supplied identity artwork and the web application's CSS theme use related but distinct values. Preserve both rather than forcing the SVG artwork to match interface colours.

**Official identity palette**

| Token | Hex | Role |
|---|---|---|
| Forest | `#173B30` | Primary identity colour |
| Warm ivory | `#F4F0E6` | Brand neutral |
| Brass | `#C6A66B` | Brand accent |
| Burgundy | `#702F3B` | Secondary identity accent |

**Native interface palette**

The Qt light and dark configurations map the OKLCH tokens in the supplied `notasili.css` theme to sRGB values. Key mappings include light surfaces `#FCFAF6` / `#EAF1EA`, light forest `#205335`, gold `#C09337`, burgundy `#883839`, sage `#83A683`, dark surfaces `#121914` / `#242E27`, and dark primary `#9EC39E` with gold `#D7A94F`.

The official icon also contains its own tonal gradients. Do not flatten, recolour, redraw or substitute the icon artwork.

## Interface direction

Nzumari Studio should feel like a considered professional creative workstation, not a generic SaaS dashboard.

- Keep score paper and notation contrast neutral and highly legible.
- Use forest for primary application identity and selected navigation.
- Use warm ivory for calm, low-glare light surfaces.
- Use brass sparingly for focus, active controls and important affordances.
- Use burgundy for restrained secondary emphasis, never as a large warning-like wash.
- Keep borders quiet, hierarchy clear, and spacing deliberate.
- Dark mode should use deep green-black surfaces and warm off-white text; preserve the same accent roles.
- Do not apply brand colours to notation glyphs or alter engraving output.

## Typography

The web product's design tokens specify Inter for interface text, Playfair Display for editorial display text, and JetBrains Mono for code/technical values. Desktop integration should use these only where the font assets and licensing are available; otherwise use appropriate system fallbacks without blocking the application build.

## Product identity boundaries

MuseScore remains credited as the upstream notation and engraving foundation. Nzumari branding identifies this downstream product and its original integration work. Keep required copyright, licence and third-party notices intact.
