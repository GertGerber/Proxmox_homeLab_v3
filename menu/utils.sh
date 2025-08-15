#!/bin/bash

pause() {
    read -p "Press Enter to continue..."
}

show_error() {
    dialog --title "Error" --msgbox "$1" 8 40
}
