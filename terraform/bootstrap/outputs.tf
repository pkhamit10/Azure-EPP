output "resource_group_name" {
  description = "Resource group containing the Terraform state storage account."
  value       = azurerm_resource_group.state.name
}

output "storage_account_name" {
  description = "Storage account name for the Terraform state backend."
  value       = azurerm_storage_account.state.name
}

output "storage_account_id" {
  description = "Resource ID of the Terraform state storage account."
  value       = azurerm_storage_account.state.id
}
