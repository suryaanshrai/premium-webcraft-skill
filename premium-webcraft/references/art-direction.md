# Art Direction Lock

Contents:
1. Why the lock exists
2. The `art-direction.md` template
3. Palette construction
4. The type system
5. Grid, rulers, and rhythm
6. Surface, light, and texture
7. `tokens.css` starting point
8. Four worked directions

---

## 1. Why the lock exists

A page built section-by-section without a lock will contain, by the end, four heading sizes that were each "about right" in isolation, three greys, two accents, and section padding that varies by 40px for no reason. No single choice is wrong. The accumulation is what reads as amateur.

The lock costs ten minutes and eliminates the entire class of failure. Write it to disk. Re-read it before each new section. When you're tempted to deviate, either change the lock deliberately and propagate, or don't deviate.

---

## 2. The `art-direction.md` template

Write this file before any markup exists.

```markdown
# Art Direction — [Project]

## The one-line brief
[What this page must make someone feel, in one sentence.]

## Reference register
[2–3 named registers, not URLs. e.g. "Cold gallery minimalism", "1970s
technical manual", "Luxury automotive night photography".]

## The anchor
[The single signature element. One sentence. Everything else is quiet.]

## Anti-brief
[What this must never feel like. Naming the enemy sharpens every later call.
e.g. "Never SaaS-friendly. No rounded cards. No smiling stock people."]

## Palette
- Ground:      #______   [name]
- Ground +1:   #______   (raised surfaces)
- Ground +2:   #______   (hairlines, dividers)
- Ink:         #______   at 100 / 62 / 38%
- Accent:      #______   [used only for: ______ ]

## Type
- Display: [family] — weight, tracking, line-height
- Body:    [family] — weight, tracking, line-height
- Ratio display:body at 1440px = __:1   (target ≥ 6:1)

## Motion signature
- Entrance curve: cubic-bezier(__, __, __, __)
- Entrance duration: ___ms
- Stagger: ___ms
- The one recurring gesture: [e.g. "everything unmasks upward from a clip-path"]

## Rulers
- A: --margin
- B: __%
- C: __%

## Density
Text objects per viewport: ___
Sections total: ___
```

---

## 3. Palette construction

**Five values. Not six.**

Start from the ground, not the accent. The ground is 85–95% of what anyone sees, so it carries the mood almost single-handedly.

**Never pure `#000` or `#fff`.** Pure black kills all sense of depth — you cannot render a shadow on it, so objects sit flat on the surface instead of in a space. Pure white is clinical and shows every antialiasing artifact.

Dark grounds — pick one and derive:

| Register | Ground | +1 | +2 |
|---|---|---|---|
| Cold / technical | `#0B0C0E` | `#131519` | `#1D2026` |
| Warm / leather | `#0E0B09` | `#171310` | `#221C18` |
| Neutral gallery | `#0C0C0C` | `#141414` | `#1E1E1E` |
| Deep blue-black | `#080A12` | `#101320` | `#1A1E2E` |

Light grounds:

| Register | Ground | +1 | +2 |
|---|---|---|---|
| Paper / editorial | `#F4F1EA` | `#EAE6DC` | `#DDD8CC` |
| Cold gallery | `#F2F3F4` | `#E8EAEC` | `#DADCE0` |
| Bone / archival | `#EFEBE3` | `#E4DFD5` | `#D5CFC3` |

**Ink** is rarely the pure inverse of the ground. On `#0B0C0E`, ink is `#EDEDEF`, not `#FFFFFF`. On paper, ink is `#1A1815`, not black. The slight compression of contrast is what makes a screen feel printed rather than emitted.

**The accent** works by scarcity. One CTA border, one active state, one underline on hover. The instant it appears in three places on one screen it stops being an accent and becomes part of the palette — which means the palette is now six values and consistency has already started to slip.

**Never a purple→blue linear gradient at 45°.** It is the single most recognisable AI-generated signature in existence. If you need a gradient, use a **radial falloff from a light source** — a glow behind the subject, spilling outward — which is how light actually behaves and reads as photography rather than CSS.

```css
/* reads as a lit space */
background:
  radial-gradient(60% 50% at 50% 38%, #262A33 0%, transparent 70%),
  var(--ground);
```

**Add grain.** Flat digital colour looks synthetic at large areas. A 2–4% noise overlay is nearly invisible and adds a great deal of material quality:

