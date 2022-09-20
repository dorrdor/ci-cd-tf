output "VN_ID" {
    value = azurerm_virtual_network.VN.id
}

output "VN" {
    value = azurerm_virtual_network.VN.name
}

output "RG" {
    value = azurerm_resource_group.resource_group.name
}

output "instances" {
    value = azurerm_linux_virtual_machine_scale_set.VMSS.instances
}