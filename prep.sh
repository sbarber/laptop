#!/bin/sh

# Stole a lot here from https://github.com/thoughtbot/laptop

fancy_echo() {
  local fmt="$1"; shift
  printf "\\n$fmt\\n" "$@"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\\n" "$text" >> "$zshrc"
    else
      printf "\\n%s\\n" "$text" >> "$zshrc"
    fi
  fi
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -d "$HOME/bin/" ]; then
  mkdir "$HOME/bin"
fi

if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

if [ ! -d "$HOME/Code/" ]; then
  mkdir "$HOME/Code"
fi

append_to_zshrc 'export PATH="$HOME/bin:$PATH"'

# Determine Homebrew prefix
arch="$(uname -m)"
if [ "$arch" = "arm64" ]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/usr/local"
fi

# checks architecture
if [ "$(uname -m)" = "arm64" ]
  then
  # checks if Rosetta is already installed
  if ! pkgutil --pkg-info=com.apple.pkg.RosettaUpdateAuto > /dev/null 2>&1
  then
    echo "Installing Rosetta"
    # Installs Rosetta2
    softwareupdate --install-rosetta --agree-to-license
  fi
fi

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    append_to_zshrc "eval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\""

    export PATH="$HOMEBREW_PREFIX/bin:$PATH"
fi
