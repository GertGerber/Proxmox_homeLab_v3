# Proxmox_homeLab_v3

On a fresh desktop:

bash -c "$(curl -fsSL https://raw.githubusercontent.com/GertGerber/Proxmox_homeLab_v3/main/modules/desktop_cli_setup/bootstrap.sh)"


This will:
1. Install prerequisites (software-properties-common, git, curl).
2. Install Ansible (if missing).
3. Clone your Proxmox_homeLab_v3 repo.
4. Run the desktop_cli_setup playbook interactively.
