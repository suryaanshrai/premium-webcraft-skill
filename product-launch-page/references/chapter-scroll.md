# Chapter Scroll

Implementation of the anatomy sequence — the pinned chapters, their transitions, and the HUD that tracks them.

Contents:
1. Structure
2. Pinning
3. The continuous subject
4. Transitions
5. The HUD
6. Mobile
7. Common failures

---

## 1. Structure

Keep the subject in a **single persistent element** and let the chapters change what's shown, rather than giving each chapter its own copy of the product. The persistent subject is what sells the continuity.

```html
<section class="anatomy">
  <div class="stage">                     <!-- pinned, holds the subject -->
    <canvas id="seq"></canvas>            <!-- or <img>, or the 3D canvas -->
    <div class="stage-grain"></div>
  </div>

  <div class="chapters">
    <article class="chapter" data-index="1">
      <p class="eyebrow">[ 01 — CONSTRUCTION ]</p>
      <h2 class="ch-title">Built on <em>Full Canvas</em></h2>
      <p class="ch-copy">Horsehair, floating free of the cloth, so the
         jacket learns the shape of the person wearing it.</p>
      <p class="ch-meta">14 HOURS · HAND-PADDED</p>
    </article>
    <!-- chapters 2..n -->
  </div>
</section>
```

The stage is pinned for the full length of the chapter sequence; the chapters scroll over or beside it. On a wide layout, put the stage on one ruler and the text on another — the subject occupying 55–65% of the width with text in a narrow column beside it is the most reliable composition.

---

## 2. Pinning

Two approaches. Pick one and be consistent.

**Pin the stage once, scroll the text past it.** Simpler, smoother, and generally better. The subject holds still while chapters pass; each chapter's entry updates the subject.

```js
ScrollTrigger.create({
  trigger: ".anatomy",
  start: "top top",
  end: "bottom bottom",
  pin: ".stage",
  pinSpacing: false
});

gsap.utils.toArray(".chapter").forEach((ch, i) => {
  ScrollTrigger.create({
    trigger: ch,
    start: "top 60%",
    end: "bottom 40%",
    onEnter:     () => goToChapter(i),
    onEnterBack: () => goToChapter(i)
  });
});
```

**Pin each chapter separately.** More cinematic, more control per beat, but risks feeling stuck. Budget 120–150vh per chapter and never chain more than four.

```js
gsap.utils.toArray(".chapter").forEach((ch, i) => {
  ScrollTrigger.create({
    trigger: ch, start: "top top", end: "+=140%",
    pin: true, pinSpacing: true, scrub: 0.6,
    onToggle: s => s.isActive && setIndex(i)
  });
});
```

Call `ScrollTrigger.refresh()` after fonts and images settle, or every pin boundary will be slightly wrong. This is the most common bug in pinned layouts and it presents as sections that jump or overlap at the seams.

---

## 3. The continuous subject

### Scrubbed frame sequence — the workhorse

Best quality-to-effort ratio for a rotating or transforming product.

```js
const frames = 90, imgs = [];
let idx = { i: 0 };
const ctx = canvas.getContext("2d");

// preload behind the loader — do not stream these in
await Promise.all(Array.from({ length: frames }, (_, i) => new Promise(res => {
  const im = new Image();
  im.onload = res; im.onerror = res;
  im.src = `/seq/${String(i).padStart(4, "0")}.webp`;
  imgs[i] = im;
})));

function draw() {
  const im = imgs[Math.round(idx.i)];
  if (!im) return;
  const s = Math.max(canvas.width / im.width, canvas.height / im.height);
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.drawImage(im, (canvas.width - im.width * s) / 2,
                    (canvas.height - im.height * s) / 2,
                    im.width * s, im.height * s);
}

gsap.to(idx, {
  i: frames - 1, ease: "none", onUpdate: draw,
  scrollTrigger: { trigger: ".anatomy", start: "top top", end: "bottom bottom", scrub: 0.5 }
});
```

Set the canvas backing store to `min(devicePixelRatio, 2) × CSS size`. Uncapped DPR on a phone is a guaranteed frame-rate collapse.

### Crossfading stills

Simpler and perfectly good when the chapters are genuinely different crops rather than a continuous rotation. Stack the images absolutely; fade and scale between them.

```js
function goToChapter(i) {
  shots.forEach((el, j) => gsap.to(el, {
    autoAlpha: j === i ? 1 : 0,
    scale: j === i ? 1 : 1.04,
    duration: 0.9, ease: "power2.out", overwrite: "auto"
  }));
}
```

