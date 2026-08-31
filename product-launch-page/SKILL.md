---
name: product-launch-page
description: Builds cinematic single-product landing pages — the chaptered, scroll-driven, one-object-in-a-void format used for luxury goods, hardware, apparel, food and drink, spirits, fragrance, furniture, and premium software launches. Use this whenever the user wants a landing page, launch page, product page, sales page, or hero page for one specific product, or says things like "make a page for my [product]", "a landing page that actually sells this", "like the Apple product pages", or shares a cinematic product-site reference. Pairs with the premium-webcraft skill, which supplies the visual system; this skill supplies the narrative structure, product staging, and conversion mechanics.
---

# Product Launch Page

A single-product page has one job: make someone want the thing. The format that does this — used by every luxury house, every hardware launch, and every good spirits brand — is not a marketing page with sections. It's **a short film with a buy button at the end**.

The structure is consistent enough to be treated as a score: one object, introduced in shadow, revealed, then examined part by part as the user scrolls, then shown in the world, then specified, then offered. Nothing else. No feature grid, no testimonial carousel, no FAQ accordion — those belong on a different kind of page and their presence is what makes a product page read as e-commerce rather than as desire.

## Before anything else

**Read the `premium-webcraft` skill and run its Phase 0 first.** That produces `design/art-direction.md` and `design/tokens.css`, which this skill builds on top of. This skill does not define colours, type scales, or motion curves — it references the tokens. If both skills are active and a conflict arises, art direction wins on any visual value; this skill wins on structure and sequence.

If `premium-webcraft` isn't available, establish at minimum: one ground colour and two tints, one ink, one accent, two typefaces, and a display:body ratio of at least 6:1 — then proceed.

If the user supplies a reference site, a moodboard, or a `DESIGN.md`, derive the lock from that rather than inventing one — `premium-webcraft/references/reference-extraction.md` covers it, including the caveat that product design systems need their scale and spacing pushed hard before they suit a page like this.

## The one thing that makes this format work

**The product is the only subject on the page, and it is treated like an actor.**

It has a single continuous presence across the whole scroll — appearing in shadow, turning into the light, moving closer, being cut apart, reassembling. It is never shown as a thumbnail in a grid. Each chapter is a different *shot* of the same subject, not a different subject.

This is the difference between the format working and not working. A page that shows the product hero-large, then in three small cards, then in a gallery, has broken the illusion of one continuous subject and become a catalogue. Hold the single subject and the page reads as cinema.

## The score

The canonical sequence. Read `references/page-score.md` for the full breakdown of each beat, the variants by product category, and how to compress or extend.

| # | Beat | Job | Rough length |
|---|---|---|---|
| 0 | **Preload** | Build anticipation; hide asset loading | 1.5–3s |
| 1 | **Cold open** | Name the thing. Product barely visible — silhouette, edge-light, or partly out of frame | 100vh |
| 2 | **The reveal** | Full presence, fully lit, the money shot | 100–150vh |
| 3 | **Anatomy** | 3–5 pinned chapters, each isolating one part or quality | 120–150vh each |
| 4 | **In the world** | Product in use, at human scale — the only section with a person in it | 100vh |
| 5 | **Specification** | Dense technical block. Deliberate density contrast after all the emptiness | 60–100vh |
| 6 | **The offer** | Price, variants, single CTA | 80–100vh |
| 7 | **The close** | Return to the cold-open register. One line. | 60–80vh |

Total: seven to ten screens of *content*, three to four times that in scroll length because of pinning. That's a five-minute experience, which is correct. A product page is not a site.

### On the cold open

Resist opening with the product fully revealed. The strongest examples of this format open with the object mostly in darkness — a rim of light down one edge, a silhouette, a detail cropped so tight it isn't identifiable yet — plus the title in display type and nothing else.

Withholding is the mechanism. If the first screen shows everything, the remaining screens have nothing to give, and the user has no reason to scroll except obligation.

### On the anatomy chapters

This is the heart of the format and where most attempts fail by turning it into a feature list.

Each chapter takes **one physical part or one quality** and gives it a full pinned screen: a title in display type, one or two sentences, a tiny spec label, and the product staged to foreground exactly that part. Between chapters, the product transitions — rotates, moves closer, gets sliced, changes state.

