#!/usr/bin/env bash

THEME_FILE="$(dirname "$0")/ryzha.nanorc"
NANORC="$HOME/.nanorc"
START="# ryzha:start"
END="# ryzha:end"

install() {
    if grep -qF "$START" "$NANORC" 2>/dev/null; then
        echo "ryzha is already in $NANORC."
        exit 0
    fi
    {
        echo ""
        echo "$START"
        cat "$THEME_FILE"
        echo "$END"
    } >> "$NANORC"
    echo "Installed ryzha into $NANORC."
}

uninstall() {
    if ! grep -qF "$START" "$NANORC" 2>/dev/null; then
        echo "ryzha not found in $NANORC."
        exit 0
    fi
    sed -i "/^$START$/,/^$END$/d" "$NANORC"
    echo "Uninstalled ryzha from $NANORC."
}

case "${1:-install}" in
    install)   install ;;
    uninstall) uninstall ;;
    *)
        echo "Usage: $0 [install|uninstall]"
        exit 1
        ;;
esac
