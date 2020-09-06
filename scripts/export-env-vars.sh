#!/usr/bin/env bash

export TF_VAR_project_id=$GCP_PROJECT_ID
export TF_VAR_pubsub_topic_name=$PUBSUB_TOPIC_NAME
export TF_VAR_iam_service_account_email=$IAM_SERVICE_ACCOUNT_EMAIL
export TF_VAR_pubsub_oauth_aud_claim=$PUBSUB_OAUTH_AUD_CLAIM
export TF_VAR_pubsub_verification_token=$PUBSUB_VERIFICATION_TOKEN
export TF_VAR_app_signing_secret=$APP_SIGNING_SECRET
export TF_VAR_app_docker_image_name=$DOCKER_IMAGE_NAME