module "vnet" {
  source              = "./modules/vnet"
  prefix              = var.prefix
  environment         = var.environment
  location            = var.location
  rg_name             = local.rg_name
  vnet_cidr           = local.vnet_cidr[var.environment]
  gateway_subnet_cidr = local.gateway_subnet_cidr[var.environment]
  aks_subnet_cidr     = local.aks_subnet_cidr[var.environment]
}
