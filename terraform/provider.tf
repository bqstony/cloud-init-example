// Version Handling:
// - ~> Allow greater patch versions 1.1.x
// - >= Any newer version allowed x.x.x
// - >= 1.4.0, < 2.0.0 Avoids major version updates
terraform {

  required_version = ">= 1.4.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.54.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.5.0"
    }
  }

  backend "local" {}
}

provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }
}

// Used to access the current configuration of the AzureRM provider.
data "azurerm_client_config" "current" {
}
