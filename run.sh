#!/bin/bash

# Auto-detect project folder (can be moved)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Ensure the script is run from the correct directory
PROJECT_DIR="$SCRIPT_DIR/Github/Proxmox_homeLab_v3"
MENU_DIR="$PROJECT_DIR/menu"

if [ ! -f "$MENU_DIR/menu.sh" ]; then
    echo "Error: menu.sh not found in $MENU_DIR"
    exit 1
fi

# Run the menu
bash "$MENU_DIR/menu.sh"
