# CLAUDE.md plugin block

<!-- On adoption, merge the block below into the research repo's CLAUDE.md.
     The full convention travels in PROTOCOL.md (repo root). -->

```markdown
## Document system
- Follow PROTOCOL.md (repo root). Enter work through docs/README.md; read only the branch you need.
- docs/journal.md is user-only; the AI reads it at session start and on every root
  replacement, and /check surfaces journal ↔ adopted/rejected contradictions as QUEUE
  questions. docs/inbox/: the user writes directly, or the AI files entries via skill —
  skill-created entries must embed the user's words verbatim.
- User constraints go in item.md Constraints, verbatim with the user's one-line reason;
  no reason → ask. A constraint or request that collides with adopted/rejected/prior
  exp is cited before compliance — never silently obeyed.
- inbox → plan only via /register on the user's open call (source file moved, never copied).
  Nothing enters docs/adopted/ without user approval.
- No end-of-session ritual (sessions quietly stop): document health is audited
  on demand via /check — lint, unambiguous fixes applied, deletions user-gated,
  stray chat information filed. Filing during work is the lifecycle's job
  (exp records, /inbox, /close).
- Close items via /close (verdict quote → distillate [adopted: full reference doc ·
  rejected: one page] → archive move → README logs).
- Status changes (open/adopt/reject/promote/confirm) only through the user's explicit
  words. Suggestion/question-form utterances ≠ approval. Perceptual quality: user's call.
- No run without its exp file first (question, hypothesis, method; metrics optional —
  no success/failure criteria). One exp file = one question; sweeps are rows, not new files.
  Artifacts go to `runs/<item>/eNNN/` (1:1 with the exp file); the exp doc gets only
  what judgment needs, and every divergence from prediction.
- Intent stack: `stack.md` in the session scratch directory (outside the repo, from
  docs/_templates/stack.md) — three levels: root = the user's current intent verbatim →
  questions `(item-eNNN)` → options `→ eNNN row | dropped | qN | inbox`. Attach every
  utterance to the lowest node it serves: question → option · root → push question ·
  neither → propose root replacement and, same turn, a disposition for every hanging
  question (unroll). Questions attach to the root directly; a chain is a drift flag.
  Execution words bind to a question, never to the last utterance; entering [execute]
  runs the four-line checklist — `slice` (root → question → its options) · `cause`
  (observed failure vs the method's known failure modes; uncovered match → propose the
  sibling question first) · `evidence` (rows contradicted by adopted/rejected/exp →
  cite, ask) · `bundle` (same-level siblings ride along). Read after compaction / session
  start / goal injection; write on events only. No recitation — pushes/pops are
  one-line diffs. QUEUE = what waits on the user; stack = where attention is.
- One fact, one home: link, never copy. Files move but are never renamed after /register
  (inbox names carry no identity); archive/ contents
  are frozen (README log lines only). The only copy allowed is the adopted/<item>/ reconstruction snapshot.
- Delegated reports land in research/ and must be [[link]]ed from a live doc, or they
  are orphans. Folder READMEs = listing + log; when a doc grows, consider deletion
  before splitting.
- No meta-speech. Content only. New docs/folders/sections outside docs/_templates = decision request.
- Delegated research: instruct the research agent to verify claims at code level where
  possible (read/run the source, not the abstract), and to separate verified from claimed.

## Interaction modes
- Every response opens with its mode tag: [pingpong] or [execute].
- [pingpong] (default): direction exploration. Output = conclusions and proposals;
  quick file edits are allowed. No job launches, no experiment runs, no long executions.
- [execute]: entered only by the user's explicit execution words + grounds
  (preregistered exp, agreed scope). Only here launch jobs or long runs.
- Question-, suggestion-, and wish-form utterances ("~하면 되지 않나?", "~이길 바라는데")
  are never execution triggers.
- Context economy: when the user points at one option ("test B?"), never just run B.
  Scan the question's sibling memo lines at the same abstraction level; whatever
  can ride the same run (same axis, same setup) is proposed as one bundle — one
  preregistered exp with rows, one execution, one round trip — before entering [execute].

## Reporting contract
- Every answer is structured before delivery: verdict → numbered grounds → decision
  requests. No prose paragraphs. Exception: /inbox and /register replies are receipts
  (mode tag · path · `QUEUE: N`) — the move itself is the diff.
- Verdict first: open with a proposed conclusion (1–3 sentences, marked as proposal —
  promotion still requires the user's words). Never hand the user an inventory and
  leave the synthesis to them: judging one claim is cheap, synthesizing from a pile
  is expensive.
- Every judgment request to the user is registered in docs/QUEUE.md the same turn —
  never left only in chat context. One-liner history on resolution, 7-day staleness
  reminders, flush on item close. Reports end with `QUEUE: N` (open count).
- Decision requests: max 3 per turn, numbered at the end of the message; a disposition
  table (unroll, adoption destinations, orphan list) counts as one. Silence ≠ consent.
- Compression asymmetry: agreement with the user = one marker + delta only;
  disagreement keeps its budget.
- Delete narration, delivery history, and evaluative phrases; encode convergence and
  attribution as markers (◆), not sentences. Low-value info is deleted, not compressed.
  Bold = scan anchor only.
- When relaying the user's words to another agent, tag their epistemic status
  (e.g. "loose example") — otherwise its critique becomes a strawman.

## Code style
- Comments are an abstraction failure. Allowed: API doc comments, and external
  constraints the code cannot express (upstream bug workaround, hardware quirk).
  Nothing else.
- The urge to comment = the moment to extract a named function. Code reads
  top-down as sentences; names do the explaining.
- Rationale lives where the decision lives: a judged decision has an item —
  point to it (one line: the doc name). An unjudged one needs none — names and
  git history carry it. Never inline.
```
