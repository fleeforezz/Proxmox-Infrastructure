output "cockpit_server" {
  description = "Cockpit server information"
  value = {
    name = module.cockpit_server.vm_name
    ip_address = module.cockpit_server.ip_address
    vm_id = module.cockpit_server.vm_id
  }
}