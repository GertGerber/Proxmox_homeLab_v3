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
cd "$TARGET_DIR/modules/desktop_cli_setup"
ansible-playbook playbook.yml \
    --extra-vars "git_user_name='$GIT_NAME' git_user_email='$GIT_EMAIL' github_token='$GITHUB_TOKEN'"

echo -e "${CYAN}=== Setup Complete! ===${NC}"
