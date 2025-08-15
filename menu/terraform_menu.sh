#!/bin/bash
. "$MENU_DIR/config.sh"
. "$MENU_DIR/utils.sh"

terraform_menu() {
    while true; do
        CHOICE=$(dialog --clear --backtitle "$BACKTITLE" \
            --title "Terraform Commands" \
            --menu "Select a command:" 15 50 4 \
            1 "Terraform Init" \
            2 "Terraform Plan" \
            3 "Terraform Apply" \
            4 "Back to Main Menu" 3>&1 1>&2 2>&3)

        case $CHOICE in
            1) terraform -chdir="$TERRAFORM_DIR" init; pause ;;
            2) terraform -chdir="$TERRAFORM_DIR" plan; pause ;;
            3) terraform -chdir="$TERRAFORM_DIR" apply; pause ;;
            4) break ;;
            *) break ;;
        esac
    done
}
