terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.34.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "3167615c-646e-46e4-a729-28cf1b83629d"
  tenant_id       = "848a4408-e401-45d6-b9ac-a2d44f891fb2"
}