#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

. ./export-env-vars.sh

PWD=$(pwd)

if [ -z "$GCS_BUCKET_NAME" ]; then
  printf "Environment variable \$GCS_BUCKET_NAME is not set.\n"
  exit 1
fi

if [ -z "$GCS_BUCKET_PATH" ]; then
  printf "Environment variable \$GCS_BUCKET_PATH is not set.\n"
  exit 1
fi

cd ../terraform || (printf "Cannot find terraform directory.\n" && exit 1)

terraform init \
  --backend-config "bucket=$GCS_BUCKET_NAME" \
  --backend-config "prefix=$GCS_BUCKET_PATH"

terraform fmt -check

terraform validate

terraform plan -refresh=true -out=tfplan

terraform apply -auto-approve -lock=true tfplan
