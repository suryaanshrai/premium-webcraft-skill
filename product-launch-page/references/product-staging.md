# Product Staging

The imagery is more than half the page. This is the reference to read *before* sourcing anything.

Contents:
1. The shot list
2. The lighting setup
3. Backgrounds and the void
4. Generating a consistent set
5. Compositing into the void
6. Grading the set
7. Motion assets

---

## 1. The shot list

Derive it from the page score. The minimum set:

| # | Shot | Purpose | Framing |
|---|---|---|---|
| 1 | **Concealed** | Cold open | Product silhouetted, rim-lit, or cropped past recognition |
| 2 | **Hero** | The reveal | Full object, full frame, three-quarter or dead-on |
| 3–5 | **Detail** ×3–5 | Anatomy chapters | Progressively tighter; one part each |
| 6 | **In context** | The world beat | Product in use, human or environmental scale |
| 7 | **Final** | The offer | Clean, simple, often the hero again on a lighter ground |

Every shot except #6 must share **the same key-light direction, the same background treatment, and the same lens character.** This is the single most important constraint in the whole document. A set where the light jumps from left to right between chapters destroys the illusion that the user is looking at one continuous subject, and it's a failure people feel without being able to name.

Pick the light direction once. Write it into `page-score.md`. Apply it to every shot including generated ones.

---

## 2. The lighting setup

The entire aesthetic is **one object in a dark or empty space, lit directionally.** Four lights, three of which most amateur setups omit.

**Key.** Strong, from above and roughly 30–45° to one side. It defines the form. Soft (large source) for apparel, food, and organic subjects; harder for hardware and anything you want to read as engineered.

**Rim / kicker.** Behind the subject, raking across its far edge. This produces the bright outline separating the object from the background. **It is the highest-impact light in the setup and the one most commonly missing.** Without it, a dark product on a dark ground merges into it and looks flat and cheap. With it, the object separates and reads as three-dimensional.

**Fill.** Weak, opposite the key, just enough that the shadow side isn't pure black. Around 1/8 the key's intensity. Too much fill flattens everything back out.

**Practical / ambient.** Optional. A glow that motivates the background gradient — a light source implied just out of frame.

**Contact shadow.** Not a light, but essential. A tight, dark, small-radius shadow directly beneath the object. Without it the product looks pasted onto the background rather than standing in a space. If the shot doesn't have one, add it in CSS:

```css
.product { filter: drop-shadow(0 30px 45px rgb(0 0 0 / 0.6)); }
```

**Reflection.** On dark grounds, a flipped copy of the subject below it at 12–18% opacity, blurred 2–4px, masked with a downward gradient. Cheap, and it does an enormous amount to plant the object.

---

## 3. Backgrounds and the void

The background is never a flat fill. It's a **falloff from the light source** — brighter where the light is, darker at the edges.

```css
.stage {
  background:
    radial-gradient(70% 55% at 50% 30%, #1C1F26 0%, transparent 65%),
    var(--ground);
}
```

Three background registers, matched to the product:

**The void.** Near-black, one soft pool of light, object floating. Suits hardware, apparel, spirits, jewellery. Maximum drama, minimum context.

**The paper.** Warm off-white, soft top light, long soft shadow. Suits food, ceramics, craft goods, editorial. Reads as considered rather than dramatic.

**The room.** A suggestion of an environment — a surface edge, a wall falloff, a window's light shape — but no identifiable furniture or place. Suits furniture, interiors, appliances.

Add a vignette at 15–25% and the grain overlay from the art-direction reference. Both are near-invisible individually and together they're most of the difference between "render" and "photograph".

---

## 4. Generating a consistent set

Generated product imagery is legitimate and often the right choice. The failure mode is always **inconsistency across the set** — the same product with different lighting, different reflectivity, and different backgrounds in each shot reads as a collage.

To keep a set coherent:

**Write one staging clause and reuse it verbatim in every prompt.** Vary only the framing and the part in focus.

```
[SUBJECT], [FRAMING].
Staging: single object, no other props, dark charcoal void background
with a soft radial light pool behind the subject.
Lighting: large soft key from upper-left at 40 degrees, strong rim
light from behind-right defining the edge, minimal fill, tight contact
shadow directly beneath.
Lens: 85mm, shallow depth of field, subject sharp.
Grade: slightly desaturated, cool shadows, warm highlights.
Photographic, no text, no watermark, no people.
```

Then per shot, change only the first line: `"...extreme macro on the cuff buttonhole, thread visible"`, `"...three-quarter view, full object in frame"`.

**Generate more than you need** — six to eight per slot — and select for consistency, not for individual quality. The best-looking single image is the wrong pick if its light comes from the other side.

**Lock the product's identity.** If the same object appears across shots, its colour, proportions, and materials must match. Use image-to-image or a reference image where the tool supports it. If they drift, either regenerate against a reference or design the score so each chapter is a genuinely different part where the drift isn't legible.

**Be honest about the constraint.** If the user has a real product, real photography or a real 3D render will always beat generated imagery, because generated images of a *specific* product are approximations. Say so, and reserve generation for the atmospheric and contextual shots where precision doesn't matter.

**Never mix generated and real photography of the same subject** on one page. The mismatch in micro-detail is immediately visible even to people who can't explain it.

---

## 5. Compositing into the void

When you have a product shot on white or on a busy background and need it floating:

1. **Cut it out cleanly.** Edge quality is everything — a halo or a jagged edge undoes the whole effect. Get an alpha-channel PNG or WebP.
2. **Kill the original shadow** and build a new one that matches your key-light direction.
3. **Add the rim light back** if the source didn't have one — a soft light-coloured stroke along the edge facing away from your key, at low opacity, does a surprisingly convincing job.
4. **Match the grade** to the background: warm ground means the product needs warm highlights.
5. **Add the contact shadow and reflection.**
6. **Apply the page's grain over both** so the product and background share the same texture. This last step is what makes a composite stop looking like a composite.

---

## 6. Grading the set

Once every image exists, grade them **as a set, in one pass**, not individually.

- Match black points and white points across all shots
- Push toward one temperature — usually cool shadows with warm highlights, or the reverse
- Reduce saturation slightly; oversaturated product shots read as e-commerce
- Match contrast curves
- Optionally add a light colour cast matching the accent

Do this even for a set from a single shoot. Especially do it for a mixed-source set.

Export AVIF with WebP fallback, `srcset` at 640/1024/1600/2400, and set explicit dimensions.

---

## 7. Motion assets

**Rotation sequences.** For a product that turns as the user scrolls: 60–120 frames of a single rotation, WebP, 1600px wide, drawn to a canvas indexed by scroll progress. Preload behind the loader. This is the cleanest way to get "3D product" feeling without Three.js and it looks better because it's offline-rendered.

**Process loops.** For food and anything with state change — pour, sear, steam, cut. Two to four seconds, seamless, under 3MB, WebM plus MP4, muted and `playsinline`. Play on entering the viewport, pause on leaving.

**Chapter transition frames.** If chapters crossfade, render the in-between states so the transition is a real move rather than a dissolve between unrelated shots. Ten to twenty frames between chapters is enough.

**Always provide a poster image** matching frame one, and swap video for a still on mobile or on a slow connection. A hero video that hasn't loaded is a black rectangle, which is a much worse first impression than a photograph.
