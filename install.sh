#!/bin/bash

# dotfiles installation script for Mac/Linux
# This script creates symlinks for vim, nvim, and vscode configurations

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}Installing dotfiles from: ${DOTFILES_DIR}${NC}"
echo ""

# Function to create symlink
create_symlink() {
    local source=$1
    local target=$2
    local description=$3

    # Create parent directory if it doesn't exist
    local target_dir=$(dirname "$target")
    if [ ! -d "$target_dir" ]; then
        echo -e "${YELLOW}Creating directory: ${target_dir}${NC}"
        mkdir -p "$target_dir"
    fi

    # Remove existing symlink or file
    if [ -L "$target" ]; then
        echo -e "${YELLOW}Removing existing symlink: ${target}${NC}"
        rm "$target"
    elif [ -f "$target" ]; then
        echo -e "${YELLOW}Backing up existing file: ${target} -> ${target}.backup${NC}"
        mv "$target" "${target}.backup"
    fi

    # Create symlink
    echo -e "${GREEN}Creating symlink for ${description}${NC}"
    ln -s "$source" "$target"
    echo -e "  ${source} -> ${target}"
    echo ""
}

# Install Vim configuration
if [ -f "${DOTFILES_DIR}/vim/vimrc" ]; then
    create_symlink \
        "${DOTFILES_DIR}/vim/vimrc" \
        "$HOME/.vim/vimrc" \
        "Vim configuration"
else
    echo -e "${RED}Warning: vim/vimrc not found${NC}"
fi

# Install Neovim configuration
if [ -f "${DOTFILES_DIR}/nvim/init.vim" ]; then
    create_symlink \
        "${DOTFILES_DIR}/nvim/init.vim" \
        "$HOME/.config/nvim/init.vim" \
        "Neovim configuration"
else
    echo -e "${RED}Warning: nvim/init.vim not found${NC}"
fi

# Install VSCode configuration (Mac/Linux paths differ)
if [ -f "${DOTFILES_DIR}/vscode/settings.json" ]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        VSCODE_DIR="$HOME/Library/Application Support/Code/User"
    else
        # Linux
        VSCODE_DIR="$HOME/.config/Code/User"
    fi

    create_symlink \
        "${DOTFILES_DIR}/vscode/settings.json" \
        "${VSCODE_DIR}/settings.json" \
        "VSCode settings"
else
    echo -e "${RED}Warning: vscode/settings.json not found${NC}"
fi

echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""
echo "Installed configurations:"
echo "  - Vim: ~/.vim/vimrc"
echo "  - Neovim: ~/.config/nvim/init.vim"
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "  - VSCode: ~/Library/Application Support/Code/User/settings.json"
else
    echo "  - VSCode: ~/.config/Code/User/settings.json"
fi
echo ""
echo -e "${YELLOW}Note: Any existing files have been backed up with .backup extension${NC}"
