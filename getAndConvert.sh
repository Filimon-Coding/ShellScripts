#!/usr/bin/env bash
# getAndConvert_wkhtml.sh – mirror + convert with wkhtmltopdf

set -euo pipefail

die() { echo "ERROR: $*" >&2; exit 1; }

usage() {
  echo "Usage: $0 URL [prefix] [depth]"
  echo "Example: $0 https://…/Utvalgt.html utvalgt 1"
  exit 1
}

[[ $# -lt 1 ]] && usage
URL=$1; shift
if   [[ $# -eq 0 ]]; then PREFIX=output DEPTH=1
elif [[ $# -eq 1 && $1 =~ ^[0-9]+$ ]]; then PREFIX=output DEPTH=$1
elif [[ $# -eq 1 ]]; then PREFIX=$1 DEPTH=1
else PREFIX=$1 DEPTH=$2
fi

command -v wkhtmltopdf >/dev/null 2>&1 || die "wkhtmltopdf not found!"

MIRROR_DIR="${PREFIX}_html"
PDF_DIR="pdfs_${PREFIX}"
URL_PATH=${URL#*://*/}; CUT_DIRS=$(grep -o '/' <<<"$URL_PATH"|wc -l)

echo "⇒ Mirroring to $MIRROR_DIR  (depth=$DEPTH)"
rm -rf "$MIRROR_DIR" "$PDF_DIR"
mkdir -p "$MIRROR_DIR" "$PDF_DIR"

# -------------------------------------------------------------------------
# 1. MIRROR (unchanged)
# -------------------------------------------------------------------------
wget -r -l "$DEPTH" -np -nH --cut-dirs="$CUT_DIRS" -p \
     -A html,htm,png,jpg,jpeg,gif \
     -e robots=off --no-check-certificate \
     -P "$MIRROR_DIR" "$URL"

# -------------------------------------------------------------------------
# 2. CONVERT  (wkhtmltopdf with error-ignore, keeps going)
# -------------------------------------------------------------------------
echo "⇒ Converting with wkhtmltopdf …"
success=0 fail=0
find "$MIRROR_DIR" -type f \( -iname '*.html' -o -iname '*.htm' \) -print0 |
while IFS= read -r -d '' f; do
  base=$(basename "${f%.*}")
  out="$PDF_DIR/${base}.pdf"
  printf '   … %-35s → %s\n' "$base" "$(basename "$out")"
  if wkhtmltopdf --quiet \
                 --enable-local-file-access \
                 --load-error-handling ignore \
                 "file://$(pwd)/$f" "$out"
  then ((success++))
  else ((fail++)); echo "     ✖ failed ($f)" >&2
  fi
done

echo "✓ Done: $success PDF(s) created, $fail failed  →  $PDF_DIR"
