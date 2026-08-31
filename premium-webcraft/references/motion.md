# Motion & Interaction

Contents:
1. The motion signature
2. Curve and duration library
3. Reveal recipes
4. Smooth scroll (Lenis)
5. Scroll choreography with ScrollTrigger
6. The interaction layer
7. Page transitions and the preloader
8. Performance and accessibility

---

## 1. The motion signature

Pick **one entrance gesture** and use it for essentially everything on the site. Every text block unmasks upward. Or every element scales from 0.96 with a fade. Or everything slides in from the ruler.

Variety in motion reads as indecision. Repetition reads as choreography. This is counterintuitive — the instinct is to make each section's animation "interesting" — but a page where seven different entrance styles appear feels like seven people built it, which is exactly the impression to avoid.

Write the chosen gesture into `art-direction.md` and then don't deviate.

---

## 2. Curve and duration library

```css
--ease-out:   cubic-bezier(0.16, 1, 0.3, 1);    /* expo out — the default */
--ease-inout: cubic-bezier(0.76, 0, 0.24, 1);   /* symmetric, for pinned scrubs */
--ease-ui:    cubic-bezier(0.4, 0, 0.2, 1);     /* fast feedback */
--ease-soft:  cubic-bezier(0.33, 1, 0.68, 1);   /* gentle, for large media */
```

`--ease-out` is the workhorse. It moves most of the distance immediately and then settles slowly, which the eye reads as mass. Linear and `ease-in-out` both read as computed.

| Event | Duration |
|---|---|
| Section / text entrance | 800–1200ms |
| Large media entrance | 1200–1600ms |
| Hover, focus, button | 250–400ms |
| Cursor follow | lerp 0.12–0.18 per frame |
| Menu open/close | 500–700ms |
| Page transition | 700–1000ms |

Anything below ~600ms on an entrance reads as a page load rather than a reveal. Anything above ~1600ms starts to feel broken. The band matters more than the exact number.

**Stagger:** 60–90ms between sibling blocks, 40–60ms between lines of a single headline. Below 30ms the effect vanishes; above 120ms the group falls apart into individuals.

---

## 3. Reveal recipes

### Never fade from opacity alone

A pure opacity fade is the default and it registers as nothing happening. Always couple it with movement or a mask.

### Clip-path line unmask — the editorial default

Text appears to rise out from behind a hidden edge. This is the highest-quality reveal available in pure CSS/GSAP and suits serif display type especially well.

```html
<h1 class="reveal"><span class="line"><span>The Anatomy</span></span>
<span class="line"><span><em>of a Suit</em></span></span></h1>
```

```css
.line { display: block; overflow: hidden; }
.line > span { display: block; transform: translateY(105%); }
```

```js
gsap.to(".reveal .line > span", {
  y: 0, duration: 1.1, ease: "expo.out", stagger: 0.06,
  scrollTrigger: { trigger: ".reveal", start: "top 78%" }
});
```

The `105%` rather than `100%` matters — it guarantees descenders clear the mask edge.

### Media scale-in

```js
gsap.from(".media img", {
  scale: 1.12, duration: 1.5, ease: "power3.out",
  scrollTrigger: { trigger: ".media", start: "top 85%" }
});
```

Scaling *down* into place (from 1.12 to 1) reads as settling. Scaling up reads as popping, which is a UI gesture, not a cinematic one.

### Blur-in for atmosphere

```js
gsap.from(el, { filter: "blur(14px)", opacity: 0, y: 24, duration: 1.2, ease: "expo.out" });
```

Effective but expensive — animating `filter` triggers repaints. Use on at most one or two elements per page, never on a stagger group.

### Trigger points

Start reveals at `top 78%`–`top 85%`. Triggering at the exact viewport edge means the user scrolls past before the animation completes and sees only the tail.

Use `once: true` for entrances. Elements that re-animate every time they scroll back into view feel restless and cheap.

---

## 4. Smooth scroll (Lenis)

Native scroll is too abrupt for long reveals — the content arrives before the animation reads.

```js
import Lenis from "lenis";

const lenis = new Lenis({ lerp: 0.1, wheelMultiplier: 1, smoothWheel: true });
function raf(t) { lenis.raf(t); requestAnimationFrame(raf); }
requestAnimationFrame(raf);

// hand scroll position to GSAP
lenis.on("scroll", ScrollTrigger.update);
gsap.ticker.add((t) => lenis.raf(t * 1000));
gsap.ticker.lagSmoothing(0);
```

`lerp` between **0.08 and 0.12**. Lower feels heavy and laggy — users notice the disconnect from their trackpad. Higher gives up the benefit.

Disable smooth scroll on touch devices (`smoothTouch: false`, the default). Mobile browsers already have momentum scrolling, and overriding it fights the OS and feels broken.

---

## 5. Scroll choreography with ScrollTrigger

### Pinned scrub sections

The core cinematic device: hold a section in place while its contents advance under scroll.

```js
ScrollTrigger.create({
  trigger: ".chapter",
  start: "top top",
  end: "+=140%",        // 100–150vh of scroll per chapter
  pin: true,
  scrub: 0.6            // number, not `true`
});
```

**`scrub: 0.6` rather than `scrub: true`.** The numeric form adds a short catch-up lag, so the animation trails the scroll slightly instead of locking to it rigidly. That lag is what makes scrubbed motion feel weighted rather than like a slider being dragged.

Keep pinned length at 100–150vh per chapter. Longer and users think the page is stuck.

**Never pin more than three consecutive sections.** Pinning removes the user's sense of progress; too much of it in a row reads as a hijacked page and drives people away.

