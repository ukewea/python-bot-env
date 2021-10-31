#!/bin/bash

# create builder
#docker buildx create remote-build
#DOCKER_HOST=ssh://pi-arm64 docker buildx create --append --name remote-build --node pi-arm64 --platform=linux/arm64
#DOCKER_HOST=ssh://pi-armv7 docker buildx create --append --name remote-build --node pi-armv7 --platform=linux/arm/v7

# check status
#docker buildx ls --builder remote-build

docker buildx use remote-build
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t wuuker/python-bot-env:python3.9 -t wuuker/python-bot-env:latest . --push
