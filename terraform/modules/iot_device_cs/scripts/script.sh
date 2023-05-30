#!/bin/bash

# For Testing purpose:
# DEVICE_ID="loud-init-edge-01"
# IOTHUB_NAME="cloudinit-dev-iot"
# SUBSCRIPTION_ID="yoursubscription"

az config set extension.use_dynamic_install=yes_without_prompt 2> /dev/null

# If the stdErr returns a text contains DeviceNotFound, it will create a new device
if az iot hub device-identity show --hub-name $IOTHUB_NAME --device-id $DEVICE_ID --subscription $SUBSCRIPTION_ID 2>&1 | grep -qi 'DeviceNotFound'; then
    echo "Device does not exist, create it"
    az iot hub device-identity create --hub-name $IOTHUB_NAME --edge-enabled true --device-id $DEVICE_ID --subscription $SUBSCRIPTION_ID
fi

# Requires echo for parsing the az stdout encoding
echo $(az iot hub device-identity connection-string show --hub-name $IOTHUB_NAME --device-id $DEVICE_ID --subscription $SUBSCRIPTION_ID)
