#!/usr/bin/env bash
# This script based on https://github.com/webpro/dotfiles

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

#[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

sudo cp -as "$(pwd)/services/"* /etc/systemd/system/
