resource "azurerm_resource_group" "rg-devops" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "vnet-devops" {
  name                = "${var.prefix}-vnet1"
  resource_group_name = azurerm_resource_group.rg-devops.name
  location            = azurerm_resource_group.rg-devops.location
  address_space       = var.vnet_address_space
}
resource "azurerm_subnet" "subnet_devops" {
  name                 = "${var.prefix}-subnet1"
  resource_group_name  = azurerm_resource_group.rg-devops.name
  virtual_network_name = azurerm_virtual_network.vnet-devops.name
  address_prefixes     = var.subnet_address_prefixes
}
resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg-devops.location
  resource_group_name = azurerm_resource_group.rg-devops.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet_devops.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.rg-devops.location
  resource_group_name   = azurerm_resource_group.rg-devops.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_B1ms"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.hostname
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.environment
  }
}