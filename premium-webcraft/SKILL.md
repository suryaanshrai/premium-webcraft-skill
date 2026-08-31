---
name: premium-webcraft
description: Art-direction and craft system for building genuinely premium, Awwwards-tier web front ends — locked design tokens, editorial typography, restraint budgets, motion physics, scroll choreography, and an optional WebGL tier. Use this whenever building, redesigning, or reviewing any website, landing page, portfolio, marketing site, hero section, or web UI where visual quality matters — including when the user says "make it look premium / high-end / expensive / not AI-generated / like a real agency built it", when they share reference sites and want that level, or when reviewing existing front-end work for design quality. Also use as the shared visual foundation underneath companion skills such as product-launch-page.
---

# Premium Webcraft

The gap between an "AI-looking" site and an agency site is almost never ambition. It's **consistency and subtraction**. AI-built pages fail because every section re-improvises its own type sizes, spacing, and colours, and because they put too much in the frame. Agency pages look expensive because five decisions were made once and then obeyed everywhere, and because 80% of every screen is empty.

This skill exists to force those two things: **lock the decisions, then remove everything that isn't carrying weight.**

## The thesis: one anchor, everything else quiet

A premium page has exactly **one** signature element — the thing someone would describe to a friend. A rotating product. A massive kinetic wordmark. A fluid canvas. A single cinematic photograph that fills the screen.

Everything else on the page defers to it. Not "also impressive" — *quiet*. Small type, wide margins, no competing motion.

The most common failure is two or three anchors fighting. A 3D hero, plus animated gradient cards, plus a marquee, plus a bento grid. Each is fine alone. Together they read as a demo reel, and demo reels look cheap. **If you catch yourself adding a second impressive thing, that's the signal to delete it, not to add a third.**

## Phase 0 — Lock the art direction before writing any markup

Do this first, always. It is the single highest-leverage step and skipping it is why pages drift.

Interrogate the brand briefly — what it sells, who it's for, the one emotion it should provoke, what it must *not* feel like. Three or four questions, no more. Do not ask the user about colours, fonts, or layouts; that's your job and asking hands the aesthetic back to a non-designer.

Then write **`design/art-direction.md`** and **`design/tokens.css`** to disk before any component exists. These are the contract every later decision is checked against. Read `references/art-direction.md` for the exact template, the ratio rules, and worked palette/type examples.

**Don't start from a blank canvas if you don't have to.** Asked to invent a palette and type system from nothing, the reliable output is the median of everything — which is the generic register. If the user has a reference site, a screenshot, a moodboard, or a `DESIGN.md`, derive the lock from it instead: read `references/reference-extraction.md`. That file also covers the important caveat that most published `DESIGN.md` files come from product and SaaS systems tuned for density, so their tokens need the scale and spacing pushed hard before they suit a landing page.

The lock contains, and only contains:

- **One ground colour**, plus two tints of it. Not black — `#0B0B0C`, `#0E0D0B`, `#12100E`. Not white — `#F4F1EA`, `#EDEAE3`.
- **One ink colour** and its two opacity steps (100% / 62% / 38%).
- **One accent.** One. It may appear on no more than ~5% of any screen.
- **Two typefaces maximum** — a display face with character, a neutral face for body and chrome. One is often better.
- **A type scale** with a display-to-body ratio of at least **6:1** on desktop.
- **A motion signature** — one entrance curve, one duration band, one stagger interval.
- **Two or three vertical rulers** — the x-positions every piece of text on the site is allowed to start from.

That last one deserves emphasis, because it is invisible and decisive.

### Vertical rulers are why clean pages look clean

Scan any of the reference-tier sites and you'll notice nearly all text begins at one of two or three horizontal positions, held down the entire page. Nothing is "roughly centred" or "wherever the flex put it."

Define your rulers as CSS custom properties and align to them absolutely:

```css
:root {
  --margin: clamp(1.5rem, 6vw, 7rem);  /* ruler A — page edge */
  --ruler-b: 38%;                       /* the off-centre column */
  --ruler-c: 62%;                       /* the counterweight */
}
```

Asymmetry earns its keep only when it's systematic. Random offsets read as sloppiness; a headline that sits at 38% on every single section reads as deliberate.

