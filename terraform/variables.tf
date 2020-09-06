variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "pubsub_topic_name" {
  description = "Name of the Pub/Sub topic to which tasks will be published."
}

variable "iam_service_account_email" {
  description = "IAM service account that the app will use."
}

variable "pubsub_oauth_aud_claim" {
  description = "Audience claim to check for in JWT received from Pub/Sub."
}

variable "pubsub_verification_token" {
  description = "Token used on /api/status/update API to validate the request is really coming from Pubsub."
}

variable "app_signing_secret" {
  default = "secret"
  description = "Signing key used by the application."
}

variable "app_port" {
  default = "3000"
}

variable "app_timeout_seconds" {
  default = 10
}

variable "app_docker_image_name" {
  default = "ide-api"
}
