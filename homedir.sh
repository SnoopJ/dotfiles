#!/usr/bin/env bash
# This script based on https://github.com/webpro/dotfiles

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# make sure FETCH_HEAD exists
touch $DOTFILES_DIR/.git/FETCH_HEAD

# Update dotfiles itself first
#[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# -b option will create a backup if destination already exists
function addtorc() {
    if ! grep -q "$1" ~/.bashrc || [ -z "~/.bashrc" ]; then
        echo -e "\n#### ADDED BY $DOTFILES_DIR/homedir.sh ####" >> ~/.bashrc
        echo "$1" >> ~/.bashrc
    fi
}

# tmux
ln -sfb "$DOTFILES_DIR/.tmux.conf" ~

# vim
mkdir -p ~/.vim
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swp
cp -sfb "$DOTFILES_DIR/.vim"/* ~/.vim/
ln -sfb "$DOTFILES_DIR/.vimrc" ~

# git
ln -sfb "$DOTFILES_DIR/.gitconfig" ~
cp -sfb "$DOTFILES_DIR/.gitignore_global" ~

# matplotlib
mkdir -p ~/.config/matplotlib
ln -sfb "$DOTFILES_DIR/.config/matplotlib/matplotlibrc" ~/.config/matplotlib/matplotlibrc

# ssh config
mkdir -p ~/.ssh
ln -sfb "$DOTFILES_DIR/.ssh/config"* ~/.ssh/config
# permissions matter for .ssh/config
chmod 600 ~/.ssh/config

# .local/bin
mkdir -p ~/.local/bin
cp -sbv "$DOTFILES_DIR/.local/bin/"* ~/.local/bin

# .local/share/man
mkdir -p ~/.local/share/man
cp -srbv "$DOTFILES_DIR/.local/share/man/"* ~/.local/share/man

addtorc "export DOTFILES_DIR=\"$DOTFILES_DIR\""
addtorc "source \$DOTFILES_DIR/git-prompt.sh"
addtorc "source ~/.local/bin/z.sh"
addtorc "export PYTHONPATH=\"$PYTHONPATH:$DOTFILES_DIR/recipes\""

# Source the .bashrc.patch file *last*, so that any changes we make there
# will win in a conflict.
addtorc "source \$DOTFILES_DIR/.bashrc.patch"
