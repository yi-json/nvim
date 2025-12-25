# Neovim Configuration

[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)

A personalized, high-performance Neovim configuration built for efficiency in C++, Rust, and Go development. This setup utilizes `lazy.nvim` for package management and includes a curated suite of plugins for a modern IDE experience.


| **Dashboard** | **Fuzzy Finding** | **Workspace View** |
| :---: | :---: | :---: |
| ![homepg.png](assets/homepg.png) | ![fuzzyfetch.png](assets/fuzzyfetch.png) | ![workspace.png](assets/workspace.png) |

## Fast Setup
If you are on a brand new machine, use the automated setup script to install Neovim, system dependencies (ripgrep, build tools), and synced plugins in one go.

```bash
git clone git@github.com:yi-json/nvim.git ~/.config/nvim
cd ~/.config/nvim
chmod +x setup.sh
./setup.sh
nvim
```

Note: The script does not include the **Nerd Font** - it needs to be downloaded manually

## Prerequisites
If you prefer a manual setup, ensure the following are installed:

1. **Neovim (v0.9.0+):** `pacman -S neovim` (arch), `brew install neovim` (macOS), or `apt install neovim` (ubuntu/debian).
2. **Ripgrep:** Essential for Telescope fuzzy finding.
3. **Build Tools:** `gcc` or `clang` for Treesitter parsers.
4. **Nerd Font:** Required for icons. [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip) is recommended.

##  Plugin Reference
This config follows a modular structure where each plugin has its own dedicated configuration file.

| File | Plugin / Feature | Description |
| :--- | :--- | :--- |
| **`alpha.lua`** | **Dashboard** | The startup screen with the "NEOVIM" header, shortcuts, and philosophical quotes. |
| **`comments.lua`** | **Comment.nvim** | Smart commenting utility. Toggle comments with `gcc` (line) or `gc` (selection). |
| **`completion.lua`** | **nvim-cmp** | Autocompletion engine. Provides suggestions for code, paths, and snippets as you type. |
| **`formatting.lua`** | **Conform / None-ls** | Handles auto-formatting (e.g., clang-format, rustfmt) to keep code consistent. |
| **`lsp.lua`** | **LSP Config** | Connects to Language Servers (clangd, rust_analyzer, gopls) for Go-to-Definition and Errors. |
| **`neotree.lua`** | **Neo-tree** | A file explorer tree for browsing project directories visually. |
| **`discord.lua`** | **Discord Presence** | Discord Rich Presence integration to show what you're working on in real-time. |
| **`telescope.lua`** | **Telescope** | Fuzzy finder. Quickly find files (`<space>f`), text (`<space>t`), or buffers. |
| **`theme.lua`** | **Colorscheme** | Controls the visual style and syntax highlighting colors. |
| **`toggleterm.lua`** | **ToggleTerm** | Floating/Docked terminal. Toggle it with `Ctrl+\`. |
| **`treesitter.lua`** | **Treesitter** | Advanced syntax highlighting and parsing for better code readability. |
| **`vimbegood.lua`** | **Vim Be Good** | A game to practice Vim motions. Run `:VimBeGood` to start training. |
| **`which-key.lua`** | **Which-Key** | Popup menu that shows available keybindings if you pause while typing. |

## Keybind Cheat Sheet

*Based on standard configuration patterns.*

### **General**
* `<Space>` : Leader Key (used for most custom commands)
* `Ctrl + \` : Toggle Terminal
* `gcc` : Comment/Uncomment current line
* `:VimBeGood` : Start the Vim training game

### **Navigation (Telescope)**
* `<Space> f` : Find File (fuzzy search)
* `<Space> t` : Find Text (live grep)
* `<Space> r` : Recent Files
* `<Space> c` : Edit Config

### **File Explorer (Neo-tree)**
* `<Space> e` : Toggle File Explorer
* `a` : Add new file (inside explorer)
* `d` : Delete file (inside explorer)
* `r` : Rename file (inside explorer)

### **LSP (Code Intelligence)**
* `gd` : Go to Definition
* `K` : Hover Documentation
* `<Space> ca` : Code Action (Fix errors/refactor)

## Directory Structure

```text
~/.config/nvim
├── init.lua              # Entry point
├── lazy-lock.json        # Plugin version lockfile (DO NOT DELETE)
└── lua
    ├── config
    │   ├── keymaps.lua   # Custom keybindings
    │   ├── lazy.lua      # Plugin manager setup
    │   └── options.lua   # Vim options (line numbers, tabs, etc.)
    └── plugins           # Individual plugin configurations
```
