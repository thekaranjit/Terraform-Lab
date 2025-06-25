#Ignore terraform files from push  (git filter-branch -f --index-filter 'git rm --cached -r --ignore-unmatch .terraform/')

# Create a resource group
resource "azurerm_resource_group" "terraform-lab-RG" {
  name     = "${var.rgname}"
  location = "${var.location}"
}

