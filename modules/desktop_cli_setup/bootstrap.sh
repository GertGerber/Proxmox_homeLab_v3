#####################################################################
# File: Proxmox_homeLab_v3/modules/desktop_cli_setup/bootstrap.sh
# Purpose: Bootstrap script for Proxmox HomeLab v3 Desktop CLI Setup
# Version: 0.0.1
#####################################################################

#!/bin/bash
set -euo pipefail

GREEN="\\033[0;32m"
CYAN="\\033[0;36m"
NC="\\033[0m"

echo -e "${CYAN}=== Proxmox HomeLab v3 Desktop CLI Setup Bootstrap ===${NC}"

# 1. Install prerequisites
echo -e "${GREEN}[*] Installing prerequisites...${NC}"
sudo apt update -y
sudo apt install -y software-properties-common git curl

# 2. Install Ansible if missing
if ! command -v ansible >/dev/null 2>&1; then
    echo -e "${GREEN}[*] Installing Ansible...${NC}"
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
else
    echo -e "${GREEN}[OK] Ansible already installed.${NC}"
fi

# 3. Prompt for Git details
read -rp "👤 Enter your Git user name: " GIT_NAME
read -rp "📧 Enter your Git email address: " GIT_EMAIL

# 4. Prompt for GitHub token
echo "🔐 Enter your GitHub Personal Access Token (will not be displayed):"
read -rs GITHUB_TOKEN
echo

# 5. Clone the repository (always your repo)
REPO_URL="https://${GITHUB_TOKEN}@github.com/GertGerber/Proxmox_homeLab_v3.git"
TARGET_DIR="$HOME/Github/Proxmox_homeLab_v3"

if [ -d "$TARGET_DIR" ]; then
    echo -e "${GREEN}[OK] Repository already exists at $TARGET_DIR.${NC}"
else
    echo -e "${GREEN}[*] Cloning repository from your GitHub...${NC}"
    git clone "$REPO_URL" "$TARGET_DIR"
fi

# 6. Run the Ansible playbook with provided values
set +e
cd "$TARGET_DIR/modules/desktop_cli_setup"
ansible-playbook playbook.yml \
    --extra-vars "git_user_name='$GIT_NAME' git_user_email='$GIT_EMAIL' github_token='$GITHUB_TOKEN'"
set -e

# 7. Copy the menu script to the home directory
echo -e "${GREEN}[*] Copying menu script to home directory...${NC}"
cp "$TARGET_DIR/run.sh" "$HOME/run.sh"
chmod +x "$HOME/run.sh" 
echo -e "${GREEN}[OK] Menu script copied to $HOME/run.sh.${NC}"

# 8. Prompt to run the menu script
echo -e "${CYAN}To run the menu, execute: ${GREEN}bash $HOME/run.sh${NC}"
echo -e "${CYAN}Or run it directly: ${GREEN}./run.sh${NC}"
echo -e "${CYAN}You can also create a desktop shortcut for easy access.${NC}"

# 9. Final message
echo -e "${CYAN}=== Bootstrap Complete! ===${NC}"
echo -e "${GREEN}Enjoy your Proxmox HomeLab v3 setup!${NC}"
echo -e "${CYAN}For more information, visit: https://github.com/GertGerber/Proxmox_homeLab_v3${NC}"

echo -e "${CYAN}=== Setup Complete! ===${NC}"
