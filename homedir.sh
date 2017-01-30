#!/usr/bin/env bash
# This script based on https://github.com/webpro/dotfiles

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

#[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# -b option will create a backup if destination already exists
cp -fbv ~/.bashrc ~/.bashrc.bak
echo -e "\n#### ADDED BY $DOTFILES_DIR/install.sh ####\n" >> ~/.bashrc
cat "$DOTFILES_DIR/.bashrc.patch" >> ~/.bashrc
ln -sfbv "$DOTFILES_DIR/.tmux.conf" ~
ln -sfbv "$DOTFILES_DIR/.vim" ~
ln -sfbv "$DOTFILES_DIR/.vimrc" ~
ln -sfbv "$DOTFILES_DIR/.gitconfig" ~

# .local/bin
mkdir -p ~/.local/bin
cp -sbv "$DOTFILES_DIR/.local/bin/"* ~/.local/bin

# .local/share/man
mkdir -p ~/.local/share/man
cp -srbv "$DOTFILES_DIR/.local/share/man/"* ~/.local/share/man