## Restraint budgets

These are the numbers that make the difference, and they're the ones models skip. Treat them as hard constraints and design within them.

| Budget | Limit | Why |
|---|---|---|
| Text objects per viewport | **≤ 3** in hero and narrative sections | One idea per screen. A headline, a supporting line, a label. That's the whole frame. |
| Screen area covered by text/UI | **≤ 12%** in hero and narrative sections | The reference pages are overwhelmingly empty. Emptiness is the luxury signal. |
| Total colour values | **5** (ground + 2 tints + ink + accent) | Every extra colour is a decision that will be made inconsistently. |
| Accent coverage | **< 5%** of any screen | Accent works by scarcity. Used broadly it becomes the ground. |
| Simultaneous animations in view | **≤ 2** | Three moving things read as a slideshow template. |
| Z-layers in the hero | **≤ 4** | More than four and the composition muddies. |
| Body measure | **50–62ch** | Full-width paragraphs are the fastest tell of a generic page. |
| Nav items | **≤ 5** | Long navs force small type and crowd the top edge. |

If content won't fit the budget, the answer is to cut content or add a section — never to shrink the type and tighten the gaps. Shrinking is how a page becomes dense, and density is the thing that reads as cheap.

## Typography

Typography carries premium pages more than any other single factor. Read `references/art-direction.md` for the full scale and pairing guidance; the essentials:

- **Push the display size much further than feels comfortable.** `clamp(3.5rem, 9vw, 11rem)`. If the largest thing on your page is 48px, the page is a document, not an experience.
- **Tighten as you grow.** Display tracking `-0.03em` to `-0.045em`, line-height `0.92`–`1.0`. Loose tracking on large type is the single most common amateur signal.
- **Chrome type goes the other way.** Labels, indices, eyebrows: 10–11px, uppercase, tracking `0.16em`, opacity `0.5–0.65`. These tiny elements do enormous work — see the HUD pattern below.
- **Mix roman and italic inside one headline.** "The Anatomy *of a Suit*." A single italic word in a serif display line is one of the cheapest, most effective editorial moves available.
- **Ship real fonts.** System-sans everywhere is the visual equivalent of a default template. Self-host, subset, and preload; `font-display: swap` with a metric-matched fallback so the layout doesn't jump.

## The HUD layer

Premium pages carry a thin skin of near-invisible structural type: a chapter counter in a corner (`04 / 06`), a section eyebrow (`[ 01 — THE STORY ]`), a credit line, a hairline progress rule, a small coordinate or timestamp.

None of it is functionally necessary. All of it signals that someone deliberate was here. It is cheap to build and disproportionate in effect.

Rules: fix it to the viewport corners, keep it under 11px, keep opacity under 0.65, never let it collide with content, and hide it on mobile if space is tight.

## Motion

Motion is where "almost premium" usually dies — usually from too much of it, at the wrong speed, on the wrong curve. Read `references/motion.md` for the full recipe library, Lenis and ScrollTrigger setup, and the interaction layer (custom cursor, magnetic hovers, link states).

The non-negotiables:

- **One entrance curve for the whole site.** `cubic-bezier(0.16, 1, 0.3, 1)` is a reliable default — fast out, long settle, reads as physical weight.
- **Entrances 0.8–1.2s. UI feedback 0.25–0.4s.** Anything shorter than ~0.6s on an entrance feels like a page load, not a reveal.
- **Never fade opacity alone.** Always pair with a 16–40px translate or a `clip-path` unmask. A pure fade is the default AI reveal and it looks like nothing happened.
- **Stagger 60–90ms** between sibling elements, 40–60ms between text lines.
- **Animate `transform` and `opacity` only.** Anything else drops frames and the illusion collapses.
- **Respect `prefers-reduced-motion`** — collapse to instant states, don't just shorten durations.

## The 3D / WebGL tier — gated on purpose

WebGL is a multiplier on an already-good page, not a substitute for one. A shader on a badly-typeset layout looks worse than no shader, because it draws attention to the layout.

