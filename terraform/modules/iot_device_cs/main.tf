##############################################################
# Description:
# Liest den device connectionstring von IOT-HUB
# Wenn das device nicht vorhanden ist, wird ein neues edge device erstellt
##############################################################


data "shell_script" "dcs" {
  lifecycle_commands {
    read = file("${path.module}/scripts/script.sh")
  }

  environment = {
    IOTHUB_NAME     = var.input_iothub_name
    DEVICE_ID       = var.input_iothub_device_id
    SUBSCRIPTION_ID = var.input_subscription_id
  }
}
