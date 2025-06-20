terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }

}

provider "azurerm" {
  subscription_id = "3e65df0b-c119-4117-826a-4fd9adb12c14"
  tenant_id       = "d3dcf0e5-7332-4cfe-9c9d-e775711333b5"
  features {}
}