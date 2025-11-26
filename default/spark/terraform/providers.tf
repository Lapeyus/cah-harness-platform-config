terraform {
  required_version = ">= 1.9.0"

  required_providers {

    harness = {
      source  = "harness/harness"
      version = "~> 0.39.2"
    }

  }

  # backend "gcs" {
  #   bucket = "cah-tf-infra-state"
  #   prefix = "cah-harness-platform-config/spark"
  # }
}


# Harness provider configuration
provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = var.harness_account_id
  platform_api_key = var.harness_platform_api_key
}

# Google Cloud provider configuration
provider "google" {
  project = var.team_config.gcp_project_pr
  region  = "us-central1"
  zone    = "us-central1-a"
}