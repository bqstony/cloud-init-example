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
az login
az account set --subscription "yoursubscription"

cd terraform
terraform init -upgrade
terraform plan
terraform apply --auto-approve
```

## Cleanup

```bash
terraform destroy

# Delete resource groups
az group delete --yes --no-wait --name cloudinit-edge-dev-rg
az group delete --yes --no-wait --name cloudinit-dev-rg
```