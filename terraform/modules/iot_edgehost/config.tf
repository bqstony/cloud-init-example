// Version Handling:
// - ~> Allow greater patch versions 1.1.x
// - >= Any newer version allowed x.x.x
// - >= 1.4.0, < 2.0.0 Avoids major version updates
terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.54.0"
    }
  }
}
