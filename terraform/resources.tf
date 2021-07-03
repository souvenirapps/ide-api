resource "google_cloud_run_service" "ide_api" {
  provider = google-beta

  name     = "ide-api"
  location = "europe-west2"

  traffic {
    percent         = 100
    latest_revision = true
  }

  template {
    metadata {
      name = "ide-api-app-${substr(sha1(timestamp()), 0, 7)}"
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

resource "google_cloud_run_service_iam_member" "member" {
  provider = google-beta

  location = google_cloud_run_service.ide_api.location
  project  = google_cloud_run_service.ide_api.project
  service  = google_cloud_run_service.ide_api.name

  role   = "roles/run.invoker"
  member = "allUsers"
}

resource "google_cloud_scheduler_job" "warm_ide_api" {
  provider = google-beta
  region   = "europe-west2"

  name        = "warm-ide-api"
  description = "Ping IDE API Cloud Run app to prevent cold start."
  schedule    = "every 1 minutes"
  time_zone   = "Asia/Calcutta"

  http_target {
    http_method = "GET"
    uri         = "${google_cloud_run_service.ide_api.status[0].url}/_/ping"

    oidc_token {
      service_account_email = var.cloud_scheduler_sa_email
      audience = google_cloud_run_service.ide_api.status[0].url
    }
  }

  depends_on = [google_cloud_run_service.ide_api]
}
