#Ignore terraform files from push  (git filter-branch -f --index-filter 'git rm --cached -r --ignore-unmatch .terraform/')

# Create a resource group
resource "azurerm_resource_group" "terraform-lab-RG" {
  name     = var.rgname
  location = var.location
}

# Create a virtual network
# Note: Ensure that the address space is correctly defined and that the virtual network is created before
resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rgname

}

resource "azurerm_subnet" "main" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.terraform-lab-RG.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]

}


resource "azurerm_network_security_group" "main" {
  name                = "terraform-lab-nsg"
  location            = var.location
  resource_group_name = var.rgname

  security_rule {
    name                       = "AllowRDP3389"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}



# Create a network interface
# Note: Ensure that the network interface is correctly referenced in the virtual machine resource.
# Also, ensure that the subnet and virtual network are created before the network interface.

resource "azurerm_network_interface" "terraform-lab-NIC" {
  name                = var.network_interface
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }

}

resource "azurerm_network_interface_security_group_association" "my_nic_nsg_association" {
  network_interface_id      = var.network_interface_ids
  network_security_group_id = var.network_security_group.id
}




# Create a virtual machine
# Note: Ensure that the virtual machine is created after the resource group, virtual network, subnet, and network interface.
# Also, ensure that the storage profile is correctly defined and that the OS

resource "azurerm_virtual_machine" "main" {
  name                  = var.virtualmachine_name
  location              = var.location
  resource_group_name   = var.rgname
  network_interface_ids = var.network_interface_ids
  vm_size               = var.vm_size


  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  os_profile {
    computer_name  = var.compute_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  storage_os_disk {
    name             = "${var.virtualmachine_name}-osdisk"
    caching          = "ReadWrite"
    create_option    = "FromImage"
    manage_disk_type = "Standard_LRS"
  }


  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }

}