### Parallax

```js
gsap.to(".layer-back", {
  yPercent: -18, ease: "none",
  scrollTrigger: { trigger: ".section", start: "top bottom", end: "bottom top", scrub: true }
});
```

Keep offsets under about 20%. Aggressive parallax separates layers so far they stop reading as one space.

### Horizontal sections

```js
const track = document.querySelector(".track");
gsap.to(track, {
  x: () => -(track.scrollWidth - innerWidth),
  ease: "none",
  scrollTrigger: {
    trigger: ".h-wrap", pin: true, scrub: 0.6,
    end: () => "+=" + (track.scrollWidth - innerWidth),
    invalidateOnRefresh: true
  }
});
```

`invalidateOnRefresh` is essential — without it the distances are wrong after any resize.

### Scroll-scrubbed video / frame sequence

The effect behind most "how did they do that" hero sections, and it doesn't need WebGL. Pre-render a sequence to WebP frames, draw to a canvas, drive the index from scroll progress. 60–120 frames at 1600px wide is usually plenty. Preload the whole sequence behind the loader; a sequence that streams in while scrubbing looks broken.

### Section index / HUD sync

```js
ScrollTrigger.create({
  trigger: sec, start: "top 50%", end: "bottom 50%",
  onToggle: (s) => s.isActive && setIndex(i)
});
```

---

## 6. The interaction layer

### Custom cursor

Worth doing, easy to do badly. The failure mode is a cursor that lags so far behind the pointer that precision suffers.

```js
let mx = 0, my = 0, cx = 0, cy = 0;
addEventListener("pointermove", e => { mx = e.clientX; my = e.clientY; });
function tick() {
  cx += (mx - cx) * 0.16;   // 0.14–0.2
  cy += (my - cy) * 0.16;
  cursor.style.transform = `translate3d(${cx}px, ${cy}px, 0)`;
  requestAnimationFrame(tick);
}
tick();
```

Only hide the native cursor (`cursor: none`) if the replacement is genuinely reliable, and only on `(hover: hover) and (pointer: fine)`. Keep a visible focus ring for keyboard users regardless — an invisible cursor plus no focus ring is an unusable page.

Give the cursor two or three states: default dot, expanded ring over links, a label ("VIEW", "DRAG") over media.

### Magnetic hover

```js
el.addEventListener("pointermove", e => {
  const r = el.getBoundingClientRect();
  gsap.to(el, {
    x: (e.clientX - (r.left + r.width / 2)) * 0.25,
    y: (e.clientY - (r.top + r.height / 2)) * 0.25,
    duration: 0.6, ease: "power3.out"
  });
});
el.addEventListener("pointerleave", () =>
  gsap.to(el, { x: 0, y: 0, duration: 0.7, ease: "elastic.out(1, 0.4)" })
);
```

Strength 0.2–0.3. Above that the element outruns the cursor and feels evasive. Apply to two or three elements at most — a page where everything is magnetic is exhausting.

### Link states

Underline that wipes in from the left, letters that shift up one row, a background that fills from the bottom. Pick one and use it for every link on the site.

```css
.link { position: relative; }
.link::after {
  content: ""; position: absolute; left: 0; bottom: -2px;
  width: 100%; height: 1px; background: currentColor;
  transform: scaleX(0); transform-origin: right;
  transition: transform 400ms var(--ease-out);
}
.link:hover::after { transform: scaleX(1); transform-origin: left; }
```

The origin flip is the detail — it wipes in from one side and out from the other rather than pulsing symmetrically.

### Buttons

No instant state changes. Every button gets a 250–350ms transition on at most two properties. Add a subtle `scale(0.98)` on `:active` — the tactile confirmation is small but its absence is noticeable.

---

## 7. Page transitions and the preloader

**The preloader is not optional on a heavy page.** Fonts, hero media, and any 3D must be ready before the first frame is shown, or the user watches the page assemble itself — which undoes all the choreography.

Make it part of the design, not a spinner. A counter from 0 to 100 in the display face, or a progress hairline, or the wordmark drawing itself. It's the first impression and it's usually the cheapest section to make excellent.

Hold the reveal until at least 800ms even if assets load instantly — an instant flash-through feels like a glitch.

For transitions between routes, a full-bleed panel wiping across works reliably and doesn't require view-transition support. Keep total transition under 1s each way; anything longer makes the site feel slow rather than crafted.

---

## 8. Performance and accessibility

A premium site that stutters is not premium. 30fps destroys the illusion faster than any design flaw.

- **Animate only `transform` and `opacity`.** Everything else runs on the main thread. `filter` and `clip-path` are acceptable in small doses; `width`, `height`, `top`, `left`, and `box-shadow` are not.
- **`will-change` sparingly** — set it before an animation, remove it after. Permanent `will-change` on many elements exhausts GPU memory and makes things slower.
- **Cap `devicePixelRatio` at 2** for any canvas.
- **`ScrollTrigger.refresh()`** after fonts load and images settle, or every trigger point will be slightly wrong.
- **Kill offscreen work** — pause video, canvas loops, and RAF for anything out of view.

Accessibility isn't a tax here, it's part of the craft:

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

Also disable Lenis and set all scroll-triggered elements to their end state. Reduced motion means *arrives instantly*, not *arrives fast* — and never *never arrives*, which is what happens when you only disable the animation and leave `opacity: 0` in place. That bug ships constantly; check for it.

Maintain contrast: ink at 38% opacity on a dark ground frequently fails WCAG AA. Use the low opacity steps for decorative chrome, not for anything a user needs to read.
