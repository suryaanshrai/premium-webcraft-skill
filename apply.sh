#!/usr/bin/env bash
# Stages the rewrite onto a branch. Run from the repo root.
# Requires: premium-webcraft-suite.zip in ~/Downloads
set -euo pipefail

REPO="$HOME/work/premium-webcraft-skill"
ZIP="${1:-$HOME/Downloads/premium-webcraft-suite.zip}"
BRANCH="premium-rewrite-and-product-skill"

[ -f "$ZIP" ] || { echo "Zip not found at $ZIP"; exit 1; }
cd "$REPO"

git checkout -q -B "$BRANCH"

# old layout -> new layout
git rm -rq --ignore-unmatch SKILL.md references

TMP=$(mktemp -d)
unzip -qo "$ZIP" -d "$TMP"
cp -r "$TMP/premium-webcraft" "$TMP/product-launch-page" "$TMP/README.md" .
rm -rf "$TMP"

git add -A
git commit -q -F - <<'MSG'
Rewrite premium-webcraft as a spec; add product-launch-page skill

The previous version was a manifesto. "Double your whitespace" and
"cinematic pacing" can't be executed deterministically, so the model
applied the vocabulary and produced the same density as before.

Two root causes of "works but isn't clean": drift (every section
re-improvising its own type sizes, spacing and greys) and density
(reference-tier pages are overwhelmingly empty; nothing budgeted
subtraction).

Adds:
- The art-direction lock: tokens written to disk before any markup
- Vertical rulers: 2-3 fixed x-positions held site-wide
- Numeric restraint budgets and the 6:1 display:body ratio rule
- Two gates: critique.md for design, implementation-review.md for
  code craft (adapted from Vercel's Web Interface Guidelines)
- verify.md: a real Playwright loop, since "judge the frozen frame"
  previously had no mechanism behind it
- reference-extraction.md: derive the lock from a site, screenshot,
  or DESIGN.md instead of a blank canvas

Demotes WebGL behind a gate. The cleanest reference pages aren't
shader-heavy; leading with WebGL pushes toward complexity, which is
what makes generated output look messy.

Splits single-product landing pages into a companion skill with an
explicit composition contract: art direction wins on visual values,
the page score wins on sequence.
MSG

echo
echo "Branch '$BRANCH' ready:"
git show --stat --oneline HEAD | head -25
echo
echo "Next (needs auth):"
echo "  gh auth login"
echo "  git push -u origin $BRANCH"
echo "  gh pr create --base master --title 'Rewrite premium-webcraft as a spec; add product-launch-page skill' --body-file PR_BODY.md"
