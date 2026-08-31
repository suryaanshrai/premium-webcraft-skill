# Implementation Review

`critique.md` audits the design. This audits the code.

The two failures are different and independent: a page can be beautifully art-directed and still have unlabelled icon buttons, a focus ring stripped with `outline: none`, and `transition: all` on every element. That page is not premium, because premium includes the parts you notice only when they're wrong.

Contents:
1. Fetch the canonical list first
2. The high-frequency failures
3. Typographic detail
4. Motion correctness
5. Forms
6. Performance
7. Output format
8. Where this overlaps the design critique

---

## 1. Fetch the canonical list first

Vercel maintains a living Web Interface Guidelines document that is the best available checklist of this kind. Before running a review, fetch the current version rather than relying on the summary below, which will drift:

```
https://raw.githubusercontent.com/vercel-labs/web-interface-guidelines/main/command.md
```

Human-readable version: `https://vercel.com/design/guidelines`

The rest of this file is a condensed adaptation weighted toward the failures that actually appear in cinematic, motion-heavy, art-directed pages — which is a narrower and different set than the ones that appear in dashboards. Treat the fetched document as the authority and this as the priority ordering.

---

## 2. The high-frequency failures

Ordered by how often they appear in pages built to this skill's brief.

**Focus rings destroyed.** `cursor: none` for a custom cursor, plus `outline: none` to tidy up the look, produces a page that is literally unusable by keyboard. This is the single most common accessibility failure in the premium-agency register, and it appears on real award-winning sites constantly. Use `:focus-visible` and give it a ring that suits the art direction — a hairline in the accent looks better than the browser default anyway.

**`<div onClick>` instead of `<button>`.** Common when building custom-styled interactive elements to escape the default button appearance. Use `<button>` and reset its styles; you get keyboard, focus, and semantics for free.

**Icon-only buttons with no `aria-label`.** The minimal nav, the close button on the menu, the scroll cue, the sound toggle. Every one of them needs a label.

**Decorative media not hidden.** The HUD, the grain overlay, the background canvas, the chapter counter — all decorative, all should be `aria-hidden="true"`. A screen reader reciting "01 / 05" on every scroll event is a real bug.

**Images without dimensions.** Guaranteed layout shift on a page whose whole effect depends on the first frame being composed. Set `width`/`height` or `aspect-ratio` on every image.

**Sticky elements covering focus.** A fixed HUD or nav that sits on top of a focused element. Keep focused elements scrolled clear.

**Hit targets under 24px.** The tiny chrome-sized links this aesthetic favours look right at 11px but must have their hit area expanded to at least 24px, and 44px on mobile.

**Zoom disabled.** `user-scalable=no` or `maximum-scale=1` in the viewport meta. Never.

**Paste blocked** on any input.

---

## 3. Typographic detail

These are small and they are exactly the kind of thing that separates a crafted page from a competent one. They cost minutes.

- **`…` not `...`** — a real ellipsis character, everywhere including loading states
- **Curly quotes** `"` `"` `'` `'`, never the straight typewriter forms
- **Non-breaking spaces** between numbers and units, in brand names, and in key combinations: `10&nbsp;MB`, `⌘&nbsp;K`
- **`font-variant-numeric: tabular-nums`** on anything in a column, a counter, or a price comparison — proportional figures in a spec table look broken
- **`text-wrap: balance`** on headings to prevent a single-word last line; `text-pretty` on body copy
- **Loading and progress strings end with `…`** — "Loading…", "Saving…"
- **Real dashes** — en dash for ranges, em dash for breaks, hyphen only for hyphenation
- **`Intl.DateTimeFormat` and `Intl.NumberFormat`** for any date, number, or currency rather than hardcoded formats
- **`translate="no"`** on brand names and code tokens so browser auto-translation doesn't garble them

On a page with a display headline at 140px, a widow or a straight apostrophe is enormous and unmissable. These details scale with the type.

---

## 4. Motion correctness

Beyond what `motion.md` covers aesthetically:

- **Never `transition: all`.** List the properties. `all` transitions things you didn't intend, including layout properties, and is a frequent source of jank.
- **`prefers-reduced-motion` must reach the end state.** The common bug: the media query disables the animation but leaves the element at `opacity: 0`, so content never appears. Test this by actually enabling the OS setting, not by reading the CSS.
- **Animations must be interruptible.** If a user scrolls back mid-reveal, the animation should respond, not finish stubbornly. `overwrite: "auto"` in GSAP.
- **`transform-origin` set explicitly** wherever you scale or rotate; the default is rarely what you want.
- **SVG transforms go on a `<g>` wrapper** with `transform-box: fill-box; transform-origin: center`.
- **Autoplaying motion over 5 seconds** alongside other content needs a pause control.
- **Decorative video loops must stop** under reduced motion, and need a still fallback.

---

## 5. Forms

Relevant to the enquiry form and the checkout handoff.

- Every input has a `<label>` or `aria-label`; labels are clickable
- Correct `type` and `inputmode` — `email`, `tel`, `url`
- `autocomplete` and a meaningful `name`
- `spellcheck={false}` on emails, codes, and usernames
- Submit stays enabled until the request starts, then shows a spinner
- Errors appear inline beside the field, and focus moves to the first error
- Placeholders show an example pattern and end with `…` — and are never a substitute for a label
- Warn before navigating away with unsaved input
- Checkbox and radio labels share one hit target with the control, with no dead zone

---

## 6. Performance

Beyond the animation performance rules in `motion.md`:

- `<link rel="preconnect">` for any asset or font CDN
- Critical fonts preloaded with `<link rel="preload" as="font">` and `font-display: swap`
- Above-fold hero image gets `fetchpriority="high"`; everything below gets `loading="lazy"`
- Compressed video instead of animated GIF, always, with a still alternative
- No layout reads (`getBoundingClientRect`, `offsetHeight`, `scrollTop`) during render; batch reads and writes
- Lists over 50 items virtualised — rare on this page type but relevant for a gallery
- `color-scheme: dark` on `<html>` for dark pages, so form controls and scrollbars match
- `<meta name="theme-color">` matching the ground

---

## 7. Output format

When reviewing, be terse. Group by file, use `file:line` so it's clickable, state the issue and skip the explanation unless the fix is non-obvious. No preamble.

```text
## src/Hero.tsx

src/Hero.tsx:34 - outline:none, no focus-visible replacement
src/Hero.tsx:51 - <div onClick> → <button>
src/Hero.tsx:88 - img missing width/height (CLS)

## src/Hud.tsx

src/Hud.tsx:12 - decorative counter needs aria-hidden
src/Hud.tsx:29 - "..." → "…"

## src/Chapter.tsx

✓ pass
```

Then fix them. A review that produces a list and stops has done half the job.

---

## 8. Where this overlaps the design critique

Run both, in this order: `critique.md` first, then this file.

The reason for that order is that design fixes often delete code — the subtraction pass removes whole sections — and there's no point auditing the accessibility of a component you're about to delete. Subtract, then verify what remains.

A page that passes this review and fails `critique.md` is competent and forgettable. A page that passes `critique.md` and fails this one is beautiful and broken. Premium requires both, and the second one is cheaper to get right.
