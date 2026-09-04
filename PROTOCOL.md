---
type: protocol
status: current
owner: user
updated: 2026-08-28
---

# PROTOCOL — research document management

Purpose: minimal user cognitive debt, AI-friendly, minimal slop.
Two principles: **layering and distillation of information**, and **one fact, one
home** — link, never copy.

## Layout

```
CLAUDE.md            AI behavior (contains the block pointing here)
PROTOCOL.md          this file
docs/
  README.md          the map. entry point for all work
  journal.md         user's understanding & narrative. owner: user — AI must not write,
                     but reads it: at session start, on every root replacement, and
                     in /check (journal ↔ adopted/rejected contradictions → QUEUE)
  ENV.md             experiment infrastructure, paths, data
  QUEUE.md           pending user judgments. AI-registered same turn, one-liner
                     history, 7-day staleness reminders, flushed on item close
  inbox/             user requests & ideas
  plan/              open items. item = folder (item.md + exp files)
  adopted/           reference docs of what we carry forward — the core, fully
                     explained. approval-gated
  rejected/          one-page distillates of what we set down. cause of death required
  research/          external-work notes + delegated-agent raw reports. slop-tolerant;
                     lifecycle = orphan collection (see Lifecycle)
  archive/           closed items' raw folders, moved wholesale. frozen
  _templates/        idea / item / experiment / adopted / rejected / source / stack
tools/lint.sh        mechanical integrity checks (run from repo root)
runs/<item>/eNNN/    experiment artifacts, 1:1 with exp files. deleted on close
```

## Lifecycle

```
inbox/<anything>.md
  → (user's open call → /register) plan/<item>/ created: source moved in as
    <item>-idea.md, item.md + experiments accumulate
  → (user verdict) distillate written:
      adopt  → adopted/<item>.md    reference doc, as long as the core requires
                                    ★ cannot enter without user approval
      reject → rejected/<item>.md   one page ★ cause of death, one line, required
    raw folder moves wholesale to archive/<item>/. frozen thereafter; its exp files
    get `status: archived` (runs/ is gone, the mirror check no longer applies)
    runs/<item>/ is batch-deleted (user approval required; the close draft lists what
    will be deleted). Adopted items first freeze a reconstruction snapshot into
    adopted/<item>/ — deletion is safe because the doc + snapshot suffice to rebuild.
```

- adopted/ and rejected/ are distillate layers — reading only them gives the full
  picture. Distillation means process noise removed, not shortness: an adopted doc
  explains its core completely (its Summary section is the scan layer); a rejected
  doc is one page. Raw evidence lives in archive/.
- 100 experiments may pile up; the distillate survives, the pile goes to archive.
- Revival: delete rejected/<item>.md (absorb its cause line into item.md), move the folder
  back from archive/ to plan/, add `revived: <date>` to front-matter. Never copy —
  one fact, one home.
- research/ is slop-tolerant: delegated-agent raw reports live there as-is
  (distillation loses information). Its lifecycle is orphan collection, not time:
  a research file that no live doc [[link]]s (outside research/ and archive/) is
  surfaced by lint as a delete candidate; deletion only with user approval, and a
  "keep" verdict adds `keep: true` front-matter so the file is never surfaced again.

## Naming

- item: short kebab slug (`reg-timing`, `eval-metric`). Registry = plan/README.md.
- exp file: `<item>-eNNN-<slug>.md` (e.g. `reg-timing-e004-late-start.md`).
  The item prefix guarantees vault-wide uniqueness. 3-digit counter per item.
- artifacts: `runs/<item>/eNNN/` — 1:1 mirror of the exp file.
- Filename = permanent id from registration onward. Files move between folders but are
  never renamed ([[links]] resolve by filename). The one rename: /register moves the
  informal inbox file in as `<item>-idea.md` — inbox/ filenames carry no identity.

## Experiment granularity

**One exp file = one question.** A ladder or sweep over a knob is ONE exp file:
preregister the axis and per-rung predictions as a table, append measured rows as they
land (artifacts under `runs/<item>/eNNN/<rung>/`). Open a new exp file only when the
question changes — new axis, new mechanism, new regime. Splitting per hyperparameter
value is slop.

## Folder README format

Every folder's README.md = ① listing (name · one line · status) ② log (date · in/out ·
one-line reason). When it exceeds a screen, delete oldest log lines first.
Inside an item folder, item.md doubles as the README.

## Front-matter (obsidian style)

`type / status / owner / updated`, plus three role fields: `item` (exp files),
`revived` (revived items), `keep` (research files exempt from orphan collection).
Nothing else. Links go in the body as [[filename]].

## Write permissions

| Area | Rule |
|---|---|
| journal.md | user only |
| inbox/ | user directly, or AI via skill — **must embed the user's words verbatim** |
| adopted/ | AI drafts → placed only after user approval |
| rest of docs/ | AI freely, but creations/moves are reported as one-line diffs (skill receipts count) |
| archive/ | contents frozen; only README log lines are appended (moves in/out) |

## Experiment procedure

