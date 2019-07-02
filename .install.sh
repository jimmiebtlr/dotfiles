#!/bin/bash

set -eu

sudo apt-get install -y curl git

# Install nix  and packagespackage manager
curl https://nixos.org/nix/install | sh

. ~/.nix-profile/etc/profile.d/nix.sh

# Install nix home manager
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
mkdir -m 0755 -p /nix/var/nix/{profiles,gcroots}/per-user/$USER
nix-channel --add https://github.com/rycee/home-manager/archive/release-19.03.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

# Remove generated .nix config and default files in the way
rm .config/nixpkgs/home.nix .bashrc .profile

# Download dotfiles
git init
git remote add origin https://github.com/jimmiebtlr/dotfiles.git
git pull origin master
git remote rm origin
git remote add origin git@github.com:jimmiebtlr/dotfiles.git
git branch --set-upstream-to=origin/master master

home-manager switch

# Nix python doesn't seem to be working.
sudo apt-get install -y python3 python3-pip flatpak

# Doubt current nix setup works with gpu + chrome os
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub com.unity.UnityHub

echo "DON'T FORGET TO ADD SSH KEYS TO RELEVANT LOCATIONS"
echo "ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C jimmiebtlr@gmail.com"
