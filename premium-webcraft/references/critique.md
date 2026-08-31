# The Critique Gate

Run this after the page is built and before calling it done. Also run it first when auditing existing work.

Contents:
1. The named-trope catalogue
2. The subtraction pass
3. The scored rubric
4. Diagnosing "it's fine but not premium"

---

## 1. The named-trope catalogue

These are the specific, recognisable signatures of generated and templated web design. Naming them matters — "make it less generic" is unactionable, but "you have a three-column feature grid with icon circles" can be fixed in five minutes.

### Layout tropes

- **The centred stack.** H1, subtitle, two buttons side by side, all centre-aligned, dead centre of the hero. The single most common generated layout in existence.
- **The three-column feature grid.** Three cards, each with an icon in a circle, a short bold title, and two lines of grey text. Sometimes six in a 3×2. Always evenly spaced.
- **The bento grid** deployed without reason — a mosaic of unequal rounded rectangles because it looks modern, containing content that has no relationship to the shapes it's in.
- **Alternating image-left / image-right** rows down the whole page, at identical spacing, forever.
- **Everything in a card.** Content boxed in rounded rectangles with subtle shadows because boxing is the default way to group things. Premium pages group with whitespace and alignment instead.
- **Even spacing throughout.** Every section 96px apart. No pacing, no breathing sections, no density contrast.
- **Full-width body text** spanning 1400px, ~180 characters per line.

### Colour and surface tropes

- **The 45° purple-to-blue gradient.** Instantly recognisable. So is its cousin, the pink-to-orange.
- **Pure `#000000` or `#FFFFFF`** grounds.
- **Floating gradient blobs** in the background at 20% opacity, blurred, usually two or three, usually purple.
- **The glassmorphism card** — `backdrop-filter: blur()` with a white 10% overlay and a 1px white 20% border. Was distinctive in 2021.
- **Uniform 8px or 12px border radius** on everything.
- **Four different greys** doing similar jobs, none of them from a defined scale.

### Typography tropes

- **Inter (or system-ui) at every size,** with weight as the only variation.
- **Display type at 48px** — technically a heading, functionally a document title.
- **Loose tracking on large headlines.** Default tracking at 96px looks like a spreadsheet cell.
- **`text-align: center` on paragraphs** longer than one line.
- **Gradient-filled headline text** with `background-clip: text`.
- **Emoji as icons** in a professional context.

### Content tropes

- **"Everything you need to X."** Also "Supercharge your Y", "Built for the modern Z", "The future of W".
- **Feature names that are just categories** — "Real-Time Collaboration", "Analytics Dashboard", "24/7 Support" — each with an interchangeable two-line description.
- **Stock photography of smiling people at laptops.**
- **Fabricated logo walls and invented testimonials with generated headshots.**
- **Three pricing tiers** with the middle one highlighted, regardless of whether the product has three tiers.

### Motion tropes

- **Fade-up-on-scroll applied to everything**, same duration, no stagger, re-triggering each time.
- **The infinite logo marquee.**
- **Number counters** that tick up to a statistic.
- **Hover: `translateY(-4px)` plus a bigger shadow** on every card.
- **Typewriter text** cycling through nouns.

If your page contains three or more of these, it will read as generated regardless of how well it's executed.

---

## 2. The subtraction pass

Go section by section and ask, in order:

**1. Can this section be deleted entirely?** Does it say something the section above didn't? Most built pages contain at least one section that exists because pages are "supposed to" have one — an about blurb, a generic benefits row, a redundant CTA band. Delete it. Six excellent sections beat eleven adequate ones, and length is not a quality signal.

**2. What can be removed from this section?** Count the text objects. If there are more than three in a viewport, cut to three. The supporting paragraph under the headline usually restates the headline — delete it. The label above the headline usually duplicates the nav — check.

**3. Is anything here a second anchor?** If two elements are both trying to be impressive, one must become quiet. Pick the stronger and reduce the other to type on the ground.

**4. Did a colour creep in?** Search the CSS for hex values not in `tokens.css`. There will be some. Replace or remove.

**5. Is this motion earning its place?** If an animation could be deleted without anyone noticing, delete it. Motion should be scarce enough to be noticed.

**6. Can the type get bigger and the content get shorter?** Almost always yes. This is the single most reliable improvement available at this stage.

Expect to remove 20–30%. If you removed nothing, you didn't actually run the pass.

---

## 3. The scored rubric

Score each 0–3. Below 30/45 the page is not ready.

**Art direction**
1. Does the page have exactly one anchor, with everything else quiet?
2. Is the palette five values, obeyed everywhere?
3. Does the accent appear on less than 5% of any screen?
4. Would someone name a specific register looking at it, or just say "clean"?

**Typography**
5. Is the display:body ratio ≥ 6:1 at 1440px?
6. Is tracking tightened on the display and opened on the chrome?
7. Is body measure between 50 and 62ch everywhere?
8. Do the typefaces have character, or are they defaults?

**Composition**
9. Does all text align to two or three vertical rulers?
10. Is text/UI coverage under ~12% in narrative sections?
11. Does the page alternate dense and empty sections?
12. Is there a HUD layer — indices, eyebrows, a progress rule?

**Motion**
13. Is there one entrance gesture used consistently?
14. Does everything move as well as fade?
15. Does it hold 60fps on a mid-range laptop, and behave correctly under `prefers-reduced-motion`?

Question 4 is the one to weight most heavily. "Clean" is what people say about a page that has no flaws and no identity. A premium page provokes a *specific* description — cold, archival, mechanical, opulent. If the honest answer is "it looks nice", the art direction never got locked, and you should return to Phase 0 rather than adjust details.

---

## 4. Diagnosing "it's fine but not premium"

When a page passes the obvious checks and still doesn't land, it's nearly always one of five things:

**Everything is medium.** Medium type, medium spacing, medium contrast. Premium composition lives at extremes — enormous display against tiny chrome, vast empty space against one dense block. Nothing at 60%. Push the biggest thing bigger and the smallest thing smaller.

**Too many good ideas.** Symptom of a page that's interesting everywhere and memorable nowhere. Choose the anchor, demote the rest.

**No material quality.** Flat colour, no grain, no light source, no shadow, no reflection. The page reads as vector art. Add the light and the texture.

**Consistent but generic.** All the rules obeyed, no personality. The anti-brief was never written. Go back and answer: what must this never feel like?

**Motion doing the work design should do.** If removing every animation leaves an unremarkable page, the animation was covering. Fix the still frame first — screenshot the page with JS disabled and judge that image alone. If it isn't impressive frozen, no choreography will rescue it.
