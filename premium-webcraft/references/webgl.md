# The 3D / WebGL Tier

Contents:
1. The gate — does this need WebGL?
2. Cheaper techniques that look the same
3. The anchor catalogue
4. Integration patterns
5. Lighting and materials
6. Performance
7. Mobile

---

## 1. The gate

WebGL multiplies an already-good page. It does not rescue a weak one — a shader over poor typography just draws attention to the typography.

Before installing Three.js, answer honestly: **does the anchor need real geometry, real depth, or real-time response to the pointer?**

Reach for WebGL when:
- The user needs to control an object continuously (orbit a product, explore a space)
- Depth and camera movement through a scene *is* the concept
- The effect responds to pointer position in real time (fluid, distortion, particle attraction)
- Materials need real reflection and refraction that respond to a moving light

Don't, when:
- A single lit still would produce the same feeling
- A pre-rendered frame sequence scrubbed on scroll would do it — this covers most "3D scroll" hero sections, looks *better* because it's offline-rendered, and never janks
- It's a background texture (use CSS gradients plus grain)
- Deadline is short. A rushed WebGL scene looks worse than no WebGL scene, and there is no partial credit.

The pages in the premium reference tier that read as cleanest — dark product pages, editorial architecture pages, interior walkthroughs — are frequently not WebGL at all. They are pre-rendered media, immaculately typeset. That path is available and it is usually the better one.

---

## 2. Cheaper techniques that look the same

**Scrubbed frame sequence.** Render 60–120 WebP frames offline in Blender or C4D. Draw to a canvas indexed by scroll progress. Preload behind the loader. This gives you full ray-traced quality, deterministic performance, and no shader debugging.

**Video with `requestVideoFrameCallback`,** or a scrubbed `<video>` for smoother large sequences. Encode as a keyframe-heavy MP4/WebM so seeking is fast.

**Layered PNGs with parallax.** Three or four cut-out layers moving at different rates produces convincing depth for a fraction of the cost.

**CSS 3D transforms.** `perspective` plus `rotateY` on a handful of elements builds a genuine card carousel or gallery ring without a renderer.

**A single well-lit still.** Genuinely — a product photographed or rendered with one key light, a rim, a contact shadow, and a reflection, placed in an empty frame with tiny type, beats 90% of amateur WebGL.

---

## 3. The anchor catalogue

When 3D does earn its place, these are the anchors that read as premium rather than as demos:

- **The object.** One product, floating, slowly rotating, responding to the cursor. Studio-lit. The rest of the page is type on the ground.
- **The portal.** Camera pushes through an aperture into a different space, driven by scroll. Works as a section transition.
- **The gallery ring.** Images arranged on a cylinder or sphere, rotating with drag. Effective for portfolios.
- **The fly-through.** Camera travels a spline through a modelled scene as the user scrolls; content is anchored to waypoints.
- **The distortion field.** A displacement shader on images that warps toward the cursor or on transition.
- **The particle form.** Points assembling into shapes and dispersing — legible when it forms something recognisable, generic when it's abstract noise.
- **Breaking the frame.** A 3D object that appears to emerge past the boundary of its section, occluded by DOM elements.

One of these. Not two.

---

## 4. Integration patterns

**Fixed canvas behind the DOM** is the most maintainable arrangement:

```css
#gl { position: fixed; inset: 0; z-index: 0; pointer-events: none; }
main { position: relative; z-index: 1; }
```

Re-enable `pointer-events` on the canvas only for sections where the user is meant to interact with the scene, and disable it again after — otherwise the 3D layer silently swallows clicks on links, which is a maddening bug to track down.

**Sync the camera to Lenis**, not to native scroll, or the 3D will desynchronise from the smooth-scrolled DOM by a visible amount:

```js
lenis.on("scroll", ({ scroll, limit }) => {
  progress = scroll / limit;
});
// in the render loop:
camera.position.z = THREE.MathUtils.lerp(camera.position.z, start + progress * dist, 0.08);
```

Lerping toward the target rather than assigning it directly gives the camera inertia, which is most of what makes scroll-driven 3D feel expensive.

**DOM-synced objects.** To place a 3D object exactly where a DOM element sits, use an orthographic camera with `frustumSize` matched to viewport pixels — then DOM coordinates map to world coordinates directly and stay locked on resize.

---

## 5. Lighting and materials

Lighting is what separates a render that looks premium from one that looks like a WebGL tutorial. The geometry matters far less.

- **Always use an HDRI environment map.** `RoomEnvironment` from Three's examples is a two-line default that immediately outperforms hand-placed lights. A real HDRI is better still.
- **Three-point setup:** a strong key at an angle, a dim fill opposite, and a **rim light behind** the subject. The rim — a bright edge separating the object from the background — is the single highest-impact light and the one most often missing.
- **Never a bare `MeshBasicMaterial`** on a hero object. `MeshPhysicalMaterial` with sensible `roughness` (0.2–0.5) and `metalness`, plus `clearcoat` on anything glossy.
- **Tone mapping matters:** `renderer.toneMapping = THREE.ACESFilmicToneMapping` and `outputColorSpace = SRGBColorSpace`. Without these, everything is blown out or muddy and no amount of light tweaking fixes it.
- **Contact shadow.** A soft shadow-catching plane beneath the object, or a baked shadow texture. An object with no contact shadow floats in a way that reads as unfinished.
- **Post-processing:** a subtle bloom on emissive areas and light film grain. Keep bloom `strength` under 0.4 — heavy bloom is a distinctive amateur signature.

---

## 6. Performance

```js
renderer.setPixelRatio(Math.min(devicePixelRatio, 2));
```

Uncapped DPR on a 3× phone renders nine times the pixels and will drop to single-digit frame rates.

- **DRACO-compress GLTF.** Typically 5–10× smaller.
- **KTX2 / Basis textures** — GPU-compressed, so they use less VRAM as well as less bandwidth.
- **Cap texture size at 2048** for anything that isn't the hero subject.
- **Stop the render loop when offscreen** with an IntersectionObserver. A hero canvas rendering at 60fps while the user reads the footer drains battery for nothing.
- **Render on demand** for static scenes — only call `render()` when something actually changed.
- **Dispose properly** on unmount: geometries, materials, textures, and the renderer. In SPAs, leaked GPU resources accumulate and eventually crash the tab.
- **Budget:** aim under 150k triangles and under 30 draw calls for a hero scene. Instance anything repeated.

---

## 7. Mobile

Advanced shaders drain batteries and thermally throttle within a minute. Serve a reduced experience and don't apologise for it — the typography and layout carry the page there.

Detect capability rather than user agent — check `devicePixelRatio`, hardware concurrency, and whether the device reports a discrete GPU renderer. On low-capability devices:

- Swap the WebGL hero for a poster image or a short looping video
- Drop post-processing entirely
- Halve particle counts and texture resolution
- Disable smooth scroll

A mobile page that is fast, beautifully typeset, and static reads as far more premium than one that stutters through a degraded 3D scene.
