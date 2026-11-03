# Azure-EPP

## Azure DevOps Terraform pipeline

The pipeline definition is [pipelines/azure-pipelines.yml](./pipelines/azure-pipelines.yml). It checks formatting and configuration on branch and pull-request builds. On `main`, it creates a Terraform plan and applies that exact plan after the `dev` environment approval.

Before running it:

1. Install the Terraform extension that provides `TerraformInstaller@1` in the Azure DevOps organization.
2. Create the Azure Resource Manager service connection `sc-epp-dev`.
3. Create the Terraform state resource group and storage account with the separate bootstrap configuration:
   ```sh
   az login
   az account set --subscription "<subscription-id>"
   terraform -chdir=terraform/bootstrap init
   terraform -chdir=terraform/bootstrap validate
   terraform -chdir=terraform/bootstrap plan
   terraform -chdir=terraform/bootstrap apply
   ```
   The bootstrap configuration uses local state. Keep its `terraform.tfstate` file safe and do not commit it. The storage account disables shared-key access and public blob access.
4. In the created storage account, create a private blob container named `tfstate`. Grant the Azure DevOps service connection identity **Storage Blob Data Contributor** on the container so the pipeline can use Microsoft Entra ID to access Terraform state.
5. Create the `epp-terraform-backend-dev` variable group with these variables:
   - `tfstateResourceGroup`
   - `tfstateStorageAccount`
   - `tfstateContainer`
   - `tfstateKey`
6. Grant the service connection identity the minimum Azure resource permissions needed by the Terraform configuration.
7. Create the Azure DevOps environment named `dev` and configure its **Approvals and checks** before running the pipeline. The approval is configured on the environment, not in YAML.
8. In Azure DevOps, create a pipeline using `pipelines/azure-pipelines.yml`. For Azure Repos Git, configure a `main` branch build-validation policy if pull-request validation is required.

Terraform plan artifacts can contain sensitive values. Limit pipeline/artifact access to trusted users and keep artifact retention appropriately short.