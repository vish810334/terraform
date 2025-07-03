resource "azurerm_resource_group" "firstrg" {
  for_each = toset(var.myfirstrg)
  name     = each.value
  location = "west us"
}

variable "myfirstrg" {
  default     = ["rg1", "rg2", "rg3"]
  description = "mera pahela rg"
}

variable "location" {
  default = "west us"
}