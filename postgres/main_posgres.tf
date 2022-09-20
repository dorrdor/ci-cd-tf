# create postgresqlflexible

resource "azurerm_subnet" "pos_sub" {
  name                 = "pos_sub"
  resource_group_name  = var.RG
  virtual_network_name = var.VN
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "post-dns" {
  name                = "post-dns.postgres.database.azure.com"
  resource_group_name = var.RG
  depends_on            = [ azurerm_subnet_network_security_group_association.postgres_sub_nsg_assoc ]

}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "dns-link.com"
  private_dns_zone_name = azurerm_private_dns_zone.post-dns.name
  virtual_network_id    = var.VN_ID
  resource_group_name   = var.RG
  depends_on            = [ azurerm_private_dns_zone.post-dns ]
}

resource "azurerm_postgresql_flexible_server" "posserver" {
  name                   = "posserver"
  resource_group_name    = var.RG
  location               = var.loc
  version                = "12"
  delegated_subnet_id    = azurerm_subnet.pos_sub.id
  private_dns_zone_id    = azurerm_private_dns_zone.post-dns.id
  administrator_login    = "adminuser"
  administrator_password = "dorrdor55"
  create_mode            = "Default"
  zone                   = "1"
  storage_mb             = 32768
  #ssl_enforcement_enabled       = false
  #public_network_access_enabled = true
  sku_name   = "GP_Standard_D4s_v3"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_link]
}

resource "azurerm_postgresql_flexible_server_configuration" "post-config" {
  name      = "post-config"
  server_id = azurerm_postgresql_flexible_server.posserver.id
  value     = "off"

  #depends_on = [azurerm_postgresql_flexible_server.posserver]

}

resource "azurerm_postgresql_flexible_server_database" "pos_database" {
  name      = "pos_database"
  server_id = azurerm_postgresql_flexible_server.posserver.id
  collation = "en_US.utf8"
  charset   = "utf8"

}


resource "azurerm_postgresql_flexible_server_firewall_rule" "postgres_rule" {
  name             = "postgres_rule"
  server_id        = azurerm_postgresql_flexible_server.posserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

#nsg for postgres

resource "azurerm_network_security_group" "postgres-nsg" {
  name                = "postgres-nsg"
  location            = var.loc
  resource_group_name = var.RG

  security_rule {
    name                       = "5432"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "22"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "postgres_sub_nsg_assoc" {
  subnet_id                 = azurerm_subnet.pos_sub.id
  network_security_group_id = azurerm_network_security_group.postgres-nsg.id
}


