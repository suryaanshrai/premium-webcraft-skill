## What this changes

Rewrites `premium-webcraft` from a manifesto into a specification, and splits out a companion skill for single-product landing pages.

The two compose: `premium-webcraft` owns **how it looks and moves** (tokens, type, motion, restraint) and stays universal. `product-launch-page` owns **what happens and in what order** (beat sequence, product staging, chapter scroll, conversion). Precedence on conflict is explicit — art direction wins on visual values, the page score wins on sequence — and the product skill references tokens rather than introducing hex values.

## Why

The previous version was directionally right and operationally useless. "Double your whitespace", "break symmetry", "cinematic pacing" can't be executed deterministically, so the model applied the vocabulary and produced the same density as before.

Two root causes of "works but isn't clean":

1. **Drift.** Every section re-improvised its own type sizes, spacing, and greys. No single choice was wrong; the accumulation read as amateur.
2. **Density.** Reference-tier pages are overwhelmingly empty. Nothing in the skill budgeted subtraction.

## Main additions

**The art-direction lock** — `design/art-direction.md` + `design/tokens.css` written to disk *before* any markup. Five colours, two typefaces, one motion curve, three vertical rulers. Eliminates the drift class entirely.

**Vertical rulers** — premium pages align nearly all text to two or three fixed x-positions, held site-wide. Invisible, decisive, and completely absent before. Random asymmetry reads as sloppiness; systematic asymmetry reads as design.

**Numeric restraint budgets** — ≤3 text objects per viewport, ≤12% ink coverage, 5 colours total, accent under 5%, ≤2 simultaneous animations, 50–62ch measure.

**The 6:1 display-to-body ratio rule** — generic pages run ~3:1; the reference tier runs 7:1 or higher. One checkable number, large effect.

**Two gates instead of none** — `critique.md` (named AI-trope catalogue + scored rubric) for design, `implementation-review.md` (adapted from Vercel's Web Interface Guidelines) for code craft. Run in that order, since design fixes delete code.

**`verify.md` — actually render the page.** The biggest gap: the skill said "judge the frozen frame" with no mechanism. Now a Playwright loop — render at 1440/2560/390, capture at each section boundary, collect `pageerror` and `requestfailed`, check horizontal overflow, test `prefers-reduced-motion` and keyboard focus. Motion-heavy pages fail silently: a thrown error in one ScrollTrigger callback kills that trigger and leaves everything else working.

**`reference-extraction.md` — never start from a blank canvas.** Derive the lock from a live site, a screenshot, or a `DESIGN.md`. Includes the trap: most published `DESIGN.md` files come from SaaS systems tuned for density, so a straight port yields a competent, consistent, entirely generic page. Specifies the four moves that convert one.

## Notable removal

**WebGL is demoted and gated.** It was framed as the path to top tier. But the cleanest reference pages aren't shader-heavy — they're one object, vast emptiness, tiny type, immaculate alignment. Leading with WebGL pushes toward complexity, and complexity is what makes generated output look messy. Now gated, with the honest note that a scrubbed pre-rendered frame sequence usually looks better anyway.

The URL-only reference list is also gone. A list of links the model can't open at build time is decoration; the patterns are now extracted inline.

## Files

```
premium-webcraft/
  SKILL.md
  references/  art-direction · reference-extraction · motion · webgl
               verify · critique · implementation-review · workflow

product-launch-page/
  SKILL.md
  references/  page-score · product-staging · chapter-scroll · conversion
```

## Credit

`implementation-review.md` is adapted from [Vercel's Web Interface Guidelines](https://vercel.com/design/guidelines) and instructs fetching the canonical list fresh rather than trusting a frozen copy. `reference-extraction.md` interoperates with the `DESIGN.md` format popularised by [awesome-design-md](https://github.com/VoltAgent/awesome-design-md).