1. **Preregister**: create the exp file before running — question, hypothesis,
   method. Metrics are an optional field; there are no success/failure criteria.
2. **Run & observe**: raw numbers/logs go to runs/; the doc gets only what judgment needs.
   Always record where results diverged from prediction.
3. **Verdict**: status changes (adopt/reject/promote/confirm) happen only through the
   user's explicit words. Suggestion- or question-form utterances ≠ approval.
   Perceptual quality calls belong to the user, not to metrics.
4. **Check**: sessions quietly stop — there is no end-of-session ritual. Document
   health is audited on demand via /check: lint findings fixed when unambiguous,
   research/ orphans presented as delete candidates (user-gated), stray chat
   information filed to its destination.

## Constraints — the user can be wrong too

A constraint the user imposes on an item ("only epipolar init", "no extra memory")
is recorded in item.md under Constraints, verbatim, with the user's one-line reason.
A constraint arriving without a reason is registered and the reason asked for as a
decision request — stating the reason is what exposes a superficial one. The AI
cannot judge the depth of the user's understanding; it can only surface collisions
with recorded evidence ([execute] checklist `evidence`) and with the method's known
failure modes (`cause`). A wrong constraint in an area with no evidence is not
blocked — preregistration turns it into evidence fast: the prediction misses and the
divergence is recorded.

## Intent stack — no ADHD-style work

The intent stack — `stack.md` in the session's scratch directory, outside the repo,
created from docs/_templates/stack.md, living as long as the session — is a dot hierarchy
with three levels, never a fourth:

- **root** — the user's current intent, one line, their words verbatim. The AI never
  paraphrases it.
- **questions** — what is being asked in service of the root, tagged `(item-eNNN)`
  when an exp file exists. Several may be live at once.
- **options** — one line per candidate raised toward a question, with its fate:
  `→ eNNN row | dropped | qN | inbox`. Options are not a log and carry no verdict
  vocabulary: an option that needs the user's judgment becomes a QUEUE entry and keeps
  only the `→ qN` pointer.

Three stores, three roles: QUEUE holds what waits on the user; the stack holds what
the AI's attention is on; plan/README registers everything open. The stack is working
memory, not a document — durable facts leave it through exp records, QUEUE, and inbox.

1. **Attach or unroll.** Every utterance attaches to the lowest existing node it
   serves: a live question → an option line (or nothing, if no state changed) · the
   root → a new question, pushed · neither → the root itself is up for replacement.
   Replacement is an unroll: the AI proposes the new root and, the same turn, a
   disposition for every hanging question (done / inbox / drop) as decision requests,
   plus one line comparing the new root with journal.md's stated direction. A quiet
   drift of intent is impossible because every root change forces this.
2. **Questions attach to the root directly.** A question that only makes sense via a
   sibling question (a chain) is a drift signal — flagged, default disposition inbox.
   Nothing nests under a question: a derived question is a sibling exp or an inbox
   item, the same move as extracting a function instead of writing a comment.
3. **Execution words bind to a question, never to the last utterance.** Option lines
   are the experiment's rows, not the experiment. Entering [execute] runs a four-line
   checklist; each line is one line, "none" is a valid answer:
   - `slice` — root → bound question → all of its option lines (sibling questions
     omitted).
   - `cause` — the observed failure, and whether the bound question addresses its
     cause or a symptom: name the method's known failure modes (1–3); if the
     observed failure matches one the question does not cover, propose the sibling
     question before running. This is where the AI's domain knowledge is forced out
     instead of waiting to be asked.
   - `evidence` — any row contradicted by adopted/, rejected/, or a prior exp: cite
     it and ask before proceeding. Compliance after citation is allowed; silent
     compliance is not.
   - `bundle` — sibling options at the same level that can ride the same run.
4. **Read** after a compaction, at session start, and when the user injects a goal.
   **Write** on events only, the same turn: push, an option's fate change, pop,
   [execute] entry, root replacement. Context is not storage.
5. Reports do not recite the stack: a push or pop is a one-line diff.
6. **Pop.** A resolved question folds its options into the exp record and its bullet
   is removed; an item's questions leave when the item closes. Nothing floats.

## Integrity checks

tools/lint.sh — mechanical checks documents cannot do on themselves: [[link]]
resolution, duplicate filename ids, plan items listed in plan/README, exp status ↔ runs/
mirror, adopted snapshot presence, research/ orphans. Run via /check.

## Anti-slop

1. New documents, folders, or sections outside docs/_templates = decision request.
2. Length sense (not a hard rule): a README fits one screen; a rejected distillate fits
   one page; an adopted doc is as long as explaining its core requires — length spent
   on the core, never on process narrative. When something grows, consider deletion
   before splitting.
3. One fact, one home. Never copy; link. Exception: adopted/<item>/ reconstruction
   snapshots — frozen copies (verify script, champion config, key code) made at close
   so originals can be discarded. Insurance, not a second home; never edited.
4. No meta-speech — "let me show you", "here's how I interpreted" are noise.
   Content only.
5. Beautiful code over verbose comments. Same for documents.
