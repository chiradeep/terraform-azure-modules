variable "resource_group_name" {
  description = "The name of the resource group under which the resources will be created"
}

variable "name" {}

variable "location" {
  description = "The name of the Azure region (e.g., West US)"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "storage_account_type" {
  description = "Defines the type of storage account to be created, e.g., Standard_LRS, Standard_ZRS, Standard_GRS"
  default     = "Standard_LRS"
}

variable "container_access_type" {
  description = "The 'interface' for access the container provides. Can be either blob, container or private"
  default     = "private"
}
