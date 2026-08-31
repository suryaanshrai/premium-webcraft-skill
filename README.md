# Premium Webcraft — two paired skills

Two skills that specialise in different halves of a premium front end and are designed to compose without stepping on each other.

```
premium-webcraft/          # how it looks and how it moves — universal
├── SKILL.md
└── references/
    ├── art-direction.md   # the lock, palettes, type system, grid, rulers
    ├── motion.md          # curves, reveals, Lenis/ScrollTrigger, interaction layer
    ├── webgl.md           # the gated 3D tier
    ├── critique.md        # AI-trope catalogue + scored subtraction gate
    └── workflow.md        # stack, build order, assets, delivery

product-launch-page/       # what happens and in what order — single-product pages
├── SKILL.md
└── references/
    ├── page-score.md      # the beat structure, category variants, worked scores
    ├── product-staging.md # shot list, lighting, generating a consistent image set
    ├── chapter-scroll.md  # pinned chapters, transitions, HUD
    └── conversion.md      # price, variants, CTA in the premium register
```

## How they divide

| | premium-webcraft | product-launch-page |
|---|---|---|
| Owns | Tokens, palette, type, motion curves, restraint budgets, critique | Beat sequence, product staging, chapter scroll, conversion |
| Scope | Any site | One product, one page |
| Artifact | `design/art-direction.md` + `design/tokens.css` | `design/page-score.md` |
| Runs | First, always | After the lock exists |

**Precedence on conflict:** art direction wins on any visual or motion value. The page score wins on structure, sequence, and domain requirements. Neither redefines the other's territory — the product skill references tokens, it never introduces a hex value.

Used together on a product launch: `premium-webcraft` runs Phase 0 and produces the lock, `product-launch-page` writes the score against it, and the build follows the score using the lock's tokens throughout. Used alone, each still works — `premium-webcraft` on any site, `product-launch-page` with a minimal inline lock.

## What changed in premium-webcraft, and why

The previous version read as a manifesto. "Double your whitespace", "break symmetry", "cinematic pacing" are directionally right and operationally useless — a model applies the vocabulary and produces the same output. The revision replaces exhortation with specification.

**Added: the art-direction lock as a required first artifact.** The single biggest cause of pages that "work but aren't clean" is drift — section three inventing its own heading size, section six its own grey. Writing five colours, two typefaces, one motion curve, and three vertical rulers to disk *before* any markup exists eliminates the whole failure class.

**Added: vertical rulers.** Premium pages align nearly all text to two or three fixed x-positions. This is invisible, decisive, and was completely absent before. Random asymmetry reads as sloppiness; systematic asymmetry reads as design.

**Added: numeric restraint budgets.** Max 3 text objects per viewport, ≤12% screen coverage, 5 colours total, accent under 5%, ≤2 simultaneous animations, 50–62ch measure. Cleanliness is a density problem and density is measurable, so it's specified rather than gestured at.

**Added: the 6:1 display-to-body ratio rule.** A generic page runs ~3:1. The reference tier runs 7:1 or higher. One checkable number, very large effect.

**Added: the subtraction pass and a scored rubric,** including a named catalogue of AI-generated tropes. "Make it less generic" is unactionable; "you have a three-column feature grid with icon circles" gets fixed in five minutes.

**Demoted: WebGL.** It was framed as the thing that gets you to the top tier. But the cleanest pages in the reference set aren't shader-heavy — they're one object, vast emptiness, tiny type, immaculate alignment. Leading with WebGL pushes toward complexity, and complexity is what makes generated output look messy. It's now a gated section with the honest note that a scrubbed pre-rendered frame sequence usually looks better anyway.

**Replaced: the URL reference list.** A list of links a model can't open at build time is decoration. The patterns are now extracted inline — the HUD layer, the isolated lit subject, the italic swap, radial light falloff instead of 45° gradients, grain.

**Added: build-it-frozen-first.** Screenshot the static page with JS disabled and judge that image before adding motion. Motion on a mediocre layout produces a mediocre layout that moves.

## Three more additions

**`reference-extraction.md` — never start from a blank canvas.** Asked to invent a palette and type system from nothing, the reliable output is the median of everything, which is the generic register. This adds paths for deriving the lock from a live site (weighted by painted area, not element count), a screenshot, or a `DESIGN.md`. It also handles the trap: most published `DESIGN.md` files come from product systems tuned for density, so a straight port gives you a competent, consistent, entirely generic marketing page. The file specifies the four moves that convert one — double the display scale, viewport-based section rhythm, delete the card, demote the accent. The lock now also *emits* a `DESIGN.md` so the system survives into other sessions and other agents.

**`implementation-review.md` — the second gate.** `critique.md` audits design; nothing audited code. A page can be beautifully art-directed and still strip its focus rings, ship `<div onClick>`, and run `transition: all`. Adapted from Vercel's Web Interface Guidelines, weighted toward the failures specific to this register — the `cursor: none` plus `outline: none` combination that makes award-winning sites keyboard-unusable is the standout. It instructs fetching the canonical list fresh rather than trusting a frozen copy. The typographic details from it (`…` not `...`, curly quotes, `tabular-nums`, `text-wrap: balance`) also went into `art-direction.md`, because at 140px a straight apostrophe is enormous.

**`verify.md` — actually look at the page.** The biggest gap in the first draft: it said "screenshot it and judge the frozen frame" with no mechanism. Now there's a Playwright loop — render at 1440/2560/390, capture at each section boundary, collect `pageerror` and `requestfailed`, check horizontal overflow, test `prefers-reduced-motion` and keyboard focus. Motion-heavy pages fail silently: a thrown error in one ScrollTrigger callback kills that trigger and leaves everything else working, so the symptom is one chapter that doesn't animate. The file is also explicit that when no browser is available, the correct move is to say so and give the user a checklist — never to describe a rendered result you haven't seen.

## Installing

Drop either directory into your skills location — `~/.claude/skills/` for Claude Code, or upload the `.skill` bundle in the Claude app. Both are self-contained.
