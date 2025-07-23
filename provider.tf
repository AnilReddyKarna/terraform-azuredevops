terraform {
  # Specify the required providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.8.0"
    }
  }

  # Specify the required Terraform version
  # This is optional but recommended to ensure compatibility
  # with the features used in your configuration.
  required_version = ">= 1.12.0"
}

# Configure the Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.subscription_id
}