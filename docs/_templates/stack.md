<!-- intent stack — three levels, never a fourth. Lives in the session's scratch
     directory (stack.md), outside the repo. Root = the user's current intent, verbatim.
     Attach every utterance to the lowest node it serves: question → option line ·
     root → new question · neither → root replacement (unroll: dispose every hanging
     question, same turn). Written on events only; read after compaction / session
     start / goal injection. See PROTOCOL "Intent stack". -->

- {root: the user's current intent, their words verbatim}
  - {question}                                              ({item}-eNNN)
    - {option} → {eNNN row | dropped | qN | inbox}
