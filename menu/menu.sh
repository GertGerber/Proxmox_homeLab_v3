#!/bin/bash

# Detect menu directory
MENU_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load config & utilities
. "$MENU_DIR/config.sh"
. "$MENU_DIR/utils.sh"
. "$MENU_DIR/ansible_menu.sh"
. "$MENU_DIR/terraform_menu.sh"

while true; do
    CHOICE=$(dialog --clear --backtitle "$BACKTITLE" \
        --title "Main Menu" \
        --menu "Choose an option:" 15 50 4 \
        1 "Ansible Playbooks" \
        2 "Terraform Commands" \
        3 "Exit" 3>&1 1>&2 2>&3)

    case $CHOICE in
        1) ansible_menu ;;
        2) terraform_menu ;;
        3) clear; exit ;;
        *) break ;;
    esac
done
