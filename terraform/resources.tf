resource "google_cloud_run_service" "ide_api" {
  provider = google-beta

  name     = "ide-api"
  location = "us-central1"

  traffic {
    percent         = 100
    latest_revision = true
  }

  template {
    metadata {
      name = "ide-api-app"
    }

    spec {
      containers {
        image = "gcr.io/${var.project_id}/${var.app_docker_image_name}"

        env {
          name  = "PUBSUB_TOPIC_NAME"
          value = var.pubsub_topic_name
        }
        env {
          name  = "PUBSUB_OAUTH_AUD_CLAIM"
          value = var.pubsub_oauth_aud_claim
        }
        env {
          name  = "PUBSUB_VERIFICATION_TOKEN"
          value = var.pubsub_verification_token
        }
        env {
          name  = "APP_SIGNING_SECRET"
          value = var.app_signing_secret
        }
        env {
          name  = "NODE_ENV"
          value = "production"
        }

        ports {
          container_port = parseint(var.app_port, 10)
        }
      }

      service_account_name = var.iam_service_account_email
      timeout_seconds      = var.app_timeout_seconds
    }
  }
}
