#!/bin/bash

set -eu

sudo apt-get install -y curl git

# Install nix  and packagespackage manager
curl https://nixos.org/nix/install | sh

# Install nix home manager
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
mkdir -m 0755 -p /nix/var/nix/{profiles,gcroots}/per-user/$USER
nix-channel --add https://github.com/rycee/home-manager/archive/release-19.03.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

# Download dotfiles
git clone git@github.com:jimmiebtlr/dotfiles.git

home-manager switch
