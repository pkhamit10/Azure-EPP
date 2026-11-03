# variable "subscription_id" {
#   description = "Azure subscription ID"
#   type        = string
# }

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "francecentral"
}

variable "tags" {
  description = "Tags applied to resources"
  type        = map(string)
  default     = {}
}
