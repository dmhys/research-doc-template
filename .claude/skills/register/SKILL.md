---
name: register
description: Register an inbox idea as a plan item — quote the user's open call, choose the item id, move the inbox file into plan/<item>/ as <item>-idea.md, create item.md (source link, constraints verbatim), list it in plan/README. The only path from inbox/ to plan/.
---

# register — open an item

Intent: the inbox → plan transition is the most frequent one and one of the three the
user approves. It must leave one id, one source file, and one registry line — never a
paraphrased copy of the idea. Inbox files are informal (the user may throw anything in);
the permanent id is born here, so this is the one place a file is renamed.

## Precondition

The user's explicit open call (quotable) naming the inbox entry. Question- or
suggestion-form utterances ("should we start this?") are not it. Without it, do not
run this skill.

## Procedure

1. Item id = short kebab slug, the user's if they gave one, else proposed in the reply.
   Must not collide with plan/README, adopted/, rejected/, archive/.
2. `mkdir docs/plan/<item>/` · `mv docs/inbox/<file>.md docs/plan/<item>/<item>-idea.md` —
   the verbatim source travels with the item, renamed once; nothing is copied. Contents
   untouched.
3. Create `docs/plan/<item>/item.md` from the [[item]] template:
   - `What this item tries to solve` = two or three sentences + `[[<item>-idea]]` link to
     the moved source file.
   - `Constraints` = every constraint in the user's words so far, verbatim, each with
     their one-line reason. A constraint without a reason is written down and the
     reason asked for in the same reply.
   - `Current conclusion` = "none yet". Leave the rest empty.
4. One listing line in plan/README.md; one log line each in plan/README.md (in) and
   inbox/README.md (out), quoting the open call.
5. Do not create the first exp file and do not push a question onto the intent stack
   — what the item asks first is the user's next utterance, not this skill's guess.
6. Reply with the mode tag, the item path, the constraint-reason questions if any, and
   `QUEUE: N` — nothing else.

## Forbidden

- Registering without the open call. Rewriting or summarizing the source file's contents.
- Copying the inbox file instead of moving it. Creating exp files or stack entries here.
