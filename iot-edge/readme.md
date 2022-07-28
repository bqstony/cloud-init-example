# Example of cloud-init in a iot edge use-case

## Prepare environment 

```bash
# create Ressource Group
az group create --name cloudinit-dev-rg --location westeurope

# create iot hub
az iot hub create --resource-group cloudinit-dev-rg --name cloudinit-dev-iot --sku F1 --partition-count 2 --location westeurope

# create edge device in the iot hub
az iot hub device-identity create --hub-name cloudinit-dev-iot --edge-enabled true --device-id cloud-init-edge-01

# deploy manifest to device
az iot edge set-modules --hub-name cloudinit-dev-iot --device-id cloud-init-edge-01 --content deployment.cloud-init-edge-01.amd64.json
```

## Deploy az vm

```bash
# create Ressource Group
az group create --name cloudinit-edge-dev-rg --location westeurope

# deploy edge vm
az deployment group create \
--resource-group cloudinit-edge-dev-rg \
--template-file "cloudinitedgehostDeploy.jsonc" \
--parameters cloudinitedgehostDeploy.parameters.dev.json edgeVmConnectionString=$(az iot hub device-identity connection-string show --device-id cloud-init-edge-01 --hub-name cloudinit-dev-iot -o tsv)
```

## Cleanup

```bash
# Delete resource groups
az group delete --yes --no-wait --name cloudinit-edge-dev-rg
az group delete --yes --no-wait --name cloudinit-dev-rg
```