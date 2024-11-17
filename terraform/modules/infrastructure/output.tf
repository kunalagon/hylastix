data "azurerm_public_ip" "example" {
  name                = azurerm_public_ip.keycloak_public_ip.name
  resource_group_name = azurerm_linux_virtual_machine.keycloak_terraform_vm.resource_group_name
}

#output "domain_name_label" {
#  value = data.azurerm_public_ip.example.domain_name_label
#}

output "public_ip_address" {
  value = data.azurerm_public_ip.example.ip_address
}

output "public_ip_address_id" {
  value = azurerm_public_ip.keycloak_public_ip.id
}

output "fqdn" {
  value = azurerm_public_ip.keycloak_public_ip.fqdn
}
