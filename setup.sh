#!/bin/bash
# setup.sh
#
# Deliberately no `set -e`: a missing package manager should skip that step
# and print a hint, not abort the rest of the setup.

SKIPPED=()

echo "Starting Neovim environment setup..."

# --- System packages ---------------------------------------------------
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f /etc/arch-release ]; then
        sudo pacman -S --needed neovim ripgrep git base-devel
    elif [ -f /etc/lsb-release ]; then
        sudo apt update && sudo apt install -y neovim ripgrep git build-essential
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew >/dev/null 2>&1; then
        # neovim/ripgrep/git: editor + telescope grep
        # tree-sitter-cli:    required by nvim-treesitter (main) to build parsers
        # go:                 mason builds gopls with `go install`
        # rust:               rustfmt for format-on-save
        # stylua:             Lua formatter
        # mdformat:           markdown formatter
        # black/prettier/shfmt: used by bin/mdcodefmt for fenced code blocks
        brew install neovim ripgrep git tree-sitter-cli go rust stylua mdformat black prettier shfmt
    else
        echo "Homebrew not found - skipping brew installs."
        SKIPPED+=("Homebrew: install it from https://brew.sh, then re-run this script")
    fi
fi

# --- Python packages ---------------------------------------------------
PIP=$(command -v pip3 || command -v pip)
if [ -n "$PIP" ]; then
    # clang-format:      C/C++ formatter
    # clang-format-docs: formats C/C++ fences inside markdown
    "$PIP" install clang-format clang-format-docs
else
    echo "pip not found - skipping Python package installs."
    SKIPPED+=("pip: install Python 3 (which includes pip), then re-run this script")
fi

# --- Plugins -----------------------------------------------------------
if command -v nvim >/dev/null 2>&1; then
    echo "Dependencies installed. Opening Neovim to sync plugins..."
    nvim --headless "+Lazy! sync" +qa
else
    echo "Neovim not found - skipping plugin sync."
    SKIPPED+=("Neovim: install it, then re-run this script to sync plugins")
fi

# --- Summary -----------------------------------------------------------
echo
if [ ${#SKIPPED[@]} -gt 0 ]; then
    echo "Setup finished, but some steps were skipped:"
    for item in "${SKIPPED[@]}"; do
        echo "  - $item"
    done
else
    echo "Setup complete!"
fi
echo "Note: install a Nerd Font manually (e.g. JetBrainsMono Nerd Font)."
