locals {
  environment = "dev"
  network_base = "10.0.1"
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

# Cockpit Management Server
module "development_server" {
  source = "../../modules/proxmox_vm"

  vm_name = "development-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 8
  memory_mb = 16384
  disk_size_gb = 70
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.32/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "management,${var.environment}"

  description = "Cockpit Management Server - ${local.environment}"
}

module "k8s-master-1-server" {
  source = "../../modules/proxmox_vm"

  vm_name = "development-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 8
  memory_mb = 16384
  disk_size_gb = 100
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.32/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "management,${var.environment}"

  description = "Cockpit Management Server - ${local.environment}"
}

module "k8s-worker-1-server" {
  source = "../../modules/proxmox_vm"

  vm_name = "development-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"

  cpu_cores = 8
  memory_mb = 16384
  disk_size_gb = 100
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address = "${local.network_base}.32/24"
  gateway = "${local.network_base}.1"
  nameserver = var.nameserver

  ssh_public_key = var.ssh_public_key
  tags = "management,${var.environment}"

  description = "Cockpit Management Server - ${local.environment}"
}

