locals {
  common_tags = {
    Environment = var.environment
    Managed_by = "terraform"
  }
}

module "management_vm" {
  source = "./modules/proxmox_vm"

  vm_name = "cockpit-${var.environment}"
  target_node = "pve1"
  clone_template = "ubn-temp-1"
  cpu_cores = 2
  memory_mb = 8192
  disk_size_gb = 32
  ip_address = "10.0.1.32/24"
  gateway = "10.0.1.1"
  ssh_public_key = var.ssh_public_key
  tags = "management,${var.environment}"
}



