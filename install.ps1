# dotfiles installation script for Windows (PowerShell)
# This script creates symlinks for vim, nvim, and vscode configurations
# Run as Administrator for symlink creation

#Requires -RunAsAdministrator

# Get the directory where this script is located
$DOTFILES_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Installing dotfiles from: $DOTFILES_DIR" -ForegroundColor Green
Write-Host ""

# Function to create symlink
function Create-Symlink {
    param(
        [string]$Source,
        [string]$Target,
        [string]$Description
    )

    # Create parent directory if it doesn't exist
    $targetDir = Split-Path -Parent $Target
    if (-not (Test-Path $targetDir)) {
        Write-Host "Creating directory: $targetDir" -ForegroundColor Yellow
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    # Handle existing symlink or file
    if (Test-Path $Target) {
        $item = Get-Item $Target -Force
        if ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            Write-Host "Removing existing symlink: $Target" -ForegroundColor Yellow
            Remove-Item $Target -Force
        } else {
            Write-Host "Backing up existing file: $Target -> $Target.backup" -ForegroundColor Yellow
            Move-Item $Target "$Target.backup" -Force
        }
    }

    # Create symlink
    Write-Host "Creating symlink for $Description" -ForegroundColor Green
    New-Item -ItemType SymbolicLink -Path $Target -Target $Source -Force | Out-Null
    Write-Host "  $Source -> $Target" -ForegroundColor Gray
    Write-Host ""
}

# Install Vim configuration
$vimrcSource = Join-Path $DOTFILES_DIR "vim\vimrc"
if (Test-Path $vimrcSource) {
    $vimrcTarget = Join-Path $env:USERPROFILE ".vim\vimrc"
    Create-Symlink -Source $vimrcSource -Target $vimrcTarget -Description "Vim configuration"
} else {
    Write-Host "Warning: vim\vimrc not found" -ForegroundColor Red
}

# Install Neovim configuration
$nvimSource = Join-Path $DOTFILES_DIR "nvim\init.vim"
if (Test-Path $nvimSource) {
    $nvimTarget = Join-Path $env:USERPROFILE ".config\nvim\init.vim"
    Create-Symlink -Source $nvimSource -Target $nvimTarget -Description "Neovim configuration"
} else {
    Write-Host "Warning: nvim\init.vim not found" -ForegroundColor Red
}

# Install VSCode configuration
$vscodeSource = Join-Path $DOTFILES_DIR "vscode\settings.json"
if (Test-Path $vscodeSource) {
    $vscodeTarget = Join-Path $env:APPDATA "Code\User\settings.json"
    Create-Symlink -Source $vscodeSource -Target $vscodeTarget -Description "VSCode settings"
} else {
    Write-Host "Warning: vscode\settings.json not found" -ForegroundColor Red
}

Write-Host "======================================" -ForegroundColor Green
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
Write-Host "Installed configurations:"
Write-Host "  - Vim: $env:USERPROFILE\.vim\vimrc"
Write-Host "  - Neovim: $env:USERPROFILE\.config\nvim\init.vim"
Write-Host "  - VSCode: $env:APPDATA\Code\User\settings.json"
Write-Host ""
Write-Host "Note: Any existing files have been backed up with .backup extension" -ForegroundColor Yellow
