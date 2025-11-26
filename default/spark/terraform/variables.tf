# ==============================================================================
# Global Configuration
# ==============================================================================

variable "harness_account_id" {
  description = "Harness account identifier"
  type        = string
  default     = ""
}

variable "harness_org_id" {
  description = "Harness organization identifier"
  type        = string
  default     = ""
}

variable "harness_platform_api_key" {
  description = "Harness platform API key"
  type        = string
  default     = ""
}
# ==============================================================================
# Team Configuration
# ==============================================================================

variable "team_config" {
  description = "Team configuration for Harness project"
  type = object({
    project_name          = string
    apmid                 = string
    cost_center           = string
    gcp_project_np        = string
    gcp_project_pr        = string
    gcp_artifacts_project = string
  })
}

# ==============================================================================
# Service Definitions
# ==============================================================================

variable "gradle_services" {
  description = "Gradle service definitions"
  type = map(object({
    repo_name              = string
    service_ref            = string
    language_version       = string
    notification_email     = string
    app_name               = optional(string)
    trigger_enabled        = optional(bool, true)
    trigger_type           = optional(string, "Push")
    trigger_auto_abort     = optional(bool, false)
    trigger_branch         = optional(string, "main,master")
    trigger_connector_ref  = optional(string, "account.cahgithubro")
    manifest_connector_ref = optional(string, "account.cahgithubgitopsrw")
    manifest_identifier    = string
    manifest_path          = string
    manifest_branch        = optional(string, "master")
    manifest_repo          = string
    artifact_connector_ref = optional(string, "account.cahgcpartifactregistry")
    artifact_identifier    = string
    artifact_project       = optional(string, "artifacts-pr-cah")
    artifact_package       = string
    dr_enabled             = optional(bool, true)
  }))
  default = {}
}

variable "dotnet_services" {
  description = "DotNet service definitions"
  type = map(object({
    repo_name              = string
    service_ref            = string
    language_version       = string
    notification_email     = string
    app_name               = optional(string)
    trigger_enabled        = optional(bool, true)
    trigger_type           = optional(string, "Push")
    trigger_auto_abort     = optional(bool, false)
    trigger_branch         = optional(string, "main,master")
    trigger_connector_ref  = optional(string, "account.cahgithubro")
    manifest_connector_ref = optional(string, "account.cahgithubgitopsrw")
    manifest_identifier    = string
    manifest_path          = string
    manifest_branch        = optional(string, "master")
    manifest_repo          = string
    artifact_connector_ref = optional(string, "account.cahgcpartifactregistry")
    artifact_identifier    = string
    artifact_project       = optional(string, "artifacts-pr-cah")
    artifact_package       = string
    dr_enabled             = optional(bool, true)
  }))
  default = {}
}

variable "angular_services" {
  description = "Angular service definitions"
  type = map(object({
    repo_name              = string
    service_ref            = string
    language_version       = string
    notification_email     = string
    app_name               = optional(string)
    trigger_enabled        = optional(bool, true)
    trigger_type           = optional(string, "Push")
    trigger_auto_abort     = optional(bool, false)
    trigger_branch         = optional(string, "main,master")
    trigger_connector_ref  = optional(string, "account.cahgithubro")
    manifest_connector_ref = optional(string, "account.cahgithubgitopsrw")
    manifest_identifier    = string
    manifest_path          = string
    manifest_branch        = optional(string, "master")
    manifest_repo          = string
    artifact_connector_ref = optional(string, "account.cahgcpartifactregistry")
    artifact_identifier    = string
    artifact_project       = optional(string, "artifacts-pr-cah")
    artifact_package       = string
    dr_enabled             = optional(bool, true)
  }))
  default = {}
}

variable "python_services" {
  description = "Python service definitions"
  type = map(object({
    repo_name              = string
    service_ref            = string
    language_version       = string
    notification_email     = string
    app_name               = optional(string)
    trigger_enabled        = optional(bool, true)
    trigger_type           = optional(string, "Push")
    trigger_auto_abort     = optional(bool, false)
    trigger_branch         = optional(string, "main,master")
    trigger_connector_ref  = optional(string, "account.cahgithubro")
    manifest_connector_ref = optional(string, "account.cahgithubgitopsrw")
    manifest_identifier    = string
    manifest_path          = string
    manifest_branch        = optional(string, "master")
    manifest_repo          = string
    artifact_connector_ref = optional(string, "account.cahgcpartifactregistry")
    artifact_identifier    = string
    artifact_project       = optional(string, "artifacts-pr-cah")
    artifact_package       = string
    dr_enabled             = optional(bool, true)
  }))
  default = {}
}
