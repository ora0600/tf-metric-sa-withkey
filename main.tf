terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.35.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

data "confluent_organization" "secemea" {}

// 'app-manager' service account is required in this configuration to create 'orders' topic and grant ACLs
// to 'app-producer' and 'app-consumer' service accounts.
resource "confluent_service_account" "monitor-manager" {
  display_name = "monitor-manager"
  description  = "Service account to manage monitoring of Confluent Cloud, created by Terraform C.Muetzlitz"
}

resource "confluent_role_binding" "monitor-manager-cc-metricviewer" {
  principal   = "User:${confluent_service_account.monitor-manager.id}"
  role_name   = "MetricsViewer"
  crn_pattern = data.confluent_organization.secemea.resource_name
}

resource "confluent_api_key" "monitor-manager-metric-api-key" {
  display_name = "monitor-manager-metric-api-key"
  description  = "Metric API Key that is owned by 'monitor-manager' service account"
  owner {
    id          = confluent_service_account.monitor-manager.id
    api_version = confluent_service_account.monitor-manager.api_version
    kind        = confluent_service_account.monitor-manager.kind
  }
}

