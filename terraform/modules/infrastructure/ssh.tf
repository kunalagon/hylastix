resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
#  name      = random_pet.ssh_key_name.id
  name = "Keycloak_ssh_public_key"
  location  = azurerm_resource_group.keycloak_rg.location
  parent_id = azurerm_resource_group.keycloak_rg.id
}

output "key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.publicKey
}

output "javni_kljuc" {
  value = azapi_resource_action.ssh_public_key_gen.output.privateKey
}
