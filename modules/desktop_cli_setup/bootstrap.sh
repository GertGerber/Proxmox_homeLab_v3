#!/bin/bash
set -euo pipefail

# Colors for output
GREEN="\033[0;32m"
CYAN="\033[0;36m"
NC="\033[0m" # No Color

echo -e "${CYAN}=== Proxmox HomeLab v3 Desktop CLI Setup Bootstrap ===${NC}"

# 1. Install prerequisites
echo -e "${GREEN}[*] Installing prerequisites (software-properties-common, git)...${NC}"
sudo apt update -y
sudo apt install -y software-properties-common git curl

# 2. Install Ansible if not already present
if ! command -v ansible >/dev/null 2>&1; then
    echo -e "${GREEN}[*] Installing Ansible from official PPA...${NC}"
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
else
    echo -e "${GREEN}[OK] Ansible already installed.${NC}"
fi

# 3. Clone the repository
REPO_URL="https://github.com/YOUR_USER/Proxmox_homeLab_v3.git"
TARGET_DIR="$HOME/Proxmox_homeLab_v3"

if [ -d "$TARGET_DIR" ]; then
    echo -e "${GREEN}[OK] Repository already cloned at $TARGET_DIR.${NC}"
else
    echo -e "${GREEN}[*] Cloning repository from $REPO_URL...${NC}"
    git clone "$REPO_URL" "$TARGET_DIR"
fi

# 4. Run the desktop CLI setup playbook
cd "$TARGET_DIR/modules/desktop_cli_setup"
echo -e "${GREEN}[*] Running Ansible playbook...${NC}"
ansible-playbook playbook.yml

echo -e "${CYAN}=== Setup Complete! ===${NC}"
