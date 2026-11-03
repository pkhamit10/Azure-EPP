variable "resource_group_name" {
  description = "Resource group for Terraform state storage."
  type        = string
  default     = "rg-aep-tfstate-frc-001"
}

variable "location" {
  description = "Azure region for the Terraform state resources."
  type        = string
  default     = "francecentral"
}

variable "storage_account_name" {
  description = "Globally unique storage account name (3-24 lowercase letters and numbers)."
  type        = string
  default     = "staeptfstatefrc0010"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "The storage account name must be 3-24 lowercase letters or numbers."
  }
}

variable "tags" {
  description = "Tags applied to the Terraform state resources."
  type        = map(string)
  default = {
    project     = "Azure-EPP"
    environment = "dev"
    purpose     = "terraform-state"
  }
}
