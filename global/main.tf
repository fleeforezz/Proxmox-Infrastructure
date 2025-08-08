terraform {
  required_version = ">= 1.0"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc01"
    }
  }
}

provider "proxmox" {
  # pm_api_url = "https://192.168.1.33:8006/api2/json"
  # pm_api_token_id = "root@pam!terraform"
  # pm_api_token_secret = "7dc42919-490a-4886-af27-5000dc24851d"
  # pm_tls_insecure = true
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = var.proxmox_tls_insecure
}