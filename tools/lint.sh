#!/usr/bin/env bash
# doc-lint — mechanical integrity checks a document system cannot do on itself.
# Checks: [[link]] resolution · duplicate filename ids · plan items listed in plan/README ·
# exp status ↔ runs/ mirror (archived exempt) · adopted snapshot presence · research/
# orphans (delete candidates; deletion itself is user-gated).
# Usage: tools/lint.sh [repo-root]     (expects docs/ (with _templates/), runs/ under it)
# Exit 0 = clean, 1 = findings, 2 = not a vault. No dependencies beyond POSIX + bash.
set -u
ROOT="${1:-.}"
DOCS="$ROOT/docs"
RUNS="$ROOT/runs"
found=0
say() { printf 'LINT %s\n' "$*"; found=1; }

[ -d "$DOCS" ] || { echo "doc-lint: no docs/ under $ROOT" >&2; exit 2; }

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# 1. [[links]] resolve — filename = permanent id; root *.md count. _templates/ excluded from the duplicate check.
#    Duplicate ids (same basename twice under docs/) are flagged; README.md and item.md are per folder.
#    Links inside <!-- --> comments (template guidance) are ignored.
find "$DOCS" -path "$DOCS/_templates" -prune -o -name '*.md' -print 2>/dev/null | while IFS= read -r f; do basename "$f" .md; done \
  | grep -vxE "README|item" | sort > "$tmp/names.docs"
for dup in $(uniq -d "$tmp/names.docs"); do say "duplicate filename id: $dup.md"; done
{ cat "$tmp/names.docs"
  find "$DOCS/_templates" -name '*.md' 2>/dev/null | while IFS= read -r f; do basename "$f" .md; done
  find "$ROOT" -maxdepth 1 -name '*.md' 2>/dev/null | while IFS= read -r f; do basename "$f" .md; done
  echo README; echo item; } | sort -u > "$tmp/names"
find "$DOCS" -name '*.md' -print0 2>/dev/null | xargs -0 perl -0777 -ne 's/<!--.*?-->//gs; print' \
  | grep -oE '\[\[[^]]+\]\]' | sed 's/^\[\[//; s/\]\]$//; s/[#|].*$//' | sort -u > "$tmp/links"
while IFS= read -r link; do
  [ -n "$link" ] || continue
  grep -qxF "$link" "$tmp/names" || say "unresolved link [[$link]]"
done < "$tmp/links"

# 2. every plan item folder appears in plan/README.md
if [ -f "$DOCS/plan/README.md" ]; then
  for d in "$DOCS/plan"/*/; do
    [ -d "$d" ] || continue
    name="$(basename "$d")"
    grep -qE "(^|[^A-Za-z0-9-])$name([^A-Za-z0-9-]|$)" "$DOCS/plan/README.md" || say "plan/$name not in plan/README.md"
  done
fi

# 3. exp files: status ↔ runs/ mirror
while IFS= read -r f; do
  base="$(basename "$f" .md)"
  item="$(printf '%s' "$base" | sed -E 's/-e[0-9]{3}-.*$//')"
  enum="$(printf '%s' "$base" | grep -oE 'e[0-9]{3}' | head -1)"
  st="$(grep -m1 -E '^status:' "$f" | sed 's/#.*//' | awk '{print $2}')"
  case "$st" in
    running|done)
      [ -d "$RUNS/$item/$enum" ] || say "$base: status $st but no runs/$item/$enum/"
      ;;
  esac
done < <(find "$DOCS/plan" "$DOCS/archive" -name '*-e[0-9][0-9][0-9]-*.md' 2>/dev/null)

# 4. adopted docs have a reconstruction snapshot dir
for f in "$DOCS/adopted"/*.md; do
  [ -e "$f" ] || continue
  name="$(basename "$f" .md)"
  [ "$name" = "README" ] && continue
  [ -d "$DOCS/adopted/$name" ] || say "adopted/$name.md: no snapshot dir adopted/$name/"
done

# 5. research/ orphans — no live doc (outside research/ and archive/) links the file.
#    Candidates only; deletion is user-gated. `keep: true` in front-matter exempts.
for f in "$DOCS/research"/*.md; do
  [ -e "$f" ] || continue
  name="$(basename "$f" .md)"
  [ "$name" = "README" ] && continue
  grep -qE '^keep:[[:space:]]*true' "$f" && continue
  grep -rqE "\[\[$name([]#|])" "$DOCS" --include='*.md' \
    --exclude-dir=research --exclude-dir=archive 2>/dev/null \
    || say "research/$name.md: orphan (no live [[link]]) — delete candidate"
done

[ "$found" -eq 0 ] && echo "doc-lint: clean"
exit "$found"
