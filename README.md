# cloud-init-examples

This repo demonstrates cloud-init with the examples:

- [simple](simple/readme.md)
- [iot-edge](iot-edge/readme.md)

More about cloud-init syntax see the [docs](https://cloudinit.readthedocs.io/).

# az cheat sheet

```bash
# list locations
az account list-locations -o table

# list images of ubuntu
az vm image list --all --location westeurope -f ubuntu 

# list all package versions
apt list -a aziot-edge
```