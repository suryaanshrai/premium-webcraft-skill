# Build Workflow

Contents:
1. Stack
2. Build order
3. Assets
4. Content
5. Responsive
6. Delivery checklist

---

## 1. Stack

Framework-agnostic, but the combinations that hold up:

| Layer | Choice | Note |
|---|---|---|
| Framework | Next.js (App Router), Astro, or Vite + React | Astro is excellent for marketing pages — ships almost no JS by default |
| Styling | CSS Modules or plain CSS with custom properties | See the caution below on Tailwind |
| Animation | GSAP + ScrollTrigger | The scroll work is not realistically replaceable |
| Smooth scroll | Lenis | |
| 3D | Three.js, or React Three Fiber + drei in React | Only if the gate in `webgl.md` passes |
| Fonts | Self-hosted, subset, preloaded | Never a render-blocking third-party stylesheet |

**On Tailwind.** It's fine for layout, and actively unhelpful for this kind of work if used as the design system. The default scale — `text-4xl`, `gap-8`, `rounded-lg`, `slate-800` — is precisely the medium-everything register premium pages avoid, and utility soup makes it easy to lose track of which values are actually in use.

If using Tailwind, drive it from your tokens:

```js
theme: {
  colors: { ground: "var(--ground)", ink: "var(--ink)", accent: "var(--accent)" },
  fontSize: { display: "var(--t-display)", chrome: "var(--t-chrome)" }
}
```

Then the design system remains the source of truth and Tailwind is just shorthand.

**Single-file HTML** is a legitimate deliverable for a landing page — one `.html` with inline `<style>` and CDN GSAP/Lenis. Nothing about premium quality requires a build step, and for a one-page site it removes a lot of friction.

---

## 2. Build order

The order matters more than people expect, because motion applied to a weak layout produces a weak layout that moves.

**Phase 0 — Lock.** Write `design/art-direction.md` and `design/tokens.css`. Nothing else until these exist.

**Phase 1 — Skeleton, no motion.** Build the full static page with real content and real assets. No animation, no scroll effects, no 3D. Then **screenshot it and judge that image**. If the frozen page isn't impressive, stop and fix it here. Everything downstream amplifies whatever this phase produces, including its flaws.

**Phase 2 — Rhythm.** Walk the page at full height. Check section pacing, that all text sits on the rulers, that density alternates, that no viewport exceeds three text objects. Adjust spacing at the token level, not per-section.

**Phase 3 — Motion.** Lenis first, then entrance reveals using the single chosen gesture, then scroll choreography for the two or three sections that warrant it. Add the HUD and sync it.

**Phase 4 — The anchor.** Build the one signature element. This is the phase to spend disproportionate time on; it's what the page is remembered for.

**Phase 5 — Preloader and transitions.** Now that asset weight is known.

**Phase 6 — Subtraction.** Run `critique.md`. Delete.

**Phase 7 — Responsive, performance, accessibility.**

---

## 3. Assets

Asset quality caps page quality. A perfectly executed layout around a mediocre stock photo is a mediocre page.

**Images.** AVIF with WebP fallback. `srcset` at 640/1024/1600/2400. `loading="lazy"` on everything below the fold, and explicitly `loading="eager"` plus `fetchpriority="high"` on the hero. Always set `width`/`height` or `aspect-ratio` to prevent layout shift.

**Colour-grade everything.** A set of images from different sources will have different casts and contrast, and that inconsistency reads as unprofessional even when nobody can name why. Push them all toward the same grade — usually slightly desaturated with a cast matching the accent.

**Video.** Hero loops should be under ~3MB. Encode WebM (VP9) plus MP4 (H.264). `muted playsinline loop autoplay` and a `poster` that matches frame one. Provide a static image on mobile.

**Fonts.** Subset to the characters actually used — a full weight is often 100KB+, a Latin subset 20KB. `woff2` only. Preload the display face. Define `size-adjust` on the fallback so the layout doesn't shift on swap.

**Generated imagery.** Acceptable and often the right call, but be specific in prompts about the lighting setup and the background, because the giveaway is inconsistency: prompt for the same key-light direction, the same lens, and the same background treatment across the whole set. Then grade them together. Never mix generated imagery with real photography of the same subject on one page — the mismatch is immediately visible.

---

## 4. Content

Copy is part of the design and generic copy will sink a good layout.

- **Headlines: 3–7 words.** If it needs a comma, it's two headlines.
- **Say the specific thing.** "Hand-stitched in Northampton over eleven days" beats "Premium craftsmanship" — a concrete detail is more persuasive than a category claim, and it's also more interesting to typeset.
- **Ban the category phrases**: "Everything you need", "Supercharge", "The future of", "Built for modern teams", "Seamlessly".
- **Never invent proof.** No fabricated testimonials, fake logo walls, or invented statistics. Use placeholders that are visibly placeholders (`[CLIENT LOGO]`) so nobody ships fiction by accident.
- **Write the microcopy too** — button labels, chapter names, the HUD strings. `[ 03 — THE SMASH ]` is doing real work and takes ten seconds to write well.

---

## 5. Responsive

Design the desktop composition first for this kind of page — the whole point is the wide, empty, asymmetric frame, and it can't be derived from a mobile stack. But mobile is likely most of the traffic, so it needs a real design, not a squeeze.

**Reduce, don't compress.** On mobile: fewer sections, less HUD, no custom cursor (no pointer), no magnetic hover, simplified or removed 3D, and pinned sections converted to normal flow. What survives is type and image — which is why those two must be excellent.

Type: display drops but stays large — `clamp()` floors around `2.5rem`–`3rem`. Margins go to `1.25rem`. Rulers collapse to left-align.

Test at 375px, 768px, 1280px, 1920px, and 2560px. The 2560px case is the one that gets skipped and where unbounded layouts fall apart.

---

## 6. Delivery checklist

- [ ] `art-direction.md` and `tokens.css` committed and actually obeyed — grep for stray hex values
- [ ] Frozen screenshot is impressive with JS disabled
- [ ] Lighthouse: performance > 85 with the hero media loaded
- [ ] No layout shift (CLS < 0.1) — check fonts and hero image specifically
- [ ] 60fps while scrolling on a mid-range laptop
- [ ] `prefers-reduced-motion` reaches every end state, nothing stuck at `opacity: 0`
- [ ] Keyboard navigable with a visible focus ring
- [ ] Real `<title>`, meta description, OG image
- [ ] Tested at 375 / 768 / 1280 / 1920 / 2560
- [ ] Critique rubric scored ≥ 30/45
- [ ] Subtraction pass actually removed something
