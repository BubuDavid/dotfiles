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
    local target_file="$HOME/$2"

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

# Create symlinks (add more as needed)
create_symlink ".zshrc" ".zshrc"
create_symlink ".tmux.conf" ".tmux.conf"

log_info "Dotfiles installation complete!"
