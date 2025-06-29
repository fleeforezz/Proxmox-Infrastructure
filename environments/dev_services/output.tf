#=======================
# Version Control Server
#=======================
output "gitlab_server" {
  description = "Gitlab Version Control Server"
  value = {
    name = module.gitlab_server.vm_name
    ip_address = module.gitlab_server.ip_address
    vm_id = module.gitlab_server.vm_id
  }
}

#==========================
# Cockpit Management Server
#==========================
output "cockpit_management_server" {
  description = "Cockpit Management Server"
  value = {
    name = module.cockpit_management_server.vm_name
    ip_address = module.cockpit_management_server.ip_address
    vm_id = module.cockpit_management_server.vm_id
  }
}

#====================
# Network Gate Server
#====================
output "network_gate_server" {
  description = "Network Gate Server"
  value = {
    name = module.network_gate_server.vm_name
    ip_address = module.network_gate_server.ip_address
    vm_id = module.network_gate_server.vm_id
  }
}

#=====================
# Reverse Proxy Server
#=====================
output "reverse_proxy_server" {
  description = "Reverse Proxy Server"
  value = {
    name = module.reverse_proxy_server.vm_name
    ip_address = module.reverse_proxy_server.ip_address
    vm_id = module.reverse_proxy_server.vm_id
  }
}

#==================
# Monitoring Server
#==================
output "monitoring_server" {
  description = "Reverse Proxy Server"
  value = {
    name = module.monitoring_server.vm_name
    ip_address = module.monitoring_server.ip_address
    vm_id = module.monitoring_server.vm_id
  }
}

#================
# Security Server
#================
output "security_server" {
  description = "Reverse Proxy Server"
  value = {
    name = module.security_server.vm_name
    ip_address = module.security_server.ip_address
    vm_id = module.security_server.vm_id
  }
}

#============
# Game Server
#============
output "game_server" {
  description = "Reverse Proxy Server"
  value = {
    name = module.game_server.vm_name
    ip_address = module.game_server.ip_address
    vm_id = module.game_server.vm_id
  }
}