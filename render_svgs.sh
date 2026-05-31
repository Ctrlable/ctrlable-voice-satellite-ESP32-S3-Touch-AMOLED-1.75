#!/usr/bin/env bash
# Renders all Ctrlable expression SVGs to PNGs for ESPHome consumption.
# Usage: render_svgs.sh [svg_sources_dir] [images_dir] [size]
# Defaults: ./svg_sources  ./images  466

set -euo pipefail

if ! command -v rsvg-convert &>/dev/null; then
  echo "ERROR: rsvg-convert not found."
  echo "  macOS:  brew install librsvg"
  echo "  Debian: apt install librsvg2-bin"
  exit 1
fi

SVG_DIR="${1:-./svg_sources}"
IMG_DIR="${2:-./images}"
SIZE="${3:-466}"

mkdir -p "$IMG_DIR"

render() {
  local src="$1" dst="$2"
  rsvg-convert -w "$SIZE" -h "$SIZE" -b 'rgba(0,0,0,0)' "$src" -o "$dst"
  echo "  $src → $dst"
}

# Returns the mapped output stem for a given source stem, or the stem itself.
map_output() {
  local stem="$1"
  case "$stem" in
    ctrlable_loading)    echo "ctrlable_loading" ;;
    ctrlable_idle)       echo "ctrlable_idle" ;;
    ctrlable_listening)  echo "ctrlable_listening" ;;
    ctrlable_thinking)   echo "ctrlable_thinking" ;;
    ctrlable_replying)   echo "ctrlable_replying" ;;
    ctrlable_timer)      echo "ctrlable_timer_finished" ;;
    ctrlable_mute)       echo "ctrlable_mute" ;;
    ctrlable_alert)      echo "ctrlable_error" ;;
    ctrlable_no_wifi)    echo "ctrlable_error_no_wifi" ;;
    ctrlable_no_ha_file) echo "ctrlable_error_no_server" ;;
    *)                   echo "$stem" ;;
  esac
}

for svg in "$SVG_DIR"/*.svg; do
  [ -f "$svg" ] || continue
  stem=$(basename "$svg" .svg)
  out="$IMG_DIR/$(map_output "$stem").png"
  render "$svg" "$out"
done

echo "Done. Rendered to $IMG_DIR/ at ${SIZE}x${SIZE}."
