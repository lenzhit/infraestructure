variable "prefix" {
  description = "Project name"
  type        = string
  nullable    = false
}

variable "environment" {
  description = "ej. dev staging prod"
  type        = string
  nullable    = false
}

variable "location" {
  description = "Location of resources"
  type        = string
  nullable    = false
}

variable "rg_name" {
  description = "Resource Group Name"
  type        = string
  nullable    = false
}

variable "vnet_cidr" {
  type        = string
  description = "Cidr range for the Virtual Network"
  nullable    = false
}

variable "gateway_subnet_cidr" {
  type        = string
  description = "Cidr range for Gateway Subnet"
  nullable    = false
}

variable "aks_subnet_cidr" {
  type        = string
  description = "Cidr range for AKS Subnet"
  nullable    = false
}
