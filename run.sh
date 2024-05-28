#!/bin/sh

set -e

#Create ~/.zshrc
if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi
