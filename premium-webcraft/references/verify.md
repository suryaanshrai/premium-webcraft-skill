# Look At What You Built

The largest single quality gap in agent-built front ends is that the agent never sees the page. It writes plausible code, the code compiles, and nobody checks whether the hero actually renders — whether the font loaded, whether the pinned section overlaps the next one, whether a runtime error killed the scroll handler on chapter three.

Everything else in this skill is judgement applied to intent. This is the step that checks reality.

Contents:
1. Getting eyes on the page
2. The verification pass
3. What to look for in a screenshot
4. Console and network
5. Motion and scroll states
6. The loop
7. When you have no browser

---

## 1. Getting eyes on the page

In rough order of preference, use whatever the environment offers:

**A browser MCP or Playwright skill.** If a browser automation tool is available, use it. Navigate, screenshot, click, read console logs. This is the full loop.

**Playwright directly.** If you can run code, install it and drive it yourself:

```js
import { chromium } from "playwright";

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });

const errors = [];
page.on("console", m => m.type() === "error" && errors.push(m.text()));
page.on("pageerror", e => errors.push("UNCAUGHT: " + e.message));
page.on("requestfailed", r => errors.push("FAILED: " + r.url()));

await page.goto("http://localhost:3000", { waitUntil: "networkidle" });
await page.waitForTimeout(1500);              // let the preloader finish
await page.screenshot({ path: "shots/hero.png" });

console.log(errors);
await browser.close();
```

**Headless Chrome via Puppeteer** if Playwright isn't available.

**Ask the user.** If you have no browser at all, say so plainly and ask them to open it and paste back a screenshot and the console output. Do not skip verification silently and describe the page as if you'd seen it — that's the specific behaviour that erodes trust, and it's easy to avoid.

---

## 2. The verification pass

Run this after Phase 1 (static build) and again after Phase 6 (subtraction). Twice is enough; verifying after every edit wastes time.

```js
const shots = [
  { name: "hero-1440",   w: 1440, h: 900,  y: 0 },
  { name: "hero-2560",   w: 2560, h: 1440, y: 0 },
  { name: "hero-mobile", w: 390,  h: 844,  y: 0 },
];

for (const s of shots) {
  await page.setViewportSize({ width: s.w, height: s.h });
  await page.evaluate(y => window.scrollTo(0, y), s.y);
  await page.waitForTimeout(900);            // let reveals settle
  await page.screenshot({ path: `shots/${s.name}.png` });
}

// full-page, for rhythm and pacing
await page.setViewportSize({ width: 1440, height: 900 });
await page.screenshot({ path: "shots/full.png", fullPage: true });
```

Then **actually view the screenshots.** Reading the file paths is not verification.

For a scroll-driven page, also capture at each section boundary — step the scroll position in viewport increments and screenshot each stop. Pinned sections need this most, because seam bugs are invisible in code and obvious in an image.

---

## 3. What to look for in a screenshot

Judge the image, not your memory of the code. Specifically:

**Did the fonts load?** A fallback serif where your display face should be is the most common silent failure, and it changes the entire character of the page. Check by eye, and confirm with `document.fonts.check()`.

**Is the composition what you intended?** Text on the rulers, the object where you placed it, the emptiness where you budgeted it. Layout that reads correctly in code often doesn't in the frame.

**Count the text objects.** Actually count them in the image. This is the budget check and it's meaningless done from memory.

**Estimate the ink coverage.** Roughly what fraction of the frame is content? If it's more than about 12% in a narrative section, cut.

**Is there anything obviously broken?** Overlapping elements, a scrollbar where there shouldn't be one, an image at the wrong aspect ratio, a section with no height because its content is absolutely positioned.

**At 2560px:** does the layout stretch awkwardly, does the type get absurd, do the rulers still hold?

**At 390px:** is anything cut off, is the type still legible, did a pinned section survive that shouldn't have?

**Is it good?** The honest question. If the frozen frame isn't impressive, that's the finding, and it matters more than any of the above.

---

## 4. Console and network

Runtime errors on a motion-heavy page are frequently silent in their effects — a thrown error in a ScrollTrigger callback kills that trigger and leaves the rest of the page working, so the symptom is one section that doesn't animate rather than a visible crash.

Collect and read:

- **`pageerror`** — uncaught exceptions. Fix all of them.
- **`console.error`** — React key warnings, hydration mismatches, Next.js image priority warnings. The hydration ones matter: a mismatch means the server and client rendered different things, which produces flicker.
- **`requestfailed`** — a 404 on a font or a sequence frame. On a page that preloads a frame sequence, one missing frame breaks the whole scrub.
- **Total transferred bytes and the largest resources.** An 18MB hero video will not have been obvious while writing the markup.

```js
await page.evaluate(() => ({
  fontsReady: document.fonts.status,
  missingAlt: [...document.images].filter(i => !i.hasAttribute("alt")).length,
  noDims: [...document.images].filter(i => !i.width || !i.height).length,
  hScroll: document.documentElement.scrollWidth > window.innerWidth,
}));
```

That last one — horizontal overflow — is worth checking every time. A single element overflowing by 3px produces a scrollbar that ruins a full-bleed composition, and it is nearly impossible to spot by reading code.

---

## 5. Motion and scroll states

Static screenshots don't verify motion. Check these explicitly:

**Scroll through the whole page** in increments and screenshot. Look for pinned-section seams — sections that jump, overlap, or leave a gap at the boundary. Nearly always `ScrollTrigger.refresh()` not called after fonts settled.

**Check that reveals completed.** Scroll to a section, wait, screenshot. Anything still at `opacity: 0` is a bug — usually a trigger that never fired because its start point was past the element.

**Test reduced motion:**

```js
await page.emulateMedia({ reducedMotion: "reduce" });
await page.goto(url);
await page.screenshot({ path: "shots/reduced.png", fullPage: true });
```

Every element must be visible in this screenshot. If anything is missing, you have the classic bug where the animation was disabled but the initial hidden state was left in place.

**Test keyboard.** Tab through and screenshot after each stop; confirm a visible focus ring appears every time and isn't hidden behind the fixed HUD.

**Throttle the network** and reload — check that the preloader appears and that nothing renders half-assembled behind it.

---

## 6. The loop

1. Build
2. Screenshot at three viewports plus full page
3. Read the console
4. **Look at the screenshots**
5. List what's wrong — visual and console together
6. Fix
7. Re-screenshot only what changed
8. Repeat until the list is empty

Two or three cycles is normal. More than five usually means a structural problem that patching won't fix, and it's worth stepping back to the art direction lock rather than continuing to nudge.

Keep the screenshots. Showing the user the before-and-after of the subtraction pass is far more persuasive than describing it, and it's the fastest way for them to tell you what they actually want changed.

---

## 7. When you have no browser

Say so, once, plainly. Then compensate:

- Be conservative about anything you can't verify — avoid clever CSS whose behaviour you're not certain of
- Add explicit dimensions, explicit fallbacks, and defensive guards
- Give the user a short, specific list of what to check: "load it and tell me whether the display font is the serif or a fallback, whether there's a horizontal scrollbar, and what's in the console"
- Never describe the rendered result as though you have seen it

An honest "I haven't been able to render this — here's what to check" is worth more than a confident description of a page that might not work.
