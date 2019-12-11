#!/bin/bash

pip3 install --user \
	docker-compose \
	ray \
	ray[debug] \
	googleapis-common-protos \
	oauth2client \
	setuptools \
	ez_setup \
	ray[tune] torch torchvision filelock \
	ray[rllib] \
	tensorboard \
	google-auth \
	google-api-python-client
