# output "resource_group_name" {
#     value = azurerm_resource_group.default.name
# }

output "azurerm_postgresql_flexible_server" {
    value = azurerm_postgresql_flexible_server.posserver.name
}

output "postgresql_flexible_server_database_name" {
    value = azurerm_postgresql_flexible_server_database.pos_database.name
}