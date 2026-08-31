# Conversion in the Premium Register

The offer beat has to actually convert without breaking the register the previous six beats built. Standard conversion-optimisation patterns — urgency banners, badge clusters, three-tier pricing tables — are all legible as sales pressure, and pressure is the opposite of the feeling this format cultivates.

Contents:
1. The principle
2. Price
3. The CTA
4. Variants
5. Reassurance
6. The persistent bar
7. Checkout handoff
8. What to refuse

---

## 1. The principle

The whole page has been building desire through restraint and specificity. The offer beat should feel like **the natural conclusion of that**, not a switch into a different mode.

Concretely: the offer beat uses the same type scale, the same ruler alignment, the same amount of empty space, and the same single accent as everything before it. If a screenshot of the offer beat looks like it came from a different site than the anatomy chapters, it's wrong.

Confidence converts here. A page that has shown the object properly and stated its price plainly is more persuasive than one that adds a countdown timer.

---

## 2. Price

**Show it.** The page exists to create wanting; hiding the number at the moment of wanting wastes it and reads as either embarrassment or a bait-and-switch.

Set the price large — H2 scale or above, in the display face. It's a fact the page has earned the right to state, so state it like one.

```html
<p class="price"><span class="cur">£</span>1,850</p>
<p class="price-note">Includes fitting and two alterations.</p>
```

Currency symbol at 60% of the numeral size, raised slightly, at 62% ink. Small detail, reads as considered.

**Don't strike through a fake original price.** It's the fastest way to make a premium product look like a discount product. If there is a genuine comparison worth making, make it in words: "Comparable bespoke: £4,000+."

**If the product is genuinely enquiry-only**, say so in the same register rather than hedging: "By appointment." "Made to order — enquire for lead time." Never "Contact us for pricing", which reads as evasive.

---

## 3. The CTA

**One.** Not a primary and a secondary. Every additional choice at the decision point reduces the chance of any action.

The button should be the single most accent-coloured thing on the page, and — because the accent budget is under 5% of any screen — that scarcity is exactly what makes it pull.

Two treatments that work in this register:

**Outlined.** A hairline rectangle in the accent, accent text, transparent fill. On hover, the fill wipes in from the bottom and the text inverts. Restrained, and the standard for luxury.

```css
.cta {
  position: relative; overflow: hidden;
  padding: 1.1rem 2.75rem;
  border: 1px solid var(--accent);
  color: var(--accent);
  font: 500 var(--t-chrome)/1 var(--font-ui);
  letter-spacing: 0.18em; text-transform: uppercase;
  background: none; cursor: pointer;
}
.cta::before {
  content: ""; position: absolute; inset: 0; background: var(--accent);
  transform: scaleY(0); transform-origin: bottom;
  transition: transform 420ms var(--ease-out); z-index: -1;
}
.cta:hover { color: var(--ground); }
.cta:hover::before { transform: scaleY(1); }
.cta:active { transform: scale(0.985); }
```

**Solid.** Filled accent, ground-coloured text, square or fully pill — never a mid-range radius. On hover, a subtle brightness lift and a magnetic pull toward the cursor.

**Label it with the action and the object.** "Book a Fitting", "Reserve Yours", "Order the Smash" — not "Get Started", "Learn More", or "Submit". A specific verb performs better and fits the register.

Give it real hit area — minimum 48px tall — and a visible focus ring for keyboard users.

---

## 4. Variants

Most single-product pages need at most one variant axis. Two is manageable. Three means this is a catalogue and needs a different page type.

**Colour or material:** small circular or square swatches in the actual material, 28–36px, with the active one ringed in the accent. Changing the swatch should change the product image on screen — that live response is the most satisfying interaction on the page and it's worth the extra shots.

**Size:** a row of chrome-sized labels with a hairline underline on the active one. Include a sizing link, don't inline a size chart.

**Never a native `<select>`.** It renders with OS chrome and instantly breaks the register. Build the control.

Preload the alternate images so switching is instant. A variant swap that shows a loading gap undoes the effect entirely.

If a variant is out of stock, dim it to 38% ink and mark it plainly. Don't hide it — hiding options makes the range look thinner than it is.

---

## 5. Reassurance

One line, chrome size, under the CTA. Not a row of badge icons.

> Free shipping · 30-day returns · Made in Naples

Or the single most relevant fact: "Ships in 3–5 days." "Handmade to order — six weeks."

If there's a real guarantee or a real certification, state it in words. Badge graphics — padlocks, shields, generic "SECURE CHECKOUT" seals — read as low-trust rather than high-trust, because they're the visual language of sites that need to insist.

---

## 6. The persistent bar

On a long page, users who decide at chapter three shouldn't have to scroll to the end. A slim sticky bar solves this without disrupting the composition:

- Appears only after beat 2, once desire has been established
- Full-width, 56–64px, ground+1 background, hairline top border
- Product name and price at chrome size on the left, compact CTA on the right
- Slides up on scroll-up, hides on scroll-down
- Hidden entirely while the offer beat is in view — two CTAs on screen is a conflict

Keep it genuinely slim. A tall persistent bar competes with the page and reads as an ad rail.

---

## 7. Checkout handoff

The moment the user leaves this page is where premium pages most often collapse, because they hand off to a default platform checkout with a completely different visual language.

Options, best to worst:

1. **In-page purchase** — a drawer or overlay using the page's own tokens, backed by Stripe Checkout or a headless commerce API. Most work, best result.
2. **A styled platform checkout** — Shopify and most platforms allow enough theming to at least carry the fonts, ground colour, and accent across. Worth the hour.
3. **A raw platform redirect** — acceptable only if flagged to the user as a known seam.

At minimum, carry the typeface and the ground colour across the boundary. Even that much continuity substantially reduces the jarring effect.

If the CTA is an enquiry rather than a purchase, build the form in-page: three fields maximum (name, contact, one free-text line), same type system, same button, inline validation, and a confirmation state that stays in the page's register rather than an alert.

---

## 8. What to refuse

If the user asks for these, explain the cost rather than silently complying — they will measurably damage the page's register, and often the conversion too:

- **Countdown timers and "only 3 left"** — the highest-pressure, lowest-trust pattern there is, and unmistakably at odds with a page built on restraint
- **Exit-intent popups** — the desire this page builds does not survive being interrupted
- **A mid-page newsletter band** — put it in the footer
- **Star ratings and review counts** in the offer beat — belongs on a separate reviews page if it belongs anywhere
- **Multiple CTAs** competing at the decision point
- **Trust badge clusters**
- **Discount code fields** on the page itself — they invite the user to leave and search for a code

Say plainly that these will cheapen a page whose entire persuasive mechanism is confidence, and offer the alternative: put social proof in its own quiet beat before the offer, put the newsletter in the footer, and let the price stand on its own.
