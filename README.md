# research-doc-template

An anti-AI-slop document template for research.

This is closer to a micro-managing tool. Auto mode is under development.

한국어: [README.ko.md](README.ko.md)

## For humans

No TL;DR. Purpose is worth reading; Usage must be read.

### Purpose

AI-assisted research produces faster than a human can verify, and the gap accumulates as cognitive debt. This repo was shaped empirically, through repeated trials, to block the following failure modes that kept recurring in AI-assisted research.

- Information overload
- Evaporating judgments / wrong instructions
- Missing goal alignment
- Execution hurdles / context cost
- Missing consistency / file management

#### Information overload — accelerating cognitive debt

More text piles up than the research needs; reading gets hard and debt grows. The gap between what is needed and what is delivered is wide, and information arriving without hierarchy accelerates it.

1. Reduce the absolute amount of slop with anti-slop rules
    - Minimize useless padding in conversation
    - Drop unnecessary comments and verbose information

2. Information that is hard to digest because hierarchy is lost
    - Whatever is fetched is always summarized and classified before delivery

3. Documentation sprawl
    - Trying to organize into documents produces hundreds of documents
    - A document lifecycle that keeps only the final distillates in sight

4. Homework for cognitive debt (optional)
    - Separate the AI's document territory from the user's
    - A journal the user maintains alone
    - What the user does not understand can be submitted for inspection later

#### Evaporating judgments / wrong instructions

One turn brings too much information plus several questions about the user's intent; answering some of them makes the rest — including the ones that needed a judgment — disappear.

1. Judgments requested from the user are tracked explicitly
    - This list cannot vanish quietly
    - Every report ends with the QUEUE count

2. No implicit consent
    - The AI tends to treat an unanswered question as consent
    - Judgments only through explicit utterances

3. The user's wrong instructions
    - Plan B for ultimate goal A, then a demand to proceed with C, which is barely related or excludes a better method
    - Why the same request yields results for one person and not another — the AI knows better but puts the user's demand first
    - A goal-alignment check at execution time, as a small safeguard against unconditional execution

#### Missing goal alignment

Research keeps diverging as a stream of consciousness, attending only to the latest context.

1. No explicit goal in context
    - The goal that mattered at the start disappears; the last request is re-synthesized as the main goal
    - A goal like "run the ablation" depends heavily on the sub-option mentioned last, not on the conversation so far
    - The current intent lives in a file (the intent stack)
    - Read after compaction · at session start · on goal injection
    - The intent stack manages the execution options / exploration list of the current intent

2. Quiet drift
    - Question after question, intent shifts a little each time, like resynthesis noise. No step is a jump, but the destination is elsewhere
    - The intent stack tracks it, so drift triggers an intent unroll
    - The unroll re-anchors

3. Zombie items
    - Half-finished work lingers everywhere as open loops
    - Items are managed by /close verdicts

#### Execution hurdles / context cost

One exploratory question changes files and launches a multi-hour job. Conversely, a misplaced watch or repeated checking burns the whole context again.

1. Runaway execution
    - Interaction is split into two modes
    - [pingpong] is the default — exploration and light doc/code edits only
    - [execute] only by the user's explicit entry words — scripts run only here
    - "Wouldn't X work?" and "I hope Y" are not triggers
    - [execute] comes after an explicit trigger and a rigorous goal statement in [pingpong]

2. Managed to stay inside the KV-cache window
    - Ambiguous runs pile up past the KV-cache lifetime, and re-encoding costs grow
    - "Test B?" does not run just B. Sibling options at the same abstraction level are bundled into one exp · one run
    - The net effect is defragmenting the user's uptime/downtime

#### Missing consistency / file management

As files multiply, consistency slips (SSOT violations). There is no file hierarchy.

1. A document lifecycle
    - inbox (idea) → plan → adopted/rejected. Details go to archive
    - Failed ideas are not listed mechanically; they are grouped hierarchically by item, reachable while saving context
    - In the end, an idea's many results are distilled again so one item can close as one document

