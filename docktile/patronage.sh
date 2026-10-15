#!/usr/bin/env bash
# Erase and recreate the Patronage Dock layout. Requires dockutil (brew install dockutil).
set -euo pipefail

if ! command -v dockutil >/dev/null 2>&1; then
  echo "dockutil not found. Install with: brew install dockutil" >&2
  exit 1
fi

add_app() {
  dockutil --no-restart --add "$1"
}

add_spacer() {
  # dockutil misreports blank spacer tiles as "adding $PWD", so discard its output.
  dockutil --no-restart --add '' --type "$1" --section apps >/dev/null
}

dockutil --no-restart --remove all

add_app "/System/Applications/Apps.app"
add_app "/Applications/1Password.app"
add_app "/Applications/Fantastical.app"
add_app "/Applications/Things3.app"
add_spacer spacer

# Safari lives in a cryptex on modern macOS; /Applications/Safari.app is only a stub.
add_app "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
add_app "/Applications/Brave Browser.app"
add_spacer spacer

add_app "/System/Applications/Messages.app"
add_app "/Applications/Mimestream.app"
add_app "/Applications/Slack.app"
add_spacer spacer

add_app "/Applications/Visual Studio Code.app"
add_app "/Applications/ChatGPT.app"
add_app "/Applications/Ghostty.app"
add_app "/Applications/Tower.app"
add_spacer spacer

dockutil --no-restart --add "$HOME/Downloads" --view fan --display folder --sort dateadded

killall Dock