```css
.grain::after {
  content: ""; position: fixed; inset: 0; pointer-events: none;
  z-index: 100; opacity: 0.035; mix-blend-mode: overlay;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence baseFrequency='0.9' numOctaves='3'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
}
```

---

## 4. The type system

### The ratio rule

Measure the largest display size against the body size at 1440px. **Target 6:1 or greater.**

A generic page runs about 3:1 — 48px headline, 16px body. A reference-tier page runs 7:1 or 9:1 — a 128px display over 16px body. This one ratio accounts for an enormous share of the perceived difference, and it costs nothing.

### Scale

```css
:root {
  --t-display: clamp(3.5rem, 9vw, 11rem);
  --t-h1:      clamp(2.5rem, 5.5vw, 5rem);
  --t-h2:      clamp(1.75rem, 3vw, 2.75rem);
  --t-lead:    clamp(1.125rem, 1.5vw, 1.375rem);
  --t-body:    1rem;
  --t-small:   0.8125rem;
  --t-chrome:  0.6875rem;   /* 11px — the HUD layer */
}
```

### Per-role settings

| Role | Weight | Tracking | Line-height | Notes |
|---|---|---|---|---|
| Display | 300–500 | `-0.035em` | `0.94` | Tighter as size grows. Serif display is more distinctive than sans. |
| H1 / H2 | 400–500 | `-0.02em` | `1.05` | |
| Lead | 400 | `-0.005em` | `1.5` | Max 45ch. |
| Body | 400 | `0` | `1.65` | Max 62ch — never full width. |
| Chrome | 500 | `0.16em` | `1.2` | Uppercase, opacity 0.5–0.65. |

### Pairing

Two families maximum; one strong family used across weights is often better.

Reliable, well-hinted pairings that don't read as defaults:

- **Editorial luxury** — Editorial New / Canela / Instrument Serif display + Suisse Intl or Inter for chrome
- **Technical** — Neue Haas Grotesk or Söhne throughout, weight contrast only
- **Brutal editorial** — a condensed grotesque display (Druk, Anton) + a neutral sans
- **Warm craft** — a humanist serif (Freight, Lora) + a geometric sans at small sizes

Free options that hold up: Instrument Serif, Fraunces, Bricolage Grotesque, Geist, General Sans, Satoshi.

### The italic swap

Set one word of a serif display headline in italic. "The Anatomy *of a Suit*." "Tailoring for the *few*." It takes one `<em>` and immediately reads as art-directed rather than typed.

### Fluid but bounded

Always `clamp()`, never raw `vw`. Unbounded `vw` produces 200px headings on a 27" display, which is the other direction of wrong.

### Typographic detail

Small, cheap, and disproportionately visible at display sizes — a straight apostrophe at 140px is enormous.

- `…` not `...`, everywhere including loading strings
- Curly quotes `“` `”` `‘` `’`, never the typewriter forms
- Non-breaking spaces in `10&nbsp;MB`, `⌘&nbsp;K`, and brand names
- `text-wrap: balance` on headings to kill widows; `text-pretty` on body
- `font-variant-numeric: tabular-nums` in spec tables, counters, and prices
- En dash for ranges, em dash for breaks, hyphen only for hyphenation
- `Intl.DateTimeFormat` / `Intl.NumberFormat` rather than hardcoded formats

The full implementation checklist is in `implementation-review.md`.

---

## 5. Grid, rulers, and rhythm

### Horizontal

```css
:root {
  --margin: clamp(1.5rem, 6vw, 7rem);
  --maxw: 1600px;
}
```

A 12-column grid, but **content should rarely span more than 7 of them**. Full-bleed is reserved for media. A text block that spans 5 columns with 7 empty beside it is the composition; the emptiness is doing the work.

### The rulers

Two or three x-positions, held site-wide. Every text block starts at one of them.

```css
.at-a { margin-left: var(--margin); }
.at-b { margin-left: clamp(var(--margin), 38%, 38%); }
.at-c { margin-left: clamp(var(--margin), 62%, 62%); }
```

Alternating A and B down the page produces controlled asymmetry. Ad-hoc offsets produce noise. This is the difference.

### Vertical rhythm

Section spacing scales with the viewport, not with px — a 120px gap that feels generous on a laptop is cramped on a 4K display.

