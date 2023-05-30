####################
# MODULE OUTPUTS   #
####################

output "output_iothub_device_dcs" {
  description = "The device connectionstring"
  sensitive   = true
  // Expect a json like {"connectionString": "dcs"}
  value       = data.shell_script.dcs.output["connectionString"]
}
