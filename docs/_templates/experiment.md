---
type: exp
item: {item}
status: preregistered   # preregistered | running | done | void | archived (set on close)
owner: ai
updated: YYYY-MM-DD
---

# {item}-eNNN — one-line title

<!-- filename = {item}-eNNN-{slug}.md · artifacts = runs/{item}/eNNN/
     ONE exp file = ONE question. A sweep/ladder over a knob lives HERE as table rows
     (artifacts under runs/{item}/eNNN/{rung}/) — not as separate files. -->

## Why
<!-- which prior result or dead end this follows from. Link [[{item}]] and prior [[exp]]s. -->

## Hypothesis & predictions
<!-- falsifiable, written before running. For a ladder: per-rung predictions as a table.
     A pure measurement with no bet: `none (probe)`. -->

## Metrics (optional)
<!-- what will be measured, if anything is decided up front. Plain list, no verdict logic. -->

## Method
<!-- one-line reproduction command + config diff vs baseline. For a ladder: the axis and rungs. -->

## Observations
<!-- raw data stays in runs/. Only what judgment needs. For a ladder: measured rows appended
     next to their predictions. Divergence from prediction must be recorded. -->

## Interpretation
<!-- separate confidence from speculation. If this section is empty, the document is unfinished. -->

## Verdict
<!-- quote the user's words. Absent quote = no verdict. Reflect one line into item.md's log. -->
