terraform {
  required_version = ">=1.12.0"
  required_providers {
    
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "backend_rg_dont_delete"
    storage_account_name = "stgannuback"
    container_name       = "stgannuback"
    key                  = "pipeline.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "2725a90a-ca7e-4474-afbb-38294afb9db3"
}
