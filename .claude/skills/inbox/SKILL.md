---
name: inbox
description: File the user's idea or request into docs/inbox/ as an entry embedding their words verbatim. No interpretation beyond a slug and a one-line reading.
---

# inbox — file an idea

Intent: capture the user's thought at zero friction, without the AI's interpretation
replacing the user's words.

## Procedure

1. Take the user's utterance **verbatim** — the whole message or the part they pointed at.
   No paraphrase, no cleanup, no translation.
2. Create `docs/inbox/<slug>.md` from the [[idea]] template:
   - `Original request (verbatim)` = the quote. This section is the source of truth.
   - `What` = one-line reading (interpretation, clearly subordinate to the quote).
   - `Why` / `What it buys us` = only if inferable; otherwise leave empty. Do not invent.
3. Pick a short kebab slug that does not collide within inbox/. It is provisional — the
   item id is chosen at /register.
4. Add one listing line + one log line to inbox/README.md.
5. Reply with the mode tag, the file path, and `QUEUE: N` — nothing else. Opening into plan/
   is a separate, later decision (/register on the user's open call) — never in the same breath.

## Forbidden

- Editing the quote. Filling motivation sections with speculation.
- Promoting to plan/ without the user's open call (and outside /register).
