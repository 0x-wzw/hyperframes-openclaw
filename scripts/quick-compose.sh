#!/usr/bin/env bash
# Quick preview: create a composition from a prompt and preview it
# Usage: ./scripts/quick-compose.sh <name> <duration-seconds> [template]
set -euo pipefail

NAME="${1:?Usage: quick-compose.sh <name> <duration> [template]}"
DURATION="${2:-10}"
TEMPLATE="${3:-blank}"
WORK_DIR="/tmp/hyperframes-compose/$NAME"

mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# Init project
npx hyperframes init "$NAME" --non-interactive --template "$TEMPLATE" 2>/dev/null || true

# Set duration in meta.json
if [ -f meta.json ]; then
  python3 -c "
import json
m = json.load(open('meta.json'))
m['duration'] = $DURATION
json.dump(m, open('meta.json', 'w'), indent=2)
"
fi

echo "Composition scaffolded at: $WORK_DIR"
echo "Edit index.html, then run: npx hyperframes render"
echo "Or preview: npx hyperframes preview"