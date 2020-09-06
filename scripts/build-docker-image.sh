#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

docker image rm ifaisalalam/ide-api 2> /dev/null

docker build -t ifaisalalam/ide-api ../
