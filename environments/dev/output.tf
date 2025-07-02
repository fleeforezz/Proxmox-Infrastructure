#===================
# Development Server
#===================
output "development_server" {
  description = "Development Server"
  value = {
    name = module.development_server.vm_name
    ip_address = module.development_server.ip_address
    vm_id = module.development_server.vm_id
  }
}

#========================
# Dev K8s Master 1 Server
#========================
output "dev_k8s_master_1_server" {
  description = "Dev K8s Master 1 Server"
  value = {
    name = module.dev_k8s_master_1_server.vm_name
    ip_address = module.dev_k8s_master_1_server.ip_address
    vm_id = module.dev_k8s_master_1_server.vm_id
  }
}

#========================
# Dev K8s Worker 1 Server
#========================
output "dev_k8s_worker_1_server" {
  description = "Dev K8s Worker 1 Server"
  value = {
    name = module.dev_k8s_worker_1_server.vm_name
    ip_address = module.dev_k8s_worker_1_server.ip_address
    vm_id = module.dev_k8s_worker_1_server.vm_id
  }
}