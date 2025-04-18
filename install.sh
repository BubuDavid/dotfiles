#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Log functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Create a symbolic link
create_symlink() {
    local source_file="$DOTFILES_DIR/$1"
    local target_file="$2"

    # Check if source file exists
    if [ ! -e "$source_file" ]; then
        log_error "Source file $source_file does not exist!"
        return 1
    fi

    # Create symlink
    ln -s "$source_file" "$target_file"
    log_info "Created symlink: $target_file -> $source_file"
}

# Main script
log_info "Starting dotfiles installation..."
log_info "Dotfiles directory: $DOTFILES_DIR"

# Create symlinks
create_symlink "zshrc" "/home/bubu/.zshrc"
create_symlink "tmux.conf" "/home/bubu/.tmux.conf"
create_symlink "./tmux-sessionizer.sh" "/usr/local/bin/tmux-sessionizer"
create_symlink "./tmux-attacher.sh" "/usr/local/bin/tmux-attacher"
create_symlink "./tv_config.toml" "/home/bubu/.config/television/config.toml"
create_symlink "./tv_custom_channels.toml" "/home/bubu/.config/television/custom_channels.toml"
create_symlink "./p10k.zsh" "/home/bubu/.p10k.zsh"

log_info "Dotfiles installation complete!"
