# Configure the Azure provider.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  # # terraform {
  # backend "azurerm" {
  #   resource_group_name  = "rg"
  #   storage_account_name = "dorrdor55"
  #   container_name       = "container12345"
  #   key                  = "Dorrdor55.tfstate"
  #   #depends_on = [ module.storage_account ]
  # }
}


# This block specifies the cloud provider as Azure.
provider "azurerm" {
  features {}
}

  