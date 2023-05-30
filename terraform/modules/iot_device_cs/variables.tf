####################
# MODULE VARIABLES #
####################

variable "input_iothub_name" {
  description = "The name of the iothub to get the device connectionstring"
  type        = string
}

variable "input_iothub_device_id" {
  description = "The id of the device to get the connectionstring from"
  type        = string
}

variable "input_subscription_id" {
  description = "The current environment subscription-id"
  type        = string
}