2. Mechanical checks
    - tools/lint.sh: link resolution · duplicate ids · plan listing · run ↔ exp mirror · snapshots · research orphans. Run on demand via /check
    - Idea and document slop left by quiet session endings is inspected by /check, then salvaged or discarded

3. SSOT across documents
    - Link, never copy. The one exception is the adopted reconstruction snapshot

4. Verbatim preservation
    - The user's words are never restated by the AI
    - Beyond refining a request, the user's original demand risks dilution when relayed to an agent

5. Disk slop
    - Artifacts of dead experiments accumulate endlessly, with no file management at session end
    - Results are tracked from docs, and the disk is cleaned along the document lifecycle

### Usage

Guidance on artifact locations covers only experiment results (runs/); the rest is deliberately left open.

#### Adoption

- Adopting this into an existing repo is left to the AI — see "AI adoption procedure" below.
- On adoption, the contents of CLAUDE.plugin.md are added as instructions to the project root's CLAUDE.md.
- Pre-existing documents move only after the AI proposes a destination table and the user rules on it.

#### Three document states

```
inbox (idea) → plan/<item>/ (experiments accumulate) → adopted (carry forward, approval-gated)
                                                     | rejected (set down, cause required)
                                                     └ raw folder frozen into archive/
```

- Ideas go to `docs/inbox`. Put them there directly, or refine them with the AI in chat (`/inbox`)
- When promoted to an execution unit, `/register` concretizes it and moves it into `docs/plan`. The subfolder holds that idea's experiments too
- `/close` adopts or rejects
    - Adopt: results are distilled to a reproducible level and written up as a report
    - Reject: results are discarded more aggressively; only a record of the attempt is distilled

#### Separate places for the user's documents

The user actually writes in two places.

- `docs/inbox` — as above
- `docs/journal.md` — the user's understanding and dev log. The AI reads it, never writes it: at session start, on intent replacement (unroll), in /check. When a result contradicts a claim in the journal, the AI raises it as a question. (optional)

#### Decisions go through the Queue

- `docs/QUEUE.md` holds the set of pending decisions.


## AI adoption procedure (how an AI adopts this into a research repo)

1. Copy `PROTOCOL.md`, `CLAUDE.plugin.md`, the `docs/` skeleton (templates included),
   `.claude/skills/`, `tools/` into the target repo root.
2. At session start, create `stack.md` in the session scratch directory from
   `docs/_templates/stack.md` (root = the user's first request, verbatim). Nothing is added
   to the repo.
3. Fill `docs/ENV.md` with the project's infrastructure (backends, data, gates,
   landmines).
4. Read every pre-existing doc and propose a destination for each, one line of
   reason per doc: `inbox` (idea, not yet worked) · `plan/<item>` (live work — goes through /register, the doc as source) ·
   `adopted` (a result already carried forward — draft its reference doc) ·
   `rejected` (a dead end — cause of death required) · `research` (external notes) ·
   `archive` (frozen evidence) · delete. Nothing moves until the user rules on the
   table; the user's verdicts are quoted in the destination READMEs' log lines.
5. Merge the block in `CLAUDE.plugin.md` into the target repo's CLAUDE.md.

## Contents

| Path | What |
|---|---|
| PROTOCOL.md | Full convention: layout, lifecycle, naming, write permissions, constraints, intent stack, anti-slop |
| CLAUDE.plugin.md | Behavior block to merge into a repo's CLAUDE.md |
| docs/ | Skeleton (README/journal/ENV/QUEUE + inbox/plan/adopted/rejected/research/archive) |
| docs/_templates/ | idea · item · experiment · adopted · rejected · source · stack |
| .claude/skills/ | /inbox (file an idea, verbatim) · /register (open into plan/) · /check (document inspection) · /close (item closure) |
| tools/ | doc-lint: mechanical integrity checks (links · duplicate ids · plan listing · runs mirror · snapshots · orphans) |
