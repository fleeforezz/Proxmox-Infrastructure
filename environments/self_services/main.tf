locals {
  environment         = "self-services"
  network_base        = "10.0.1"
  second_network_base = "192.168.1"
  common_tags = {
    Environment = local.environment
    Managed_by  = "terraform"
  }
}

terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
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

#============
# Game Server
#============
module "game_server" {
  source = "../../modules/proxmox-vm"

  vmid           = null
  vm_name        = "game-${var.environment}"
  target_node    = var.proxmox_node
  clone_template = var.vm_template
  display_type   = var.display_type

  cpu_cores    = 8
  memory_mb    = 16384
  disk_size_gb = 50
  storage_pool = var.storage_pool

  network_bridge = "vmbr0"
  ip_address     = "${local.second_network_base}.100/24"
  gateway        = "${local.second_network_base}.1"
  nameserver     = var.nameserver

  ciuser         = var.ciuser
  cipassword     = var.cipassword
  ssh_public_key = join("\n", var.ssh_public_key)
  tags           = "game,${var.environment}"

  description = "Game Server - ${local.environment}"
}

#=============
# Media Server
#=============
module "media_server" {
  source = "../../modules/proxmox-vm"

  vmid           = null
  vm_name        = "media-${var.environment}"
  target_node    = var.proxmox_node
  clone_template = var.vm_template
  display_type   = var.display_type

  cpu_cores    = 8
  memory_mb    = 16384
  disk_size_gb = 32
  storage_pool = var.storage_pool

  network_bridge = "vmbr1"
  ip_address     = "${local.network_base}.66/24"
  gateway        = "${local.network_base}.1"
  nameserver     = var.nameserver

  ciuser         = var.ciuser
  cipassword     = var.cipassword
  ssh_public_key = join("\n", var.ssh_public_key)
  tags           = "media,${var.environment}"

  description = "Media Server - ${local.environment}"
}