provider "azurerm" {
  features {}
  subscription_id = "8d7f15b5-912d-4e64-8326-6a8f95f8ebd2"
}

# Use existing Resource Group
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = [var.vnet_address_space]
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}
