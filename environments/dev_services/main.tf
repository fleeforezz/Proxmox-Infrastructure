locals {
  environment = "dev-services"
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

#=======================
# Version Control Server
#=======================
module "gitlab_server" {
  source = "../../modules/proxmox-vm"

  vm_name = "gitlab-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 4
  memory_mb = 8192
  disk_size_gb = 32
  storage_pool = var.storage_pool
  
  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.51/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "version-control,${var.environment}"

  description = "Gitlab Version Control Server - ${local.environment}"
}

#==========================
# Cockpit Management Server
#==========================
module "cockpit_management_server" {
  source = "../../modules/proxmox-vm"

  vm_name = "cockpit-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 3
  memory_mb = 8192
  disk_size_gb = 32
  storage_pool = var.storage_pool
  
  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.32/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "management,${var.environment}"

  description = "Cockpit Management Server - ${local.environment}"
}

#====================
# Network Gate Server
#====================
module "network_gate_server" {
  source = "../../modules/proxmox-vm"

  vm_name = "network_gate-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 2
  memory_mb = 2024
  disk_size_gb = 15
  storage_pool = var.storage_pool
  
  network_bridge = var.network_bridge
  ip_address = "${local.second_network_base}.78/24"
  gateway = "${local.second_network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "network,${var.environment}"

  description = "Network Gate Server - ${local.environment}"
}

#=====================
# Reverse Proxy Server
#=====================
module "reverse_proxy_server" {
  source = "../../modules/proxmox-vm"

  vm_name = "reverse_proxy-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 2
  memory_mb = 2024
  disk_size_gb = 15
  storage_pool = var.storage_pool
  
  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.90/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "reverse-proxy,network,${var.environment}"

  description = "Reverse Proxy Server - ${local.environment}"
}

#==================
# Monitoring Server
#==================
module "monitoring_server" {
  source = "../../modules/proxmox-vm"

  vm_name = "monitoring-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 2
  memory_mb = 2024
  disk_size_gb = 32
  storage_pool = var.storage_pool
  
  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.60/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "monitoring,${var.environment}"

  description = "Monitoring Server - ${local.environment}"
}

#================
# Security Server
#================
module "security_server" {
  source = "../../modules/proxmox-vm"

  vm_name = "security-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 2
  memory_mb = 2024
  disk_size_gb = 32
  storage_pool = var.storage_pool
  
  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.70/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "security,${var.environment}"

  description = "Security Server - ${local.environment}"
}