# dotfiles

Personal dotfiles for Vim, Neovim, and VSCode configurations.

## Quick Installation

### Mac/Linux

```bash
cd ~/dotfiles
./install.sh
```

The script will:
- Create symlinks for Vim configuration at `~/.vim/vimrc`
- Create symlinks for Neovim configuration at `~/.config/nvim/init.vim`
- Create symlinks for VSCode settings at appropriate location (Mac: `~/Library/Application Support/Code/User/settings.json`, Linux: `~/.config/Code/User/settings.json`)
- Automatically backup any existing files with `.backup` extension

### Windows

Run PowerShell as Administrator:

```powershell
cd ~\dotfiles
.\install.ps1
```

The script will:
- Create symlinks for Vim configuration at `%USERPROFILE%\.vim\vimrc`
- Create symlinks for Neovim configuration at `%USERPROFILE%\.config\nvim\init.vim`
- Create symlinks for VSCode settings at `%APPDATA%\Code\User\settings.json`
- Automatically backup any existing files with `.backup` extension

## Manual Installation

### Mac/Linux

```bash
# Vim
mkdir -p ~/.vim && ln -s ~/dotfiles/vim/vimrc ~/.vim/vimrc

# Neovim
mkdir -p ~/.config/nvim && ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim

# VSCode (macOS)
mkdir -p "$HOME/Library/Application Support/Code/User" && ln -s ~/dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

# VSCode (Linux)
mkdir -p ~/.config/Code/User && ln -s ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
```

### Windows

```cmd
# Vim
(if not exist %userprofile%\.vim mkdir %userprofile%\.vim) && mklink %userprofile%\.vim\vimrc %userprofile%\dotfiles\vim\vimrc

# Neovim
(if not exist %userprofile%\.config\nvim\ mkdir %userprofile%\.config\nvim\) && mklink %userprofile%\.config\nvim\init.vim %userprofile%\dotfiles\nvim\init.vim

# VSCode
(if not exist %APPDATA%\Code\User mkdir %APPDATA%\Code\User) && mklink %APPDATA%\Code\User\settings.json %userprofile%\dotfiles\vscode\settings.json
```
