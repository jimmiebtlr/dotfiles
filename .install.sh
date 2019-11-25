#!/bin/bash

set -eu

sudo apt-get install -y curl git

# Download dotfiles
git init
git remote add origin https://github.com/jimmiebtlr/dotfiles.git
git pull origin master
git remote rm origin
git remote add origin git@github.com:jimmiebtlr/dotfiles.git
git branch --set-upstream-to=origin/master master

home-manager switch

# Docker via user install doesn't work so well.
sudo apt-get install -y lsb_release software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) \
	stable"

sudo apt-get update

# Nix python doesn't seem to be working.
sudo apt-get install -y flatpak docker-ce apache2-utils python

sudo usermod -aG docker $(whoami)

# Doubt current nix setup works with gpu + chrome os
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub com.unity.UnityHub

gcloud auth login

nvim +PlugInstall +qall
nvim +GoInstallBinaries +qall

echo "DON'T FORGET TO ADD SSH KEYS TO RELEVANT LOCATIONS"
echo "ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C jimmiebtlr@gmail.com"
