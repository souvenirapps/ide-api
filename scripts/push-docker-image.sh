#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

. ./export-env-vars.sh

gcloud auth configure-docker

docker tag "$DOCKER_IMAGE_NAME" "gcr.io/$GCP_PROJECT_ID/$DOCKER_IMAGE_NAME"

docker push "gcr.io/$GCP_PROJECT_ID/$DOCKER_IMAGE_NAME"
