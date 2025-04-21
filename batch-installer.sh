#!/usr/bin/env bash

set -e

# Static list of target clients (excluding 'cursor')
TARGET_CLIENTS=("windsurf" "vscode" "roocode" "witsy")

echo "Smithery Install Replicator (multi-package)"
echo "Paste a full Smithery install command for '--client cursor'."
echo "Press Enter without input to quit."
echo

while true; do
  read -rp "Install command: " BASE_CMD

  if [[ -z "$BASE_CMD" ]]; then
    echo "Done."
    break
  fi

  if [[ "$BASE_CMD" != *"--client cursor"* ]]; then
    echo "Error: command must include '--client cursor'"
    continue
  fi

  echo "→ Running original install for cursor:"
  yes no | eval "$BASE_CMD" >/dev/null 2>&1
  echo "✓ Installed for cursor."

  for CLIENT in "${TARGET_CLIENTS[@]}"; do
    CMD="${BASE_CMD/--client cursor/--client $CLIENT}"
    echo "→ Installing to $CLIENT..."
    yes no | eval "$CMD" >/dev/null 2>&1
    echo "✓ Installed for $CLIENT."
  done

  echo "✔ Completed installation for all clients."
  echo
done
