variable "USERNAME" {
  type      = string
  sensitive = true
}

variable "DEVOPS_ORG" {
  type      = string
  sensitive = true
}

variable "DEVOPS_PROJECT" {
  type = string
  sensitive = false
  description = "The Name of the Azure DevOps Project to create the repostory in"
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
