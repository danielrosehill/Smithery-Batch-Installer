#!/usr/bin/env bash

set -e

echo "Smithery Install Replicator v2 (package-based)"
echo "Paste a package name (e.g., @mcpserver/openrouterai)"
echo "Press Enter without input to quit."
echo

while true; do
  read -rp "Package name: " PACKAGE_NAME

  if [[ -z "$PACKAGE_NAME" ]]; then
    echo "Done."
    break
  fi

  # Define the target clients
  TARGET_CLIENTS=("windsurf" "vscode" "roocode" "witsy" "cursor")
  
  # Construct the base command using the package name
  BASE_CMD="npx -y @smithery/cli@latest run $PACKAGE_NAME"
  
  for CLIENT in "${TARGET_CLIENTS[@]}"; do
    CMD="$BASE_CMD --client $CLIENT"
    echo "→ Installing $PACKAGE_NAME to $CLIENT..."
    yes no | eval "$CMD" >/dev/null 2>&1 || echo "  Warning: Installation for $CLIENT may have failed."
    echo "✓ Installed for $CLIENT."
  done

  echo "✔ Completed installation for all clients."
  echo
done