terraform {
  required_version = ">= 0.14"
  required_providers {
    google = ">= 3.5.0"
  }
}

provider "google" {
  project = "excellent-366409"
  region  = "europe-west4"
}

# Enable the Cloud Run API
resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

  disable_on_destroy = true
}

resource "google_cloud_run_service" "run_service" {
  name = "excellent-server"
  location = "europe-west4"

  template {
		spec {
			containers {
				image = "europe-west4-docker.pkg.dev/excellent-366409/excellent/main:latest"
			}
		}
	}

	traffic {
		percent = 100
		latest_revision = true
	}

	depends_on = [google_project_service.run_api]
}

resource "google_cloud_run_service_iam_member" "run_all_users" {
	service = google_cloud_run_service.run_service.name
	location = google_cloud_run_service.run_service.location
	role = "roles/run.invoker"
	member = "allUsers"
}

output "service_url" {
  value = google_cloud_run_service.run_service.status[0].url
}