`overwrite: "auto"` matters — without it, fast scrolling queues conflicting tweens and images ghost on top of each other.

The slight scale on the outgoing image is what makes it a transition rather than a dissolve.

---

## 4. Transitions

The move between chapters is where the format either feels directed or feels like a slideshow.

**Camera push.** Each chapter is deeper into the same shot — scale the subject up 8–15% across the chapter while the crop tightens. Gives the sequence forward direction.

**Continuous rotation.** With a frame sequence, don't stop the rotation at chapter boundaries. The object turns continuously; chapters are just moments along the turn. This is the most convincing option and worth the render time.

**Edge wipe.** A `clip-path` reveal following a strong line in the product — a lapel edge, the rim of a glass.

**Light change.** Keep the framing and shift the lighting between chapters. Subtle and very effective for hardware.

Avoid: hard cuts, slide-in-from-the-side, and any transition where the subject leaves the frame and a different subject enters. The user should never lose sight of the object.

**Text should not use the same transition as the subject.** Give the subject the slow move and let the copy unmask in with the site's standard entrance gesture. Two things doing the same motion at the same time reads as a single sluggish animation.

---

## 5. The HUD

The chapter index, progress rule, and micro-labels. Cheap to build, disproportionately effective — it's the layer that tells the user this was designed.

```html
<div class="hud" aria-hidden="true">
  <span class="hud-index"><b id="cur">01</b> / 05</span>
  <div class="hud-rule"><i id="bar"></i></div>
  <span class="hud-credit">A FILM BY —</span>
</div>
```

```css
.hud {
  position: fixed; z-index: 20; pointer-events: none;
  left: var(--margin); right: var(--margin); bottom: 2rem;
  display: flex; align-items: center; gap: 1.5rem;
  font: 500 var(--t-chrome)/1.2 var(--font-ui);
  letter-spacing: 0.16em; text-transform: uppercase;
  color: var(--ink-62);
}
.hud-rule { flex: 1; height: 1px; background: var(--hairline); }
.hud-rule i {
  display: block; height: 100%; width: 0%;
  background: var(--ink); transform-origin: left;
}
```

```js
ScrollTrigger.create({
  trigger: ".anatomy", start: "top top", end: "bottom bottom", scrub: true,
  onUpdate: s => bar.style.width = (s.progress * 100).toFixed(2) + "%"
});
```

Keep the counter under 11px, opacity under 0.65, and never let it collide with content. `aria-hidden` is correct here — it's decorative and a screen reader announcing "01 / 05" on every scroll is noise.

Optional additions that read well: a fixed list of chapter names with the active one at full opacity, a small coordinate or timestamp, a thin vertical rule at one of the page rulers running the full height.

---

## 6. Mobile

Pinned, scrubbed sequences are expensive and the composition doesn't fit a portrait viewport. Convert rather than shrink:

- **Unpin.** Chapters become normal full-height sections stacked vertically.
- **Each chapter gets its own still**, revealed with the standard entrance gesture.
- **Drop the frame sequence** — or serve a 30-frame version at 800px if the rotation is genuinely essential.
- **Reduce the HUD** to the counter alone, or remove it.
- Stack the subject above the text rather than beside it.

Gate on capability, and keep the media query and the JS guard consistent so you don't pin a section whose CSS assumes it's static:

```js
ScrollTrigger.matchMedia({
  "(min-width: 900px)": () => { /* pinned setup */ },
  "(max-width: 899px)": () => { /* stacked setup */ }
});
```

---

## 7. Common failures

**The seam jump.** Pinned sections overlap or gap at the boundary. Cause: `ScrollTrigger.refresh()` not called after fonts and images load, or `pinSpacing` inconsistent between adjacent triggers.

**Ghosting images.** Two chapter stills visible at once during fast scroll. Cause: missing `overwrite: "auto"`.

**The stuck feeling.** User scrolls and nothing appears to change. Cause: pin length too long, or the transition too subtle to read. Shorten to 120vh and make the subject's movement more pronounced.

**Sequence pop-in.** Frames appearing progressively as the user scrubs. Cause: not preloading the full sequence before revealing the page. There is no partial fix — either it's all loaded or the effect is broken.

**Desync between DOM and canvas.** The subject lags the text noticeably. Cause: driving the canvas from native scroll while the DOM is on Lenis. Drive both from Lenis.

**Chapters that read as a feature list.** Cause: benefit-phrased titles and same-distance framing. Fix the titles to concrete nouns and vary the camera distance across the sequence.
