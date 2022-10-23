terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = "excellent-366409"
  region  = "europe-west4"
  zone    = "europe-west4-a"
}

