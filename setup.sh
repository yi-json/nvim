#!/bin/bash
# setup.sh

echo "Starting Neovim environment setup..."

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f /etc/arch-release ]; then
        sudo pacman -S --needed neovim ripgrep git base-devel
    elif [ -f /etc/lsb-release ]; then
        sudo apt update && sudo apt install -y neovim ripgrep git build-essential
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install neovim ripgrep git
fi

echo "Dependencies installed. Opening Neovim to sync plugins..."
nvim --headless "+Lazy! sync" +qa

echo "Setup complete! Just make sure you have a Nerd Font installed."