The chapter titles should be nouns and concrete, not benefits. "The Last Quarter-Inch." "02 — The Cut." "Built on Full Canvas." "The Bath." Not "Superior Comfort" or "Premium Materials" — those are benefit claims, and benefit claims are what a feature grid contains.

Three chapters is the minimum for the format to read as chaptered. Five is comfortable. Beyond six, users start scrubbing.

Read `references/chapter-scroll.md` for the pinning, transition, and HUD implementation.

### On specification

Counterintuitive but important: after five screens of near-empty composition, a **dense** block of small technical type is enormously satisfying and reads as confidence. Materials, dimensions, weights, origins, standards, times. Small type, tight leading, in two or three columns, aligned to the rulers.

This is the one place on the page where the density budget from `premium-webcraft` is deliberately inverted, and it works *because* everything around it is empty. It also does real persuasive work — specificity is more convincing than adjectives.

### On the offer

One CTA. Not "Buy now" alongside "Learn more" alongside "Join waitlist" — the choice dilutes the action.

Show the price plainly. Hiding price behind "Contact us" on a page whose entire purpose was to build desire wastes the desire. If the product genuinely is enquiry-only, say so in the same confident register: "By appointment."

Read `references/conversion.md` for pricing, variant selectors, and CTAs in the premium register — including how to handle multi-variant products without turning the page into a store.

## The product imagery is the project

More than half of the quality of a page like this lives in the product shots. A perfect layout around flat, evenly-lit, white-background product photos will not read as premium, because the entire aesthetic depends on **one object in a dark or empty space with directional light**.

Read `references/product-staging.md` before sourcing or generating any imagery. It covers the shot list the score requires, the lighting setup, background treatment, how to keep a generated set consistent, and how to composite a product convincingly into a void.

The minimum viable set is: one silhouette/edge-lit shot, one full hero shot, one tight detail per anatomy chapter, one in-context shot. Every shot must share the same key-light direction and the same background treatment or the page falls apart at the seams.

## What this page does not contain

Actively resist these; each one pulls the page back toward generic e-commerce:

- A three-column feature grid with icons
- A testimonial carousel or star ratings
- An FAQ accordion
- A newsletter signup band mid-page
- A "related products" strip
- A logo wall
- More than one CTA style
- Any section that exists because product pages usually have one

If the client needs those, they belong on a separate page linked from the footer. Their presence here costs more than their absence.

## Build order

1. Run `premium-webcraft` Phase 0 → art direction lock
2. Write `design/page-score.md` — the beat list, the chapter titles, the shot required for each beat
3. Source or generate the image set to that shot list, then colour-grade it as a set
4. Build the full static page with real imagery and no motion; render it in a browser and judge the frozen frame
5. Add Lenis, entrance reveals, then chapter pinning and transitions
6. Add the HUD chapter index and progress rule
7. Run `premium-webcraft`'s critique gate and subtract, then its implementation review
8. Verify in the browser again — see the checks below

## Verify it in a browser

This page type has failure modes that are invisible in code and obvious in a screenshot, so `premium-webcraft/references/verify.md` matters more here than on a static page. Beyond the general pass, check specifically:

- **Pin seams.** Screenshot at each chapter boundary. Sections that jump, overlap, or gap mean `ScrollTrigger.refresh()` wasn't called after fonts and images settled.
- **Sequence preload.** Throttle the network and scrub. Frames appearing progressively means the sequence isn't fully loaded behind the preloader, and the effect is broken.
- **Ghosting.** Scrub fast between chapters. Two stills visible at once means a missing `overwrite: "auto"`.
- **Stuck reveals.** Anything still at `opacity: 0` after its section is in view — usually a trigger whose start point was past the element.
- **Reduced motion.** Every chapter must be readable with the OS setting on. The classic bug leaves content permanently hidden.
- **Mobile conversion.** Confirm the pinned sequence actually became stacked sections at 390px rather than a pinned section in a viewport too small for it.

## Reference files

- `references/page-score.md` — every beat in detail, category variants, compression
- `references/product-staging.md` — shot list, lighting, backgrounds, generating a consistent set
- `references/chapter-scroll.md` — pinned chapter implementation, transitions, HUD
- `references/conversion.md` — price, variants, CTA, and the checkout handoff
