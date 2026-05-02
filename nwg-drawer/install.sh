#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./install.sh install
#   ./install.sh uninstall

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SRC="${SCRIPT_DIR}/drawer.css"

DEST_DIR="${HOME}/.config/nwg-drawer"
DEST="${DEST_DIR}/drawer.css"

usage() {
  cat <<EOF
Usage:
  $(basename "$0") install     # install ./drawer.css to ~/.config/nwg-drawer/drawer.css
  $(basename "$0") uninstall   # remove ~/.config/nwg-drawer/drawer.css
EOF
}

do_install() {
  if [[ ! -f "$SRC" ]]; then
    echo "Error: source file not found: $SRC" >&2
    exit 1
  fi

  mkdir -p "$DEST_DIR"

  install -m 0644 -- "$SRC" "$DEST"
  echo "Installed: $SRC -> $DEST"
}

do_uninstall() {
  if [[ -f "$DEST" ]]; then
    rm -f -- "$DEST"
    echo "Removed: $DEST"
  else
    echo "Nothing to uninstall (file not found): $DEST"
  fi
}

action="${1:-}"
case "$action" in
  install) do_install ;;
  uninstall) do_uninstall ;;
  -h|--help|help|"") usage; exit 0 ;;
  *) echo "Error: unknown action: $action" >&2; usage; exit 2 ;;
esac
