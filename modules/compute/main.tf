
/*
# we are creating modules for three resources
Resource group
1. Network interface create_option
2. Network Security group.
3. virutal machine.

*/

 # Resource group
 
 resource "azurerm_resource_group" "jbox-rg" {
  name     = var.vm-name
  location = var.location
}

#  Network Interface card

resource "azurerm_network_interface" "compute" {
  name                = "${var.vm-name}-nic"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
#  Network Security Group

resource "azurerm_network_security_group" "compute" {
  name                = "web-nsg"
  location            = var.location
  resource_group_name = var.rg
}

#  Virtual Machine

resource "azurerm_virtual_machine" "compute" {
  name                  = "${var.vm-name}"
  location              = var.location
  resource_group_name   = var.rg
  network_interface_ids = [azurerm_network_interface.compute.id]
  vm_size               = "Standard_B2s"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "web-osdisk"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "${var.vm-name}-vm01"
    admin_username = "testadmin"
    admin_password = var.admin_password
  }
  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }
}

# we defined five variable and we need to create these in moulde /variable.tf
/*
  vm-name
subnet_id
location
admin_password
rg
*/






