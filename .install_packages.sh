#!/bin/bash

sudo apt-get update 

sudo apt-get install -y \
	curl \
	git \
	npm \
	nodejs \
	software-properties-common \
	flatpak \
	apache2-utils \
	python \
	python3 \
	python3-pip \
	tmux \
	tmuxinator \
	tmux-plugin-manager \
	powerline \
	htop \
	nodejs \
	zip \
	build-essential \
	unzip \
	psmisc \
	bash-completion \
	ca-cacert \
	docker-ce docker-ce-cli containerd.io \
	google-cloud-sdk-app-engine-python \
	google-cloud-sdk-app-engine-python-extras \
	google-cloud-sdk

sudo usermod -aG docker $(whoami)
