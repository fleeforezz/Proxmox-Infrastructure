locals {
  environment  = "dev"
  network_base = "10.0.1"
  common_tags = {
    Environment = local.environment
    Managed_by  = "terraform"
  }
}

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc01"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = var.proxmox_tls_insecure
}

#===================
# Development Server
#===================
module "development_server" {
  source = "../../modules/proxmox-vm"

  vmid           = null
  vm_name        = "development-${var.environment}"
  target_node    = var.proxmox_node
  clone_template = var.vm_template
  display_type   = var.display_type

  cpu_cores    = 8
  memory_mb    = 16384
  disk_size_gb = 70
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address     = "${local.network_base}.80/24"
  gateway        = "${local.network_base}.1"
  nameserver     = var.nameserver

  ciuser         = var.ciuser
  cipassword     = var.cipassword
  ssh_public_key = join("\n", var.ssh_public_key)
  tags           = "development,${var.environment}"

  description = "Development Server - ${local.environment}"
}

#========================
# Dev K8s Master 1 Server
#========================
module "dev_k8s_master_1_server" {
  source = "../../modules/proxmox-vm"

  vmid           = null
  vm_name        = "k8s-master-1-${var.environment}"
  target_node    = var.proxmox_node
  clone_template = var.vm_template
  display_type   = var.display_type

  cpu_cores    = 3
  memory_mb    = 4048
  disk_size_gb = 32
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address     = "${local.network_base}.52/24"
  gateway        = "${local.network_base}.1"
  nameserver     = var.nameserver

  ciuser         = var.ciuser
  cipassword     = var.cipassword
  ssh_public_key = join("\n", var.ssh_public_key)
  tags           = "container-orchestration,${var.environment}"

  description = "Dev K8s Master 1 Server - ${local.environment}"
}

#========================
# Dev K8s Worker 1 Server
#========================
module "dev_k8s_worker_1_server" {
  source = "../../modules/proxmox-vm"

  vmid           = null
  vm_name        = "k8s-worker-1-${var.environment}"
  target_node    = var.proxmox_node
  clone_template = var.vm_template
  display_type   = var.display_type

  cpu_cores    = 3
  memory_mb    = 4048
  disk_size_gb = 32
  storage_pool = var.storage_pool

  network_bridge = var.network_bridge
  ip_address     = "${local.network_base}.53/24"
  gateway        = "${local.network_base}.1"
  nameserver     = var.nameserver

  ciuser         = var.ciuser
  cipassword     = var.cipassword
  ssh_public_key = join("\n", var.ssh_public_key)
  tags           = "container-orchestration,${var.environment}"

  description = "Dev K8s Worker 1 Server - ${local.environment}"
}

