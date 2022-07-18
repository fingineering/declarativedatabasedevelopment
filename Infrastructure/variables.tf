variable "USERNAME" {
  type      = string
  sensitive = true
}

variable "DEVOPS_ORG" {
  type      = string
  sensitive = true
}

variable "SUBSCRIPTION" {
  type      = string
  sensitive = true
}

variable "USERPRINCIPAL" {
  type      = string
  sensitive = true
}

variable "AZ_LOCATION" {
  type = string
}

variable "TENANTID" {
  type = string
}

variable "DEVOPS_TOKEN" {
  type      = string
  sensitive = true
}
