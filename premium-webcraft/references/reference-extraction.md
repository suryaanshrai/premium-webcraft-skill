# Starting From a Reference

The blank canvas is where generated design goes wrong. Asked to invent a palette and a type system from nothing, a model reaches for the median of everything it has seen — which is precisely the generic register. Starting from a real, specific reference and extracting its system produces better results with less effort.

This is a path *into* Phase 0, not a replacement for it. The output is still `design/art-direction.md` and `design/tokens.css`.

Contents:
1. Which path to take
2. Extracting from a live site
3. Extracting from an image
4. Consuming a DESIGN.md
5. Elevating a product design system into the premium register
6. Emitting a DESIGN.md
7. The line on imitation

---

## 1. Which path to take

| The user gives you | Path |
|---|---|
| A URL they want the feel of | §2 — extract from the live site |
| A screenshot, moodboard, or Figma frame | §3 — extract from the image |
| A `DESIGN.md` file | §4 — consume it, then §5 |
| A brand name ("like Linear", "like Apple") | Check for a published `DESIGN.md`; otherwise §3 from screenshots |
| Nothing but a brief | Normal Phase 0 — but propose two or three named registers so the direction is still specific |

Even in the last case, resist inventing in the abstract. Naming a register ("1970s technical manual", "auction-house catalogue") does most of what a reference does.

---

## 2. Extracting from a live site

If you have browser access, the fastest route is to read the computed styles rather than eyeball the screenshot.

```js
// run in the page context
const seen = new Map();
document.querySelectorAll("*").forEach(el => {
  const s = getComputedStyle(el);
  const r = el.getBoundingClientRect();
  if (r.width * r.height < 400) return;
  [["bg", s.backgroundColor], ["fg", s.color]].forEach(([k, v]) => {
    if (!v || v.includes("rgba(0, 0, 0, 0)")) return;
    const key = k + "|" + v;
    seen.set(key, (seen.get(key) || 0) + r.width * r.height);
  });
});
[...seen].sort((a, b) => b[1] - a[1]).slice(0, 12).forEach(([k, a]) =>
  console.log(k, Math.round(a)));
```

Weighting by **painted area** rather than by element count is the important part — it tells you what the ground actually is, rather than which colour appears on the most buttons.

Do the same for typography: collect `fontFamily`, `fontSize`, `fontWeight`, `letterSpacing`, and `lineHeight` for the largest text node and for body copy, then compute the display:body ratio.

Also record:
- **Outer margin** at 1440px (the `padding-left` of the main container)
- **Max content width**
- **Border radii** in use — count distinct values
- **Transition durations and timing functions** — grep the stylesheets
- **Whether text aligns to consistent x-positions** (your rulers)

Then compress what you found into five colours and two typefaces. A real site may use eleven greys; your lock uses three. The extraction is a source, not a spec.

---

## 3. Extracting from an image

Without browser access, read the screenshot carefully and deliberately:

1. **Sample the ground** from a large empty area, not from an edge or a shadow.
2. **Sample the ink** from the body of a letterform, not its antialiased edge.
3. **Find the accent** — the colour appearing on the smallest total area but on an interactive element.
4. **Estimate the ratio.** Measure the display cap-height against the body cap-height in pixels. That's your display:body ratio, and it's the number most worth carrying over.
5. **Identify the light source** — where highlights sit and which way shadows fall.
6. **Classify the typefaces** by category and characteristics (serif/grotesque/geometric, contrast, x-height, terminal shape), then pick an available face that matches the *category and feel*, not the exact letterforms.
7. **Measure the emptiness.** Roughly what percentage of the frame is content? This is usually the single biggest thing to carry over, and the easiest to lose.

Write these into `art-direction.md` as findings before converting them into tokens.

---

## 4. Consuming a DESIGN.md

`DESIGN.md` is a plain-markdown design-system format (introduced by Google Stitch, popularised by the `awesome-design-md` collection) that AI agents read to generate consistent UI. Files typically carry nine sections: theme, colours, typography, components, layout, elevation, do's and don'ts, responsive behaviour, and an agent prompt guide.

If the user supplies one, treat it as **authoritative for the token layer** and map it straight into `tokens.css`:

| DESIGN.md section | Maps to |
|---|---|
| Colors | `--ground`, `--ground-1/2`, `--ink`, `--accent` (compress to five) |
| Typography | `--font-display`, `--font-ui`, the `--t-*` scale |
| Layout | `--margin`, `--maxw`, grid |
| Elevation | shadow and hairline tokens |
| Do's and don'ts | Carry verbatim into `art-direction.md` — these are real constraints |
| Components | Reference when building; don't restate |

Then read §5, because a DESIGN.md gives you consistency but not art direction.

---

