terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.32.0"
    }
  }

  # Estos valores se pasan por parametro en el Terraform Init
  # backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = "2213e8b1-dbc7-4d54-8aff-b5e315df5e5b"
	resource_provider_registrations = "none"
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id
}
