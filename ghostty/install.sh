#!/usr/bin/env bash

THEME_NAME="ryzha"
THEME_FILE="$(dirname "$0")/$THEME_NAME.ghostty"
THEMES_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes"

install() {
    mkdir -p "$THEMES_DIR"
    cp "$THEME_FILE" "$THEMES_DIR/$THEME_NAME"
    echo "Installed: set 'theme = $THEME_NAME' in your Ghostty config."
}

uninstall() {
    rm -f "$THEMES_DIR/$THEME_NAME"
    echo "Uninstalled $THEME_NAME."
}

case "${1:-install}" in
    install)   install ;;
    uninstall) uninstall ;;
    *)
        echo "Usage: $0 [install|uninstall]"
        exit 1
        ;;
esac
