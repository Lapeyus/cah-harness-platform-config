# ==============================================================================
# Harness Cardinal - Spark Team Infrastructure
# ==============================================================================
# This configuration creates a Harness project for the Spark team with:
# - Team project with RBAC and WIF configuration
# - CI/CD pipelines for Gradle and DotNet services
# - Triggers, input sets, and service definitions

locals {
  account_id = var.harness_account_id
  org_id     = var.harness_org_id

  # Combine all services into a single map by type
  all_services = {
    gradle  = var.gradle_services
    dotnet  = var.dotnet_services
    angular = var.angular_services
    python  = var.python_services
  }
}

# ==============================================================================
# Harness Team Module
# ==============================================================================
# Creates the Harness project, WIF configuration, and RBAC settings

module "spark_team" {
  source = "../../../../cah-tf-module-harness-team"

  # Harness configuration
  account_id = local.account_id
  org_id     = local.org_id

  # Project settings
  project_name          = var.team_config.project_name
  apmid                 = var.team_config.apmid
  cost_center           = var.team_config.cost_center
  gcp_project_np        = var.team_config.gcp_project_np
  gcp_project_pr        = var.team_config.gcp_project_pr
  gcp_artifacts_project = var.team_config.gcp_artifacts_project
}

# ==============================================================================
# Harness Pipelines Module
# ==============================================================================
# Creates pipelines, services, triggers, and input sets for all service types

module "harness_pipelines" {
  source = "../../../../cah-tf-module-harness-pipeline"

  # Harness configuration
  account_id                  = local.account_id
  org_id                      = local.org_id
  project_id                  = module.spark_team.project_id
  admins_usergroup_identifier = module.spark_team.admins_usergroup_identifier

  # Service definitions
  services = local.all_services
}
