#!/bin/bash
. "$MENU_DIR/config.sh"
. "$MENU_DIR/utils.sh"

ansible_menu() {
    while true; do
        CHOICE=$(dialog --clear --backtitle "$BACKTITLE" \
            --title "Ansible Playbooks" \
            --menu "Select a playbook to run:" 15 50 5 \
            1 "Setup servers (setup.yml)" \
            2 "Deploy application (deploy.yml)" \
            3 "Back to Main Menu" 3>&1 1>&2 2>&3)

        case $CHOICE in
            1) ansible-playbook "$PLAYBOOKS_DIR/setup.yml"; pause ;;
            2) ansible-playbook "$PLAYBOOKS_DIR/deploy.yml"; pause ;;
            3) break ;;
            *) break ;;
        esac
    done
}
