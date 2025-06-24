# Create a resource group
resource "azurerm_resource_group" "terraform-lab-RG" {
  name     = "Terraform-Lab-RG"
  location = "Central India"
}

