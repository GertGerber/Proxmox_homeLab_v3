#!/bin/bash
# Global configuration for menus

# Automatically detect project directory
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLAYBOOKS_DIR="$PROJECT_DIR/playbooks"
TERRAFORM_DIR="$PROJECT_DIR/terraform"

# Dialog settings
BACKTITLE="DevOps Automation Menu"
