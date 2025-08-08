locals {
  environment = "prod"
  # network_base = "10.0.3"
  network_base = "10.0.1"
  second_network_base = "192.168.1"
  common_tags = {
    Environment = local.environment
    Managed_by = "terraform"
  }
}

terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.2-rc01"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  pm_api_token_id = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure = var.proxmox_tls_insecure
}

#=====================
# Reverse Proxy Server
#=====================
# module "reverse_proxy_server" {
#   source = "../../modules/proxmox_vm"

#   vm_name = "reverse_proxy-${var.environment}"
#   target_node = "pve1"
#   clone_template = "ubn-temp-1"

#   cpu_cores = 2
#   memory_mb = 2024
#   disk_size_gb = 15
#   storage_pool = var.storage_pool

#   network_bridge = var.network_bridge
#   ip_address = "${local.network_base}.45/24"
#   gateway = "${local.network_base}.1"
#   nameserver = var.nameserver

#   ssh_public_key = var.ssh_public_key
#   tags = "reverse-proxy,network,${var.environment}"

#   description = "Reverse Proxy Server - ${local.environment}"
# }

#==================
# Monitoring Server
#==================
# module "monitoring_server" {
#   source = "../../modules/proxmox_vm"

#   vm_name = "monitoring_server-${var.environment}"
#   target_node = "pve1"
#   clone_template = "ubn-temp-1"

#   cpu_cores = 2
#   memory_mb = 2024
#   disk_size_gb = 35
#   storage_pool = var.storage_pool

#   network_bridge = var.network_bridge
#   ip_address = "${local.network_base}.67/24"
#   gateway = "${local.network_base}.1"
#   nameserver = var.nameserver

#   ssh_public_key = var.ssh_public_key
#   tags = "monitoring,${var.environment}"

#   description = "Monitoring Server - ${local.environment}"
# }

#=====================
# Block Storage Server
#=====================
module "block_storage_server" {
  source = "../../modules/proxmox_vm"

  vm_name = "block_storage_server-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 2
  memory_mb = 4048
  disk_size_gb = 32
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.89/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "storage,${var.environment}"

  description = "Block Storage Server - ${local.environment}"
}

#================
# Database Server
#================
module "database_server" {
  source = "../../modules/proxmox_vm"

  vm_name = "database_server-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 2
  memory_mb = 4048
  disk_size_gb = 32
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.55/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "storage,${var.environment}"

  description = "Database Server - ${local.environment}"
}

#====================
# K8s Master 1 Server
#====================
module "k8s_master_1_server" {
  source = "../../modules/proxmox_vm"

  vm_name = "k8s_master_1_server-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 2
  memory_mb = 4048
  disk_size_gb = 32
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.80/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "container orchestration,${var.environment}"

  description = "K8s Master 1 Server - ${local.environment}"
}

#====================
# K8s Worker 1 Server
#====================
module "k8s_worker_1_server" {
  source = "../../modules/proxmox_vm"

  vm_name = "k8s_worker_1_server-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 2
  memory_mb = 4048
  disk_size_gb = 32
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.86/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "container orchestration,${var.environment}"

  description = "K8s Worker 1 Server - ${local.environment}"
}