## 5. Elevating a product design system into the premium register

This is the part that matters and the part that gets skipped.

Most published DESIGN.md files are extracted from **product and SaaS sites** — Vercel, Linear, Stripe, Figma. Those are excellent design systems for *applications*. They are tuned for density, scanability, and repeated daily use. That is close to the opposite of what a cinematic landing page needs.

Drop one in unmodified and you'll get a competent, consistent, entirely generic marketing page — which is exactly the failure mode this skill exists to prevent.

So: **take the token layer, then apply this skill's rules on top of it.**

| Keep from the DESIGN.md | Override with this skill |
|---|---|
| Palette hues and their relationships | Compress to 5 values; accent under 5% coverage |
| Typeface choices | Push the display size until the ratio is ≥ 6:1 |
| Spacing base unit | Section rhythm in `vh`, not the system's fixed px |
| Component structure for real UI (forms, inputs) | Don't use its card/grid patterns for narrative sections |
| Do's and don'ts | Add the restraint budgets and the vertical rulers |
| Elevation scale | Prefer light-source shadows and contact shadows over uniform elevation steps |

Concretely, the four moves that convert a product system into a page system:

1. **Multiply the display size by two or three.** Product systems cap around 48–60px because a heading in an app must not dominate. A page's display type *should* dominate.
2. **Multiply the section spacing.** Replace `padding: 80px 0` with `clamp(6rem, 16vh, 14rem)`.
3. **Delete the card.** Whatever the system's card component is, do not use it for narrative content. Group with alignment and space instead.
4. **Cut the palette down and demote the accent.** Product systems use the brand colour liberally because it's a UI affordance. On a page it's a scarce signal.

Say this out loud to the user if they supplied the DESIGN.md, because they may expect a literal match and get something better. Frame it as: "I'll use their tokens as the foundation and push the scale and spacing into landing-page territory — a straight port would give you their app's register, not their marketing register."

---

## 6. Emitting a DESIGN.md

Alongside `art-direction.md` and `tokens.css`, write a `DESIGN.md` at the project root. It costs nothing, and it means any other agent touching the project — or the user's next session — picks up the same system without re-deriving it.

Follow the nine-section shape so it's interoperable:

```markdown
# DESIGN.md — [Project]

## Theme
[One paragraph: the register, the anchor, and the anti-brief.]

## Colors
| Token | Value | Use |
|---|---|---|
| ground | #0B0C0E | Page background, 85%+ of surface |
| ground-1 | #131519 | Raised surfaces |
| ground-2 | #1D2026 | Hairlines, dividers |
| ink | #EDEDEF | Primary text; 62% secondary, 38% chrome |
| accent | #C9A227 | CTA and active state only — under 5% of any screen |

## Typography
Display: [family], clamp(3.5rem, 9vw, 11rem), -0.035em, 0.94
Body: [family], 1rem, 1.65, max 62ch
Chrome: 11px, uppercase, 0.16em, 62% ink
Display:body ratio at 1440px — 8:1

## Layout
Outer margin: clamp(1.5rem, 6vw, 7rem) · Max width: 1600px
Rulers: A (margin), B (38%), C (62%) — all text starts at one of these
Section rhythm: clamp(6rem, 16vh, 14rem)

## Elevation
Hairline: 1px ink @ 10% · Contact shadow: 0 24px 40px rgb(0 0 0 / .55)
Light source: upper-left, 40° — all shadows fall lower-right

## Components
[Only the ones that exist. Buttons, links, nav, HUD.]

## Motion
Entrance: cubic-bezier(.16,1,.3,1), 900ms, 75ms stagger
The one gesture: [e.g. clip-path unmask upward]
UI: 300ms cubic-bezier(.4,0,.2,1)

## Do's and Don'ts
- Max 3 text objects per viewport
- Never fade opacity without a translate or mask
- No cards in narrative sections
- No second accent
- [project-specific rules]

## Responsive
[Breakpoint behaviour; what gets removed rather than shrunk.]

## Agent prompt guide
Read this file before generating any UI. Use tokens by name, never raw
hex. If a value you need isn't here, add it here first, then use it.
```

That last line is the one that keeps the system from drifting across sessions.

---

## 7. The line on imitation

Extracting a design system from a public site to learn its structure is normal practice and how designers have always worked. Reproducing a site is not.

Take the *system* — the ratios, the palette relationships, the spacing logic, the restraint. Don't take the layout, the copy, the imagery, or the wordmark. If the output would be recognisable as a specific company's page with the logo swapped, you've gone too far — say so and pull it back.

Logos, brand names, and proprietary typefaces stay with their owners. If a reference uses a licensed face, substitute one with similar characteristics and note the substitution rather than quietly linking their font CDN.
