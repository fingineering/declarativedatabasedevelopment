terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.9.0"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">0.1.0"
    }
    curl = {
      source  = "anschoewe/curl"
      version = ">=0.1.4"
    }
  }
}

provider "curl" {}
provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/${var.DEVOPS_ORG}"
  personal_access_token = var.DEVOPS_TOKEN
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }

  subscription_id = var.SUBSCRIPTION
}

data "azurerm_client_config" "current" {}

data "curl" "getIp" {
  http_method = "GET"
  uri         = "https://api.ipify.org"
}


locals {
  shell = fileexists("/bin/bash") ? "/bin/bash" : "powershell.exe"
  script = fileexists("/bin/bash") ? "az_user.sh": "az_user.ps1"
}
data "external" "az_userid" {
  program = [
    local.shell, local.script
  ]
}

locals {
  my_ip = data.curl.getIp.response
}

locals {
  my_id = data.external.az_userid.result.my_id
}

output "current_ip" {
  value       = local.my_ip
  description = "My current Ip"
}

output "my_azuer_id" {
  value = local.my_id
}



// define a resource group
resource "azurerm_resource_group" "rg-database-demo" {
  name     = "rg-database-demo-${var.USERNAME}"
  location = var.AZ_LOCATION
}

// SQL Server
# A SQL Server 
resource "azurerm_mssql_server" "my_sql_server" {
  name                = lower("${var.USERNAME}s-server")
  resource_group_name = azurerm_resource_group.rg-database-demo.name
  location            = azurerm_resource_group.rg-database-demo.location
  version             = "12.0"
  minimum_tls_version = "1.2"
  # should be only for dev
  public_network_access_enabled = true
  connection_policy             = "Proxy"

  azuread_administrator {
    login_username              = var.USERPRINCIPAL
    object_id                   = local.my_id
    tenant_id                   = var.TENANTID
    azuread_authentication_only = true
  }
}

#  // SQL Database
resource "azurerm_mssql_database" "demodb" {
  name      = "demo-${var.USERNAME}"
  server_id = azurerm_mssql_server.my_sql_server.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  #license_type   = "LicenseIncluded"
  sku_name             = "S0"
  zone_redundant       = false
  storage_account_type = "Zone"
}

resource "azurerm_mssql_firewall_rule" "db-users-laptop" {
  name             = "${var.USERNAME}-Laptop"
  server_id        = azurerm_mssql_server.my_sql_server.id
  start_ip_address = local.my_ip
  end_ip_address   = local.my_ip
}

# // Azure DevOps Repository
# resource "azuredevops_project" "DeclarativeDatabaseDevelopment" {
#   name = "DeclarativeDatabaseDevelopment"
#   #   description        = "Projekt zum Aufbaut einer Data Logistics "
#   version_control    = "Git"
#   visibility         = "private"
#   work_item_template = "Basic"
# }

resource "azuredevops_git_repository" "my_database" {
  project_id = var.DEVOPS_PROJECT
  name       = "demo-${var.USERNAME}"
  initialization {
    init_type = "Uninitialized"
  }
}
