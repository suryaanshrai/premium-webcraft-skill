# The Page Score

Contents:
1. The `page-score.md` artifact
2. Beat by beat
3. Category variants
4. Compressing and extending
5. Two worked scores

---

## 1. The `page-score.md` artifact

Write this before building. It's the structural counterpart to the art-direction lock, and it exists for the same reason — so that beat 6 doesn't contradict beat 2.

```markdown
# Page Score — [Product]

## The product, in one sentence
[What it is and what makes it worth wanting.]

## The withheld thing
[What the cold open deliberately does not show.]

## The subject's arc
[How the product moves across the scroll. e.g. "Emerges from shadow →
turns into the light → camera pushes into the stitching → pulls back →
worn by a person → laid flat for spec."]

## Beats
| # | Beat | Title on page | Copy line | Shot required |
|---|------|---------------|-----------|---------------|
| 1 | Cold open | | | |
| 2 | Reveal | | | |
| 3a| Anatomy 1 | | | |
| 3b| Anatomy 2 | | | |
| 3c| Anatomy 3 | | | |
| 4 | In the world | | | |
| 5 | Specification | — | | |
| 6 | Offer | | | |
| 7 | Close | | | |

## HUD
Chapter labels: [ 01 — ___ ] ...
Counter format: __ / __

## The single CTA
[Exact button text and destination.]
```

The "shot required" column is the brief for asset production. Fill it before generating or commissioning anything.

---

## 2. Beat by beat

### 0 — Preload

Not a spinner. A counter climbing to 100 in the display face, or the product name drawing on, or a hairline filling the width of the screen.

Hold for at least 1.5s even if assets are ready. An instant flash-through reads as a glitch, and the pause is doing real work — it separates the page from the browser and signals that something has been prepared.

Reveal by dissolving the loader into the cold open, not by cutting.

### 1 — Cold open

**Contents: the product name or a title line, one supporting line, a scroll cue, and the product mostly hidden.** Nothing else. No nav CTA button, no badges, no "trusted by".

Ways to hide the product while still showing it:
- Silhouette against a lit background
- Rim light only — one bright edge, the rest in darkness
- Cropped so tight the object isn't yet identifiable
- Out of focus, resolving to sharp as the user begins to scroll
- Behind a scrim, glass, fabric, or steam

Typography carries this screen. Display type at the maximum size the lock allows, one italic word if the face supports it, sitting on ruler A or B — not centred.

The nav here should be minimal to the point of near-absence: wordmark and two or three links at chrome size.

### 2 — The reveal

The product, fully lit, full presence, given the whole frame. This is the screenshot people will share.

Ideally driven by scroll from beat 1 — as the user scrolls, light comes up, focus resolves, the object rotates into view. Pin it and scrub. The transformation from hidden to revealed is more compelling than a cut between two states.

Text here is minimal — often just the product name at chrome size and a single line. The image is the argument.

### 3 — Anatomy chapters

Three to five. Each one:

- **Pinned** for 120–150vh of scroll
- **One title**, a concrete noun, in display or H2 size
- **One or two sentences** — 15–30 words total
- **One micro-label** — a spec fragment, a material name, a number
- **The product staged to foreground that part** — usually a tighter crop than the previous chapter

The camera should feel like it's moving *through* the product across the sequence: wide → closer → closest → pulling back. That trajectory gives the sequence direction. Chapters at the same distance feel like a slideshow.

**Transitions between chapters carry a lot of the quality.** Options that work:
- Crossfade between two shots with a slight scale on both
- The product rotating continuously across chapters (scrubbed frame sequence)
- A wipe following the product's own edge
- Camera push where each chapter is deeper into the same image

Avoid a hard cut. Avoid each chapter sliding in from the side — that reads as a carousel.

### 4 — In the world

The only beat with a person, an environment, or a sense of scale. It answers "what is it like to have this", which the studio shots deliberately cannot.

Keep it a single image or short loop, full bleed, with almost no text. If the page has a lifestyle photograph, this is where it goes, and it should be the only one.

For software, this is the interface in genuine use — a real screen with real data, not a mockup floating at an angle on a gradient.

### 5 — Specification

The density inversion. Small type, tight leading, aligned columns, hairline dividers.

Include real, specific, checkable facts: materials, dimensions, weight, origin, process time, certifications, compatibility, what's in the box. Numbers with units.

```
MATERIAL      Super 130s wool, Vitale Barberis Canonico
CANVAS        Full floating horsehair
CONSTRUCTION  Hand-padded lapel, 14 hours
BUTTONS       Corozo nut, hand-sewn shank
LINING        Bemberg cupro
MADE IN       Naples, Italy
```

Set it in the UI face at 13–14px with the labels in chrome style at 11px and 62% ink. Two or three columns on desktop, one on mobile.

