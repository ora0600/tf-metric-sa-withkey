output "resource-ids" {
  value = <<-EOT
    Service Accounts with MetricViewer role and their API Key (API Keys inherit the permissions granted to the owner):
  ${confluent_service_account.monitor-manager.display_name}:                             ${confluent_service_account.monitor-manager.id}
  ${confluent_service_account.monitor-manager.display_name}'s Cloud Metric API Key:     "${confluent_api_key.monitor-manager-metric-api-key.id}"
  ${confluent_service_account.monitor-manager.display_name}'s Cloud Metric API Secret:  "${confluent_api_key.monitor-manager-metric-api-key.secret}"
  EOT
  sensitive = true
}

output "secemea" {
  value = data.confluent_organization.secemea
}
