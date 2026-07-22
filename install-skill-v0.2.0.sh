#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="${1:-$ROOT/dist}"
ARCHIVE="$OUT/math-semester-preview-site-skill-v0.2.0.zip"
EXPECTED="2a51b6dc10c6aafdadd1f282bbb1b527034745e2d88763f7dd86d655f8a6a51e"

mkdir -p "$OUT"
cat "$ROOT"/.skill-upload/part-*.b64 | base64 -d > "$ARCHIVE"

if command -v sha256sum >/dev/null 2>&1; then
  ACTUAL="$(sha256sum "$ARCHIVE" | awk '{print $1}')"
elif command -v shasum >/dev/null 2>&1; then
  ACTUAL="$(shasum -a 256 "$ARCHIVE" | awk '{print $1}')"
else
  echo "缺少 sha256sum 或 shasum，无法校验归档。" >&2
  exit 2
fi

if [[ "$ACTUAL" != "$EXPECTED" ]]; then
  echo "SHA-256 校验失败：$ACTUAL" >&2
  exit 1
fi

rm -rf "$OUT/math-semester-preview-site"
unzip -q "$ARCHIVE" -d "$OUT"
test -f "$OUT/math-semester-preview-site/SKILL.md"

echo "Skill v0.2.0 已还原并校验："
echo "$OUT/math-semester-preview-site"
echo "ZIP: $ARCHIVE"
