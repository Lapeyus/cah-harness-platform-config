# ==============================================================================
# Harness Team Project
# ==============================================================================

output "project_id" {
  description = "The Harness project identifier"
  value       = module.spark_team.project_id
}

output "project_name" {
  description = "The Harness project name"
  value       = var.team_config.project_name
}

output "admins_usergroup_identifier" {
  description = "The admin user group identifier"
  value       = module.spark_team.admins_usergroup_identifier
}

output "resource_group_id" {
  description = "The project resource group ID"
  value       = module.spark_team.resource_group_id
}

# ==============================================================================
# Pipeline Information
# ==============================================================================

output "gradle_pipeline_id" {
  description = "Gradle pipeline identifier"
  value       = try(module.harness_pipelines.gradle_pipeline_id, null)
}

output "dotnet_pipeline_id" {
  description = "DotNet pipeline identifier"
  value       = try(module.harness_pipelines.dotnet_pipeline_id, null)
}

# ==============================================================================
# Service Summary
# ==============================================================================

output "services_summary" {
  description = "Summary of all configured services"
  value = {
    gradle_count  = length(var.gradle_services)
    dotnet_count  = length(var.dotnet_services)
    angular_count = length(var.angular_services)
    python_count  = length(var.python_services)
    total_count   = length(var.gradle_services) + length(var.dotnet_services) + length(var.angular_services) + length(var.python_services)
  }
}

output "gradle_services_list" {
  description = "List of configured Gradle services"
  value       = keys(var.gradle_services)
}

output "dotnet_services_list" {
  description = "List of configured DotNet services"
  value       = keys(var.dotnet_services)
}
