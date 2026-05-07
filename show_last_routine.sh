#!/usr/bin/env bash
set -euo pipefail

ROUTINES_DIR="$(dirname "$0")/routines"

if [[ ! -d "$ROUTINES_DIR" ]]; then
  echo "No routines directory found." >&2
  exit 1
fi

last_file=$(ls -1 "$ROUTINES_DIR"/*.json 2>/dev/null | sort | tail -1)

if [[ -z "$last_file" ]]; then
  echo "No routine records found." >&2
  exit 1
fi

date=$(jq -r '.date' "$last_file")
notes=$(jq -r '.notes' "$last_file")

echo "Last routine: $date"
echo "========================================"
echo ""
jq -r '.recipes[] | "  \(.name)\n    Result : \(.result)\n    Rating : \(.rating)/5\n"' "$last_file"
echo "Notes: $notes"
