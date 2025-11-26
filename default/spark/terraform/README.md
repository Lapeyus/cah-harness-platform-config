# Harness Cardinal - Spark Team

This Terraform configuration creates and manages the Harness infrastructure for the Spark team, including:

- **Harness Project**: Team project with RBAC and Workload Identity Federation (WIF)
- **CI/CD Pipelines**: Build and deployment pipelines for multiple service types
- **Services**: Harness service definitions with GitOps integration
- **Triggers**: Automated pipeline triggers for GitHub events
- **Input Sets**: Pre-configured pipeline inputs for each service

## Architecture

```
harness-cardinal/
├── main.tf              # Main module configuration
├── variables.tf         # Variable definitions
├── terraform.tfvars     # Variable values (team & services config)
├── outputs.tf           # Output definitions
└── README.md           # This file
```

## Prerequisites

- Terraform >= 1.0
- Harness provider ~> 0.14
- Access to Cardinal Health Harness account
- GCP projects for non-production and production

## Configuration

### Team Configuration

Edit `terraform.tfvars` to configure team settings:

```hcl
team_config = {
  project_name          = "spark"
  apmid                 = "APM0031732"
  cost_center           = "CC123456"
  gcp_project_np        = "spark-np"
  gcp_project_pr        = "spark-pr"
  gcp_artifacts_project = "spark-pr"
}
```

### Adding Services

Add services to the appropriate section in `terraform.tfvars`:

#### Gradle Service Example

```hcl
gradle_services = {
  "my-service" = {
    repo_name          = "my-org/my-service"
    service_ref        = "myservice"
    language_version   = "java-17"
    notification_email = "team@example.com"
    
    manifest_identifier = "myservice"
    manifest_path       = "<+env.name>/myservice-config-<+env.name>.yaml"
    manifest_repo       = "my-org/gitops-repo"
    
    artifact_identifier = "myservice_image"
    artifact_package    = "<+pipeline.variables.APP_NAME>"
    
    dr_enabled = true
  }
}
```

#### DotNet Service Example

```hcl
dotnet_services = {
  "my-dotnet-api" = {
    repo_name          = "my-org/dotnet-api"
    service_ref        = "dotnetapi"
    language_version   = "dotnet-8"
    notification_email = "team@example.com"
    
    # Use PullRequest trigger instead of Push
    trigger_type = "PullRequest"
    
    manifest_identifier = "dotnetapi"
    manifest_path       = "<+env.name>/api-config-<+env.name>.yaml"
    manifest_repo       = "my-org/gitops-repo"
    
    artifact_identifier = "dotnetapi_image"
    artifact_package    = "<+pipeline.variables.APP_NAME.toLowerCase()>"
  }
}
```

## Usage

### Initialize Terraform

```bash
cd harness-cardinal
terraform init
```

### Plan Changes

```bash
terraform plan
```

### Apply Configuration

```bash
terraform apply
```

**Note**: Use `-parallelism=1` when applying to avoid Git conflicts in remote state:

```bash
terraform apply -parallelism=1
```

### View Outputs

```bash
terraform output
```

## What Gets Created

### For Each Team:

1. **Harness Project** (`spark`)
   - Organization: `Cardinal_Health`
   - RBAC: Admin user group with auto-generated ID
   - WIF: Dual-environment (NP/PR) Workload Identity Federation

2. **GCP Connectors**
   - Non-production GCP connector
   - Production GCP connector

### For Each Service Type:

1. **Pipeline** (shared by all services of the same type)
   - Gradle: `gradle_build_deploy_pipeline`
   - DotNet: `dotnet_build_deploy_pipeline`

2. **Per Service Resources**:
   - **Service Definition**: GitOps-enabled with manifests and artifacts
   - **Input Set**: Pre-configured values for all pipeline stages
   - **Trigger**: GitHub webhook trigger (Push or PullRequest)

## Service Trigger Types

- **Push Trigger**: Fires on commits to specified branches (default)
- **PullRequest Trigger**: Fires when PRs are closed/merged

Set `trigger_type = "PullRequest"` for PR-based deployments.

## Deployment Stages

Each pipeline includes the following stages:

1. **Build** - Build and containerize the application
2. **Deploy DEV** - Deploy to development environment
3. **Deploy QA** - Deploy to QA environment (requires approval)
4. **Release** - Create semantic version tag
5. **Deploy STG** - Deploy to staging environment
6. **Change Management** - ServiceNow change request validation
7. **Deploy PRD** - Deploy to production (requires approval)
8. **Deploy DR** - Deploy to disaster recovery (conditional)

## Outputs

| Output | Description |
|--------|-------------|
| `project_id` | Harness project identifier |
| `admins_usergroup_identifier` | Admin user group ID |
| `gradle_pipeline_id` | Gradle pipeline identifier |
| `dotnet_pipeline_id` | DotNet pipeline identifier |
| `services_summary` | Count of services by type |
| `gradle_services_list` | List of Gradle service names |
| `dotnet_services_list` | List of DotNet service names |

## Examples

### Current Configuration

This configuration creates:

- **2 Gradle Services**: `gradle-poc`, `best_app_ever`
- **2 DotNet Services**: `dotnet-helloworldapi`, `is_always_dns`
- **2 Pipelines**: One shared Gradle pipeline, one shared DotNet pipeline
- **4 Services, 4 Input Sets, 4 Triggers**: One set per service

### Adding a New Service

1. Edit `terraform.tfvars`
2. Add your service to the appropriate section (`gradle_services`, `dotnet_services`, etc.)
3. Run `terraform apply -parallelism=1`

## Directory Structure in Harness

```
Cardinal_Health/
└── spark/
    ├── Pipelines
    │   ├── gradle_build_deploy_pipeline
    │   └── dotnet_build_deploy_pipeline
    ├── Services
    │   ├── gradlepoc
    │   ├── bast_app_ever
    │   ├── dotnethelloworldapi
    │   └── my_dotnet_service
    ├── Input Sets
    │   ├── gradle_poc_inputs
    │   ├── best_app_ever_inputs
    │   ├── dotnet_helloworldapi_inputs
    │   └── is_always_dns_inputs
    └── Triggers
        ├── gradle-poc Push Trigger
        ├── best_app_ever Push Trigger
        ├── dotnet-helloworldapi PullRequest Trigger
        └── is_always_dns Push Trigger
```

## Troubleshooting

### Git Conflicts

If you see errors about Git conflicts when applying:
```bash
terraform apply -parallelism=1
```

### Identifier Errors

Harness identifiers cannot contain hyphens. The module automatically converts:
- `gradle-poc` → `gradle_poc_inputs` (for input sets)
- `dotnet-helloworldapi` → `dotnet_helloworldapi_inputs`

## Maintenance

### Updating Services

Modify the service config in `terraform.tfvars` and run:
```bash
terraform apply -parallelism=1
```

### Removing Services

Remove the service from `terraform.tfvars` and apply changes. This will destroy the service, input set, and trigger.

## Support

For questions or issues:
- Harness Documentation: https://docs.harness.io
- Internal Team Channel: #harness-support
