#!/usr/bin/env bash
# HyperFrames render wrapper for OpenClaw agents
# Usage: ./scripts/render.sh <composition-dir> [output-dir]
set -euo pipefail

COMPOSITION_DIR="${1:?Usage: render.sh <composition-dir> [output-dir]}"
OUTPUT_DIR="${2:-$COMPOSITION_DIR/renders}"

cd "$COMPOSITION_DIR"

# Check dependencies
if ! command -v npx &>/dev/null; then
  echo "ERROR: npx not found. Install Node.js >= 22."
  exit 1
fi

if ! command -v ffmpeg &>/dev/null; then
  echo "ERROR: ffmpeg not found. Install ffmpeg."
  exit 1
fi

# Lint first (non-blocking)
echo "Linting composition..."
npx hyperframes lint 2>/dev/null || echo "WARN: Lint had issues, continuing..."

# Render
echo "Rendering composition..."
npx hyperframes render --non-interactive

# Find the output
LATEST_RENDER=$(ls -t renders/*.mp4 2>/dev/null | head -1)

if [ -n "$LATEST_RENDER" ]; then
  SIZE=$(du -h "$LATEST_RENDER" | cut -f1)
  echo "SUCCESS: $LATEST_RENDER ($SIZE)"
  
  # Copy to output dir if specified
  if [ "$OUTPUT_DIR" != "$COMPOSITION_DIR/renders" ]; then
    mkdir -p "$OUTPUT_DIR"
    cp "$LATEST_RENDER" "$OUTPUT_DIR/"
    echo "Copied to: $OUTPUT_DIR/$(basename "$LATEST_RENDER")"
  fi
  
  # Output path for agent consumption
  echo "OUTPUT_PATH=$LATEST_RENDER"
else
  echo "ERROR: No MP4 found in renders/"
  exit 1
fi