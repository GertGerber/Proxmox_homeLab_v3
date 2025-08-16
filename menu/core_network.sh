#!/bin/bash
. "$MENU_DIR/config.sh"
. "$MENU_DIR/utils.sh"

core_network_menu() {
    while true; do
        CHOICE=$(dialog --clear --backtitle "$BACKTITLE" \
            --title "Ansible Playbooks" \
            --menu "Select a playbook to run:" 15 50 5 \
            1 "Setup DHCP Servers" \
            2 "Setup DNS Servers" \
            3 "Setup AD Servers" \
            4 "Setup ADBLOCK Servers"
            5 "Back to Main Menu" 3>&1 1>&2 2>&3)

        case $CHOICE in
            1) ansible-playbook "$PLAYBOOKS_DIR/setup.yml"; pause ;;
            2) ansible-playbook "$PLAYBOOKS_DIR/deploy.yml"; pause ;;
            3) ansible-playbook "$PLAYBOOKS_DIR/ad.yml"; pause ;;
            4) ansible-playbook "$PLAYBOOKS_DIR/adblock.yml"; pause ;;
            5) break ;;
            *) break ;;
        esac
    done
}
