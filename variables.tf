locals {
  rg_name              = "1-1f1c0a9e-playground-sandbox"
  storage_account_name = "${var.prefix}${var.environment}sa"

  vnet_cidr = {
    "dev"  = "10.0.0.0/16"
    "stg"  = "10.1.0.0/16"
    "prod" = "10.2.0.0/16"
  }

  gateway_subnet_cidr = {
    "dev"  = "10.0.0.0/24"
    "stg"  = "10.1.0.0/24"
    "prod" = "10.2.0.0/24"
  }

  aks_subnet_cidr = {
    "dev"  = "10.0.1.0/24"
    "stg"  = "10.1.1.0/24"
    "prod" = "10.2.1.0/24"
  }

}

variable "location" {
  description = "location of resources"
  default     = "eastus2"
  type        = string
}

variable "prefix" {
  description = "name project"
  default     = "kp"
  type        = string
}

variable "environment" {
  description = "Deployment environment. Allowed: dev, stg, prod"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "stg", "prod"], var.environment)
    error_message = "The environment must be one of: dev, stg, prod."
  }
}
