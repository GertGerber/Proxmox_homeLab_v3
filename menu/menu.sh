#!/bin/bash

# Detect menu directory
MENU_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load config & utilities
. "$MENU_DIR/config.sh"
. "$MENU_DIR/utils.sh"
. "$MENU_DIR/core_network.sh"
. "$MENU_DIR/terraform_menu.sh"

while true; do
    CHOICE=$(dialog --clear --backtitle "$BACKTITLE" \
        --title "Main Menu" \
        --menu "Choose an option:" 15 50 4 \
        1 "Install SSh-Keys" \
        2 "Setup CoreNetwork" \
        3 "Run Terraform Commands" \
        4 "Exit" 3>&1 1>&2 2>&3)    

    case $CHOICE in
        1)  
            TARGET_DIR="$HOME/Github/Proxmox_homeLab_v3"
            cd "$TARGET_DIR/modules/ssh_keys"
            ansible-playbook -i inventory.yml playbook.yml; pause ;;
        2) core_network_menu ;;
        3) terraform_menu ;;
        4) clear; exit ;;
        *) break ;;
    esac
done