```css
:root {
  --space-section: clamp(6rem, 16vh, 14rem);
  --space-block:   clamp(2.5rem, 7vh, 5rem);
  --space-tight:   clamp(1rem, 2vh, 1.75rem);
}
```

Alternate dense sections with near-empty ones. Two information-heavy sections back to back exhausts the reader and flattens the pacing. A screen containing one sentence is not wasted space — it's the rest that makes the next dense screen land.

---

## 6. Surface, light, and texture

Premium pages read as **lit spaces**, not coloured rectangles. Four moves carry most of it:

**Light source.** Establish where the light comes from and honour it everywhere. If the hero glows from upper-left, every shadow on the page falls lower-right.

**Contact shadow.** An object floating with no shadow looks pasted on. A tight, dark, small-radius shadow directly beneath it plants it in the space:

```css
filter: drop-shadow(0 24px 40px rgb(0 0 0 / 0.55));
```

**Reflection.** On dark grounds, a flipped, blurred, 12–18% opacity copy of the subject below it, masked with a gradient, is one of the highest-value-per-line effects available.

**Vignette.** A soft radial darkening at the frame edges focuses attention centrally and is why cinema stills feel composed. Keep it under 25% or it reads as a filter.

**Borders:** hairlines at `1px` with the ink colour at 8–12% opacity. Never a solid grey `1px` border — that's a form field, not a design element.

**Radii:** pick `0` or a large value like `24px`. The mid-range `8px`/`12px` rounded rectangle is Bootstrap's fingerprint and is instantly legible as a default.

---

## 7. `tokens.css` starting point

```css
:root {
  /* ground */
  --ground: #0B0C0E;
  --ground-1: #131519;
  --ground-2: #1D2026;

  /* ink */
  --ink: #EDEDEF;
  --ink-62: rgb(237 237 239 / 0.62);
  --ink-38: rgb(237 237 239 / 0.38);
  --hairline: rgb(237 237 239 / 0.10);

  /* accent — one */
  --accent: #C9A227;

  /* type */
  --font-display: "Instrument Serif", Georgia, serif;
  --font-ui: "Suisse Intl", system-ui, sans-serif;
  --t-display: clamp(3.5rem, 9vw, 11rem);
  --t-h2: clamp(1.75rem, 3vw, 2.75rem);
  --t-body: 1rem;
  --t-chrome: 0.6875rem;

  /* space */
  --margin: clamp(1.5rem, 6vw, 7rem);
  --space-section: clamp(6rem, 16vh, 14rem);
  --space-block: clamp(2.5rem, 7vh, 5rem);

  /* rulers */
  --ruler-b: 38%;
  --ruler-c: 62%;

  /* motion */
  --ease-out: cubic-bezier(0.16, 1, 0.3, 1);
  --ease-ui:  cubic-bezier(0.4, 0, 0.2, 1);
  --dur-enter: 900ms;
  --dur-ui: 300ms;
  --stagger: 75ms;
}
```

Also write a `DESIGN.md` at the project root mirroring these tokens — see `reference-extraction.md` §6. It costs nothing and means any other agent or future session picks up the same system instead of re-deriving it.

---

## 8. Four worked directions

**Cold gallery.** Ground `#F2F3F4`, ink `#131415`, accent `#B0453A`. Instrument Serif display at 9vw, tiny tracked sans chrome. Single object centred in vast white. Motion: slow clip-path unmasks only. Register: museum wall label.

**Night luxury.** Ground `#0B0B0D`, ink `#E8E6E1`, accent `#C9A227`. Serif display with italic accents, everything lit by one soft overhead key with a reflection below. Motion: long dissolves, 1.1s. Register: watch advertising.

**Technical / instrument.** Ground `#0A0C10`, ink `#D6DBE2`, accent `#4ADE80`. Monospace chrome, grotesque display, hairline grid faintly visible, numeric readouts in corners. Motion: sharp, 400ms, mechanical. Register: flight deck.

**Warm archival.** Ground `#EFEBE3`, ink `#241F1A`, accent `#8C5A2B`. Serif throughout, heavy grain, photography with warm cast, generous margins. Motion: gentle upward drifts. Register: art book.

Each is five values and two typefaces. Each is instantly distinguishable from the others and from a template. That's the entire point of the lock.
