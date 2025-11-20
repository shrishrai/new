module "resource_group" {
  source                  = "../module/azurerm_resource_group"
  resource_group_name     = "shrish2"
  resource_group_location = "centralindia"

}

module "virtual_network" {
  depends_on               = [module.resource_group]
  source                   = "../module/azurerm_virtual_network"
  virtual_network_name     = "vnet-shrish2"
  virtual_network_location = "centralindia"
  resource_group_name      = "shrish2"
  address_space            = ["10.0.0.0/16"]

}

module "frontend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../module/azurerm_subnet"

  subnet_name          = "frontend_subnet-shrish2"
  resource_group_name  = "shrish2"
  virtual_network_name = "vnet-shrish2"
  address_prefixes     = ["10.0.6.0/24"]
}

module "backend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../module/azurerm_subnet"

  subnet_name          = "backend_subnet-shrish2"
  resource_group_name  = "shrish2"
  virtual_network_name = "vnet-shrish2"
  address_prefixes     = ["10.0.0.0/24"]
}



module "sql_server" {
  source              = "../module/azurerm_sql_server"
  sql_server_name     = "sqlserver-shrish2"
  resource_group_name = "shrish2"
  sql_server_location = "centralindia"
  admin-login         = "login"
  admin-password      = "password"

}

module "db" {
  depends_on        = [module.sql_server]
  source            = "../module/azurerm_sql_database"
  sql_database_name = "sqldb-shrish2"
  sql_server_name   = "sqlserver-shrish2"

}

# module "backend_vm" {
#   source                    = "../module/azurerm_virtual_machine"

#   virtual_machine_name      = "backendvm"
#   virtual_machine_location  = "centralindia"
#   resource_group_name       = "shrish2"

#   nic_name                  = "nic-shrish2"
#   nic_location              = "centralindia"

#   subnet_name               = "backend_subnet-shrish2"

#   admin_login               = "login"
#   admin_password            = "password"
# }


module "frontend_vm" {

  source = "../module/azurerm_virtual_machine"

  virtual_machine_name     = "frontendvm"
  virtual_machine_location = "centralindia"
  resource_group_name      = "shrish2"
  nic_name                 = "nic-frontend-shrish2"
  nic_location             = "centralindia"
  admin_login              = "login"
  admin_password           = "password"
  subnet_name              = "frontend_subnet-shrish2"
}


module "pip" {
  source              = "../module/azurerm_public_ip"
  public_ip_name      = "pip-shrish2"
  resource_group_name = "shrish2"
  public_ip_location  = "centralindia"

}