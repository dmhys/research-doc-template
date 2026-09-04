---
name: check
description: On-demand document inspection — run lint, fix unambiguous mechanical violations, surface delete candidates (research orphans) and file stray information. Audit, not classification ritual.
---

# check — document inspection

Intent: sessions rarely end cleanly — they quietly stop. So document health is
checked on demand, not at session end. Filing itself is the lifecycle's job
(exp records as results land, /inbox for ideas, /close at item end); this skill
audits what the lifecycle missed.

## Procedure

1. Run `tools/lint.sh`.
2. Handle findings:
   - mechanical violations (broken links, unlisted plan items, missing runs/
     mirrors or snapshots) → fix immediately when the fix is
     unambiguous; otherwise propose it
   - research/ orphans → present as delete candidates. **Deletion only after the
     user's word.** A "keep" verdict → add `keep: true` front-matter so the file
     is never surfaced again
   - information sitting only in chat that belongs in a doc → file it to its
     PROTOCOL destination (exp file, ENV.md, inbox — verbatim rule applies)
3. Read journal.md against adopted/ and rejected/: a claim in the journal that a
   distillate contradicts is surfaced as a QUEUE question ("journal says X,
   [[adopted/y]] says Y — which is wrong?"). Never edited by the AI either way.
4. Report: receipt of what was applied (one line each) + delete candidates as
   decision requests. End with `QUEUE: N`.

## Forbidden

- Deleting anything without approval. Writing to journal.md.
- Turning the report into a classification ritual — findings only, no inventory
  of healthy files.
