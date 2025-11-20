data "azurerm_public_ip" "public_ip" {
  name                = "pip-shrish2"
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = "peti"
  resource_group_name = "shrishkeypeti"
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = var.admin_login
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = var.admin_password
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = "vnet-shrish2"
  resource_group_name  = var.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.nic_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.virtual_machine_location
 size = "Standard_B1ms"
  admin_username      = data.azurerm_key_vault_secret.admin_username.value
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
