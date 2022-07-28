# Example of cloud-init in a simple use-case

## Deploy az vm

```bash
# create Ressource Group
az group create --name cloudinit-simple-dev-rg --location westeurope

# deploy ubuntu vm
az vm create \
    --resource-group cloudinit-simple-dev-rg \
    --name cloudinit-dev-vm \
    --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest \
    --admin-username azadmin \
    --generate-ssh-keys \
    --custom-data cloud-init.yml

# Open port
az vm open-port --port 80 --resource-group cloudinit-simple-dev-rg --name cloudinit-dev-vm
```

## Test

Open Browser with the ip: `http://[publicIpAdress]:80`

Connect to host an see the logs:

```bash
ssh azadmin@[publicIpAdress]

cloud-init status --long 
cat /etc/lsb-release
sudo less /run/cloud-init/instance-data-sensitive.json
cat /var/log/cloud-init-output.log
cat /var/log/cloud-init.log 
```

## Cleanup

```bash
# Delete resource groups
az group delete --yes --no-wait --name cloudinit-simple-dev-rg
```