resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.sql_server_location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.administrator_login.value
  administrator_login_password = data.azurerm_key_vault_secret.administrator_login_password.value
  

  tags = {
    environment = "production"
  }
}

data "azurerm_key_vault" "kv" {
  name                = "peti"
  resource_group_name = "shrishkeypeti"
}

data "azurerm_key_vault_secret" "administrator_login" {
  name         = var.admin-login
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "administrator_login_password" {
  name         = var.admin-password
  key_vault_id = data.azurerm_key_vault.kv.id
}