If the product genuinely has no specifications — a service, a piece of software — substitute a *process* or *provenance* block in the same register. Numbered steps, timings, or a materials-of-a-different-kind list. The point is the shift into concrete detail.

### 6 — The offer

Price, one variant selector if genuinely needed, one CTA, and a short reassurance line (shipping, returns, lead time).

The product should be present here too — a final clean shot, or the variant selector changing the shot. Don't drop to a bare pricing card; the object should be visible at the moment of decision.

### 7 — The close

Return to the register of the cold open. Product back in shadow or at distance, one line of type, the wordmark. It gives the page an ending rather than a stop.

The footer sits below this and can be entirely conventional — links at chrome size, no design ambition required. Trying to make the footer interesting undermines the close.

---

## 3. Category variants

**Apparel / accessories.** Anatomy chapters on construction details — stitching, lining, hardware, finish. In-the-world beat is worn, in motion. Spec is materials and provenance. Register tends dark and editorial.

**Food and drink.** Anatomy chapters become *process* stages — the sear, the cut, the rest. Motion and state change matter more than static detail; heat, pour, steam, and cut are the shots. Register tends warm, high-contrast, close-focus. Add a "where to get it" beat if it's retail rather than direct.

**Hardware / electronics.** Anatomy chapters on components and engineering. Exploded views work extremely well here. Spec block is long and should be. In-the-world is the device in a hand or on a desk. Register tends cold and technical.

**Furniture / interiors.** The chapters may be *rooms* or *views* rather than parts, with the counter reading `03 / 06`. Camera moves through the space. Register warm, natural light, long dissolves.

**Fragrance / spirits.** Almost no specification is possible, so lean into provenance and process — the ingredient, the still, the cellar, the years. Chapters are ingredients or stages. Most abstract of the variants; carry it on light and liquid.

**Software / SaaS.** The hardest to do in this format and the most valuable when it works, because every competitor is running a feature grid. The product is the interface: chapters become one genuine capability each, shown as a real screen recording scrubbed on scroll, not a floating mockup. Specification becomes integrations, limits, security posture, and performance numbers. In-the-world is a real workflow. Resist all pull toward the standard SaaS layout.

---

## 4. Compressing and extending

**Minimum viable score (four beats):** cold open → reveal → three anatomy chapters as one non-pinned sequence → offer. Works when assets are limited. Still needs the withheld cold open.

**Extending:** add a comparison beat (versus the previous generation, or versus the conventional alternative), a provenance beat (the maker, the place), or a customisation beat. Do not extend past about ten beats — the format's power partly comes from being short enough to finish.

**Never extend by adding conventional marketing sections.** A testimonial band inserted into this score is more damaging than an absent beat, because it breaks the register and reminds the user they're being sold to.

---

## 5. Two worked scores

### "The Anatomy of a Suit" — bespoke tailoring

| Beat | Title | Shot |
|---|---|---|
| 1 | *The Anatomy* of a Suit | Empty jacket form in a spotlight, dust in the beam, mostly dark |
| 2 | — | Full suit, front, floating, key light upper-left, reflection below |
| 3a | A Shirt of Pure Cotton | White shirt isolated, tight on the collar roll |
| 3b | Built on Full Canvas | Jacket opened, interior canvas visible |
| 3c | The Last Quarter-Inch | Extreme macro on the working cuff buttonhole |
| 4 | Made to Be Worn | Man adjusting the cuff, low light, motion blur |
| 5 | — | Spec block: cloth, canvas, buttons, lining, hours, origin |
| 6 | Tailoring for the Few | Suit at distance, gold-outlined "Book a Fitting" |
| 7 | — | Return to the empty form in shadow |

Register: night luxury. Ground `#0B0B0D`, gold accent, serif display with italic accents, 1.1s dissolves.

### "The Smash" — a burger

| Beat | Title | Shot |
|---|---|---|
| 1 | Smash // The Sear | Patty on the flat top, mostly dark, amber edge light, steam |
| 2 | — | Full burger, hero, backlit, sesame catching light |
| 3a | 01 — The Sear | Macro on the crust, 130°C label |
| 3b | 02 — The Cut | Cheese pull, mid-motion, spatula in frame |
| 3c | 03 — The Smash | Downward press, fat rendering, sparks of oil |
| 4 | — | Hands holding it, restaurant bokeh behind |
| 5 | — | Spec: beef blend, grind, dry-age days, bun, cheese |
| 6 | Build Your Own | Three items, prices, one "Order" CTA |
| 7 | — | Empty flat top, cooling |

Register: warm high-contrast. Ground `#0E0B09`, amber accent, condensed grotesque display, mechanical 400ms transitions, a scroll ruler along the bottom edge.

Both are seven beats, one subject, one accent, one CTA. That is the whole format.
