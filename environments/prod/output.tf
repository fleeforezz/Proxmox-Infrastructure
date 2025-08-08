#=====================
# Reverse Proxy Server
#=====================
output "gitlab_server" {
  description = "Reverse Proxy Server"
  value = {
    name       = module.reverse_proxy_server.vm_name
    ip_address = module.reverse_proxy_server.ip_address
    vm_id      = module.reverse_proxy_server.vm_id
  }
}

#=====================
# Monitoring Server
#=====================
output "monitoring_server" {
  description = "Monitoring Server"
  value = {
    name       = module.monitoring_server.vm_name
    ip_address = module.monitoring_server.ip_address
    vm_id      = module.monitoring_server.vm_id
  }
}

#=====================
# Block Storage Server
#=====================
output "block_storage_server" {
  description = "Block Storage Server"
  value = {
    name       = module.block_storage_server.vm_name
    ip_address = module.block_storage_server.ip_address
    vm_id      = module.block_storage_server.vm_id
  }
}

#================
# Database Server
#================
output "database_server" {
  description = "Database Server"
  value = {
    name       = module.database_server.vm_name
    ip_address = module.database_server.ip_address
    vm_id      = module.database_server.vm_id
  }
}

#================
# Database Server
#================
output "database_server" {
  description = "Database Server"
  value = {
    name       = module.database_server.vm_name
    ip_address = module.database_server.ip_address
    vm_id      = module.database_server.vm_id
  }
}

#====================
# K8s Master 1 Server
#====================
output "k8s_master_1_server" {
  description = "K8s Master 1 Server"
  value = {
    name       = module.k8s_master_1_server.vm_name
    ip_address = module.k8s_master_1_server.ip_address
    vm_id      = module.k8s_master_1_server.vm_id
  }
}

#====================
# K8s Worker 1 Server
#====================
output "k8s_worker_1_server" {
  description = "K8s Worker 1 Server"
  value = {
    name       = module.k8s_worker_1_server.vm_name
    ip_address = module.k8s_worker_1_server.ip_address
    vm_id      = module.k8s_worker_1_server.vm_id
  }
}