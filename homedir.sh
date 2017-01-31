#!/usr/bin/env bash
# This script based on https://github.com/webpro/dotfiles

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

#[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# -b option will create a backup if destination already exists
function addtorc() {
    if ! grep -q "$1" ~/.bashrc || [ -z "~/.bashrc" ]; then
        echo -e "\n#### ADDED BY $DOTFILES_DIR/install.sh ####" >> ~/.bashrc
        echo "$1" >> ~/.bashrc
    fi
}

addtorc "source $DOTFILES_DIR/git-prompt.sh"
addtorc "source $DOTFILES_DIR/.bashrc.patch"

ln -sfb "$DOTFILES_DIR/.tmux.conf" ~
mkdir -p ~/.vim
cp -sfb "$DOTFILES_DIR/.vim"/* ~/.vim/
ln -sfb "$DOTFILES_DIR/.vimrc" ~
ln -sfb "$DOTFILES_DIR/.gitconfig" ~

# .local/bin
mkdir -p ~/.local/bin
cp -sbv "$DOTFILES_DIR/.local/bin/"* ~/.local/bin

# .local/share/man
mkdir -p ~/.local/share/man
cp -srbv "$DOTFILES_DIR/.local/share/man/"* ~/.local/share/man

