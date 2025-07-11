resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-${var.environment}-vnet"
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = [var.vnet_cidr]
}

###################
# AKS SUBNET
###################
resource "azurerm_subnet" "aks" {
  name                 = "${var.prefix}-${var.environment}-aks-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.aks_subnet_cidr]

  service_endpoints = ["Microsoft.Storage"]
}

##################
# GATEWAY SUBNET
##################
resource "azurerm_network_security_group" "gateway_nsg" {
  name                = "${var.prefix}-${var.environment}-gateway-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "gateway" {
  name                 = "${var.prefix}-${var.environment}-gateway-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.gateway_subnet_cidr]
}

resource "azurerm_subnet_network_security_group_association" "gateway_nsg_association" {
  subnet_id                 = azurerm_subnet.gateway.id
  network_security_group_id = azurerm_network_security_group.gateway_nsg.id
}

resource "azurerm_public_ip" "this" {
  name                = "${var.prefix}-${var.environment}-public-ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [1]
}

#Nat Gateway
resource "azurerm_nat_gateway" "this" {
  name                    = "${var.prefix}-${var.environment}-nat"
  location                = var.location
  resource_group_name     = var.rg_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = [1]
}

# Nat - Public IP Association
resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.this.id
}

# NAT - Subnets association
resource "azurerm_subnet_nat_gateway_association" "this" {
  subnet_id      = azurerm_subnet.gateway.id
  nat_gateway_id = azurerm_nat_gateway.this.id
}
