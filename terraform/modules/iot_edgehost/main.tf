##############################################################
# Description:
# Erstellen eines IOT Edge Host
##############################################################

locals {
  middlename = "simu-edgehost"
  // ToDo: MiHe - Replace the 2 at the end, this is for testing
  ressource_prefix = "${var.input_ressource_prefix}-${var.input_ressource_middlename}-${var.input_environment}"
}

# ╔══════════════════════════════════════════════════════════╗
# ║                      Setup Network                       ║
# ╚══════════════════════════════════════════════════════════╝
resource "azurerm_network_interface" "edgehost_nic" {
  name                = "${local.ressource_prefix}-nic"
  location            = var.input_ressource_location
  resource_group_name = var.input_resourcegroup_name
  tags                = var.input_tags
  ip_configuration {
    name                          = "ipconfig-mainsubnet"
    subnet_id                     = var.input_vm_nic_subnet_id
    primary                       = true
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
  }
}

# ╔══════════════════════════════════════════════════════════╗
# ║                 Setup VM with cloud init                 ║
# ╚══════════════════════════════════════════════════════════╝
# Load cloud-init config file
data "template_file" "edgehost_cloudinit_file" {
  template = file(var.input_vm_cloudinit_path)
  // The vars are replaced with the Varialbes marked as ${...} in the template file
  vars = {
    "dcs" = var.input_edge_connectionstring
    "certfilename" = var.input_edge_cert_filenmae
  }
}

# Render cloud-init config file as base64
data "template_cloudinit_config" "edgehost_cloudinit_config" {
  gzip          = true
  base64_encode = true

  # Main cloud-init configuration file.
  part {
    content_type = "text/cloud-config"
    content      = data.template_file.edgehost_cloudinit_file.rendered
  }
}

# Create the VM
resource "azurerm_linux_virtual_machine" "edgehost_vm" {
  name                            = "${local.ressource_prefix}-vm"
  location                        = var.input_ressource_location
  resource_group_name             = var.input_resourcegroup_name
  tags                            = var.input_tags

  // Standard_DS1_v2 => vCPU=1; RAM=3.5GB, IOPS=3200, TempStorage=7GB
  // B1ms = vCPU=1; RAM=2GB, IOPS=640, TempStorage=4GB
  // B2s = vCPU=2; RAM=4GB, IOPS=1280, TempStorage=8GB
  size                            = "Standard_B2s"
  computer_name                   = "${local.ressource_prefix}-vm"
  admin_username                  = var.input_vm_admin_username
  admin_password                  = var.input_vm_admin_password

  // Install the packages for edge device and set the connectionstring, see cloud-init.yml
  // When the customData / cloud-init file are changed, the VM will be destroyed and rebuild.
  custom_data                     = data.template_cloudinit_config.edgehost_cloudinit_config.rendered

  disable_password_authentication = false
  network_interface_ids           = [
    azurerm_network_interface.edgehost_nic.id,
  ]

  // Allows Serial console and diagnostic tools
  boot_diagnostics {
    // Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics
    storage_account_uri = null
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  // To List the available images use:
  // az vm image list --all --location switzerlandwest -f ubuntu
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}
