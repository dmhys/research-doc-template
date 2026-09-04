---
type: queue
status: current
owner: ai
updated: 2026-09-01
---

# QUEUE — user judgment queue

Rules:
1. The moment the AI asks the user for a judgment, it is registered here — same
   turn, with an id (qN). Context is not storage.
2. Resolution: one-liner history in Log — `qN (date) "verdict quote" → outcome`.
   The Open entry is removed; the one-liner is what history keeps.
3. Open items older than 7 days are surfaced as a reminder in the next report.
   QUEUE only — plan/ and inbox/ are the user's own and get no reminders.
4. When an item closes (/close), queue entries tied to it are flushed in the same
   pass (one-liner in Log, marked flushed).

Reports end with `QUEUE: N` (N = Open count).
Open entry: `- qN (YYYY-MM-DD) [item|—] question`. Ids are global and never reused.

## Open

## Log
