resource "azurerm_ssh_public_key" "keycloak" {
  name                = "keycloak_vm_pk"
  resource_group_name = azurerm_resource_group.keycloak_rg.name
  location            = "uksouth"
  # public_key          = file("~/.ssh/id_rsa.pub")
  public_key          = file("public_key.pub")
}
