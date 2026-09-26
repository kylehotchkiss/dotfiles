#!/usr/bin/env bash
# Erase and recreate the personal Dock layout. Requires dockutil (brew install dockutil).
set -euo pipefail

if ! command -v dockutil >/dev/null 2>&1; then
  echo "dockutil not found. Install with: brew install dockutil" >&2
  exit 1
fi

add_app() {
  dockutil --no-restart --add "$1"
}

add_spacer() {
  dockutil --no-restart --add '' --type "$1" --section apps
}

dockutil --no-restart --remove all

add_app "/System/Applications/Apps.app"
add_app "/Applications/1Password.app"
add_app "/Applications/Fantastical.app"
add_app "/Applications/Things3.app"
add_spacer spacer

add_app "/Applications/Safari.app"
add_spacer spacer

add_app "/System/Applications/Messages.app"
add_app "/System/Applications/Mail.app"
add_app "/Applications/Mimestream.app"
add_spacer spacer

add_app "/Applications/Visual Studio Code.app"
add_app "/Applications/Ghostty.app"
add_app "/Applications/Tower.app"
add_spacer spacer

dockutil --no-restart --add "$HOME/Downloads" --view fan --display folder --sort dateadded

killall Dock
