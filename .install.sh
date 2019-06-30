#!/bin/bash

set -eu

sudo apt-get install -y curl

sudo usermod -aG docker $(whoami)

# Install nix package manager
curl https://nixos.org/nix/install | sh

# Install nix home manager
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
mkdir -m 0755 -p /nix/var/nix/{profiles,gcroots}/per-user/$USER
nix-channel --add https://github.com/rycee/home-manager/archive/release-19.03.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
