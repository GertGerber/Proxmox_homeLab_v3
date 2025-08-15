<!-- 
#####################################################################
# File: Proxmox_homeLab_v3/modules/desktop_cli_setup/README.md
# Purpose:  README File
# Version: 0.0.1
##################################################################### 
-->

# Desktop CLI Setup (Ansible Module)

This module is designed to live under the `Proxmox_homeLab_v3/modules/desktop_cli_setup/` path
and provisions a desktop with essential CLI tools, Ansible, Packer, Terraform, Git, and GitHub auth.

## Run
```bash
cd Proxmox_homeLab_v3/modules/desktop_cli_setup
ansible-playbook playbook.yml
```

You'll be prompted for:
- Git user name
- Git user email
- GitHub Personal Access Token (PAT)

## What it installs
- Essential tools: git, curl, jq, whiptail, dialog, unzip, gpg, sshpass, wget, gnupg, software-properties-common, gh,
  python3, python3-pip, python3-venv, make, htop, ncdu, net-tools, bat, ripgrep, fzf, tmux, neofetch
- `yq` latest (from GitHub release)
- Ansible (via official PPA if not present)
- Latest Packer (from HashiCorp releases)
- Latest Terraform (from HashiCorp releases)
- Git global config (init.defaultBranch=main, pull.rebase=false, credential.helper=store, core.editor=nano)
- GitHub CLI authentication using the supplied PAT

## Idempotency notes
- If Ansible is already installed, the PPA step is skipped.
- Packer and Terraform are fetched each run from HashiCorp's checkpoint API and binaries are unzipped to `/usr/local/bin/`.

## Security notes
- Your GitHub token is saved to `~/.config/gh/token.txt` with `0600` permissions and used to log in to `gh`.
- Consider rotating/removing the token file after authentication if you prefer not to keep it on disk.
