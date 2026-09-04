---
name: close
description: Item closure — quote the user's verdict, write the distillate (adopted: full reference doc · rejected: one page), place into adopted (approval) or rejected (cause of death), freeze the raw folder into archive, update READMEs.
---

# close — item closure

Intent: prevent closed items from lingering as zombies in plan/, or vanishing into
archive/ undistilled.

## Precondition

An explicit closing verdict from the user (quotable). Without it, do not run this skill.

## Procedure

1. Finalize `plan/<item>/item.md`: current conclusion + experiment log (status: closed);
   every exp file in the folder gets `status: archived`. Steps 1–5 are one pass — a
   closed item never rests in plan/.
2. Write the distillate:
   - adopt  → `adopted/<item>.md` ([[adopted]] template: summary · definition ·
     evidence · boundaries · pitfalls · verification · champion config · code).
     A reference doc, as long as the core requires — the reader must not need archive/.
   - reject → `rejected/<item>.md` ([[rejected]] template, one page: what was tried,
     **cause of death**, evidence, revival conditions)
3. For adopt: stage the reconstruction snapshot in `plan/<item>/snapshot/` — verify
   script, champion configuration, key code files, minimal measured artifacts.
   Frozen copies; the doc + snapshot must suffice to rebuild without runs/. Nothing
   touches adopted/ before step 5.
4. **Submit the draft. An adopted placement never happens without approval.**
   For rejected, confirm the cause-of-death wording. The draft also lists
   `runs/<item>/` contents/size slated for deletion.
5. After approval: place the distillate, move `snapshot/` to `adopted/<item>/` → move `plan/<item>/` wholesale
   to `archive/<item>/` → **batch-delete `runs/<item>/`** → one log line each in
   plan/adopted|rejected/archive READMEs → bump docs/README.md `updated`.
6. Present the item's Open branches; ones worth keeping
   become inbox entries (user decides). Flush docs/QUEUE.md entries tied to the
   closed item (one-liner in its Log, marked flushed). Remove the closed item's subtree
   from the intent stack.
