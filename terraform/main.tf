##############################################################
# Description:
# Creating Edge Hosts for the simulation
##############################################################

resource "azurerm_resource_group" "simu_edgehost_rg" {
  name     = "cloudinit-terraform-dev-rg"
  location = "westeurope"
  tags     = var.tags_default
}

# ╔══════════════════════════════════════════════════════════╗
# ║                          edgehost                        ║
# ╚══════════════════════════════════════════════════════════╝

module "edgehost_dcs" {
  source                      = "./modules/iot_device_cs"
  // The iothub name must match!
  input_iothub_name           = "cloudinit-dev-iot"
  input_iothub_device_id      = "cloud-init-edge-01"
  input_subscription_id       = data.azurerm_client_config.current.subscription_id
}

module "edgehost" {
  source                      = "./modules/iot_edgehost"
  input_resourcegroup_name    = azurerm_resource_group.simu_edgehost_rg.name
  input_ressource_prefix      = "cloudinit"
  input_ressource_middlename  = "edgehost"
  input_ressource_location    =  azurerm_resource_group.simu_edgehost_rg.location
  input_environment           = "dev"
  input_tags                  = null
  input_vm_nic_subnet_id      = data.azurerm_subnet.network_vnet_main_subnet.id
  input_vm_admin_username     = "azadmin"
  input_vm_admin_password     = "12345ABCDEF"
  input_vm_cloudinit_path     = "scripts/simu-edgehost/cloud-init.yml"
  input_edge_connectionstring = module.edgehost_dcs.output_iothub_device_dcs
  input_edge_cert_filenmae    = "mycert"
}
