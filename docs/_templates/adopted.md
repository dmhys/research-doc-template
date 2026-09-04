---
type: adopted
status: current         # current | superseded
owner: ai               # placement requires user approval
updated: YYYY-MM-DD
---

# {item} — one-line definition

<!-- Reference doc, not a summary card. Whoever reuses this method reads this document
     and must not need archive/. Distillation here means process noise removed and the
     core fully explained — not shortness. Depth is opt-in: Summary is the scan layer.
     The unit of preservation is the explanation + verification protocol, not the code. -->

## Summary
<!-- a few lines: what was adopted and why it matters. Reading only this must be
     enough to decide whether to read on. -->

## Definition
<!-- the full math/mechanism. Notation self-contained. As long as the core requires. -->

## Why it works — evidence
<!-- the reasoning that survived, and the experiments that decided it: [[exp]] links,
     the numbers that mattered, alternatives that lost (link [[rejected]] items). -->

## Boundary conditions
<!-- where it applies, where it breaks. Only ones actually observed. -->

## Conventions & pitfalls
<!-- only traps a reimplementation would step on again: coordinate conventions,
     normalization, off-by-half, numerical stability. Only ones actually stepped on. -->

## What verification guarantees
<!-- verify script path + what passing it proves about an implementation. -->

## Champion configuration
<!-- reproduction excerpt. Artifacts by snapshot path (adopted/{item}/), never runs/. -->

## Code
<!-- current implementation path. This document + verification must suffice
     to discard and rewrite it. -->

## Log
<!-- one line per re-verification or port. Source: archive/[[{item}]]. -->
