variable "rgname" {
type = string
description = "This is the name of resource group"
}

variable "location" {
    type = string
    description = "This is location variable"
  
}

variable "virtualmachine_name" {
    type = string
    description = "This is the name of the virtual machine"
  
}

  variable "network_interface" {
        type = string
        description = "This is the name of the network interface"
    }

    variable "virtual_network_name" {
        type = string
        description = "This is the name of the virtual network" 
      
    }

    variable "network_security_group" {
        type = string
        description = "This is the name of the network security group"
    }

variable "vm_size" {
    type = string
    description = "This is the size of the virtual machine"
    default = "windows-b2ms-vm"
}

variable "admin_username" {
    type = string
    description = "This is the admin username for the virtual machine"
}

variable "admin_password" {
    type = string
    description = "This is the admin password for the virtual machine"
    sensitive = true
}



variable "image_offer" {
    type = string
    description = "This is the image offer for the virtual machine"
    default = "WindowsServer"
  
}

variable "image_sku" {
    type = string
    description = "This is the image SKU for the virtual machine"
    default = "2019-Datacenter"
}

variable "image_publisher" {
    type = string
    description = "This is the image publisher for the virtual machine"
    default = "MicrosoftWindowsServer"

}
  
  variable "compute_name" {
    type = string
    description = "This is the computer name for the virtual machine"
    default = "newksinghvm"
  } 

variable "terraform-lab-NIC" {
    type = string
    description = "This is the name of the network interface"
    default = "terraform-lab-nic"
  
}

variable "network_interface_ids" {
  type        = list(string)
  default     = null
  description = "A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine. Cannot be used along with `new_network_interface`."

  validation {
    condition     = var.network_interface_ids == null ? true : length(var.network_interface_ids) > 0
    error_message = "`network_interface_ids` must be `null` or a non-empty list."
  }
}