variable "resource_group_location" {
  type        = string
  default     = "uksouth"
  description = "Location of the resource group."
}

# variable "resource_group_name_prefix" {
#   type        = string
#   default     = "rg"
#   description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
# }

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "keycloakuser"
}



variable "dns_zone_name" {
  type        = string
  default     = "keycloak-hylastix.uksouth.cloudapp.azure.com"
  description = "Name of the DNS zone."
}

variable "dns_ttl" {
  type        = number
  default     = 3600
  description = "Time To Live (TTL) of the DNS record (in seconds)."
}

# variable "dns_records" {
#   type        = list(string)
#   default     = ["1.2.3.4", "1.2.3.5"]
#   description = "List of IPv4 addresses."
# }