#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

. ./export-env-vars.sh

docker image rm "$DOCKER_IMAGE_NAME" 2> /dev/null

docker build -t "$DOCKER_IMAGE_NAME" ../