Before reaching for Three.js, answer: *does the anchor require real geometry, real depth, or real-time response to the pointer?* If a video loop, a sequence of pre-rendered frames, or a well-lit still would produce the same feeling, use that instead — it will look better, load faster, and never jank.

When it does earn its place, read `references/webgl.md` for the integration, scroll-sync, and performance patterns.

## Look at what you built

The largest quality gap in agent-built front ends is that the agent never sees the page. Code that compiles is not a page that renders — the display font may have silently fallen back, a pinned section may overlap the next one, a thrown error in one scroll callback may have quietly killed a chapter's animation.

Open it. Screenshot it at 1440, 2560, and 390. Read the console. Then **look at the screenshots** rather than reasoning about the markup. `references/verify.md` has the Playwright setup, the state-by-state checklist, and what to look for in each frame.

If no browser is available, say so plainly and give the user a short list of things to check. Never describe a rendered result you haven't seen.

## The two gates

A page fails in two independent ways, and both need checking.

**The design gate** — `references/critique.md`. The named-trope catalogue (the specific things that make output read as AI-generated) and a scored rubric.

**The implementation gate** — `references/implementation-review.md`. Focus rings, hit targets, semantics, form behaviour, typographic detail, `transition: all`. Adapted from Vercel's Web Interface Guidelines, with a pointer to fetch the current canonical version.

Run them in that order, because design fixes delete code and there's no sense auditing a component you're about to remove. A page that passes only the design gate is beautiful and broken; one that passes only the implementation gate is competent and forgettable.

## The subtraction pass — do not skip this

The core of the design gate is one question, asked section by section: **what can be removed without losing meaning?** Then remove it. Expect to delete 20–30% of what you built. Pages get cleaner by subtraction and essentially never by addition.

Specifically hunt for: a second accent colour that crept in, a section that restates the one above it, decorative gradient blobs, cards that exist only because the content was listy, an animation nobody asked for, and any text object beyond the third in a viewport.

## Operating modes

**Create.** Interrogate briefly (or extract from a reference) → write the art-direction lock → build the static page to spec with zero motion → render it and look at it → layer motion → add the single anchor → subtraction pass → implementation review → render and look again.

Build it beautiful *before* animating. Motion on a mediocre layout produces a mediocre layout that moves. If the still screenshot isn't impressive, no amount of GSAP will save it.

**Revamp.** Render the existing site and audit it against `references/critique.md` and `references/implementation-review.md` first, then report the diagnosis with specifics. Then decide honestly: if the existing code has centred hero + feature-card grid + generic sans, refactoring is slower than rewriting, because you'd be dismantling every structural decision. Say so plainly rather than quietly rebuilding.

Follow `references/workflow.md` for stack choices and the phase-by-phase build order.

## Working alongside companion skills

This skill owns **how it looks and how it moves** — tokens, type, motion, restraint. It is the visual source of truth.

Companion skills own **what happens and in what order** — page structure, narrative sequence, domain conventions. `product-launch-page` is one of these, covering single-product commerce pages.

When one is active alongside this skill:

1. This skill runs Phase 0 first and produces `design/art-direction.md` + `design/tokens.css`.
2. The companion skill reads those and produces its own structural artifact (for `product-launch-page`, that's `design/page-score.md`).
3. **Precedence on conflict:** art direction wins on any visual or motion value; the companion wins on structure, sequence, and domain-specific requirements.
4. Neither redefines the other's territory. If the companion needs a colour, it references a token — it does not introduce a hex value.

This is what keeps a combined build coherent rather than two aesthetics stapled together.

## Reference files

- `references/art-direction.md` — the lock template, palette and type systems, grid and rulers, worked examples
- `references/reference-extraction.md` — deriving the lock from a site, image, or `DESIGN.md` instead of a blank canvas
- `references/motion.md` — curve library, scroll choreography, Lenis/GSAP setup, the interaction layer
- `references/webgl.md` — when 3D earns its place, integration and performance patterns
- `references/verify.md` — the browser loop: render, screenshot, read the console, look
- `references/critique.md` — the AI-trope catalogue and the scored subtraction gate
- `references/implementation-review.md` — code-craft audit: a11y, focus, forms, typographic detail
- `references/workflow.md` — stack, build order, asset pipeline, delivery checklist
