
resource "azurerm_resource_group" "ericsson" {
  name     = "ericsson"
  location = "West Europe"
}



resource "azurerm_virtual_network" "vnetericsson" {
 
  name                = "vnetericsson"
  location            = azurerm_resource_group.ericsson.location
  resource_group_name = azurerm_resource_group.ericsson.name
  address_space       = ["172.1.0.0/16"]

}
resource "azurerm_subnet" "ericpcrf" {
  name                 = "pcrf"
  resource_group_name  = azurerm_resource_group.ericsson.name
  virtual_network_name = azurerm_virtual_network.vnetericsson.name
  address_prefixes     = ["172.1.0.0/16"]
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                = "vm-public-ip"
  location            = azurerm_resource_group.ericsson.location
  resource_group_name = azurerm_resource_group.ericsson.name
  allocation_method   = "Dynamic" # Or "Static"
  sku                 = "Basic"
}
resource "azurerm_network_interface" "ericnic" {
  name                = "ericsson-nic"
  location            = azurerm_resource_group.ericsson.location
  resource_group_name = azurerm_resource_group.ericsson.name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ericpcrf.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id

  }
  }
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "ericsson-vm"
  resource_group_name = azurerm_resource_group.ericsson.name
  location            = azurerm_resource_group.ericsson.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password = "Adira@99550"
  network_interface_ids = [
    azurerm_network_interface.ericnic.id,
  ]

 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "myosdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name  = "ericssonvm"
  disable_password_authentication = false
}








