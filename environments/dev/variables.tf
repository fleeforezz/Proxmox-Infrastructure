# Proxmox Configuration
variable "proxmox_api_url" {
  type        = string
  description = "Proxmox API URL"
}

variable "proxmox_api_token_id" {
  type        = string
  default = "terraform@pve"
  description = "Promox API token Id"
}

variable "proxmox_api_token_secret" {
  type        = string
  sensitive = true
  description = "Promox API token secret"
}

variable "proxmox_tls_insecure" {
  type        = bool
  description = "Skip TLS verification"
  default     = true
}

variable "proxmox_node" {
  description = "Proxmox node name"
  type        = string
  default     = "pve1"
}

# VM Configuration
variable "vm_template" {
  description = "VM template to clone from"
  type        = string
  default     = "ubn-temp-1"
}

variable "storage_pool" {
  description = "Storage pool name"
  type        = string
  default     = "Fast500G"
}

variable "network_bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr1"
}

variable "nameserver" {
  description = "DNS servers"
  type        = string
  default     = "1.1.1.1,1.0.0.1"
}

# SSH Configuration
variable "ssh_public_key" {
  type        = string
  sensitive   = true
  description = "SSH public key for VM access"
}

# Project Configuration
variable "project_name" {
  type = string
  default = "proxmox-infra"
  description = "Project name for resource naming"
}
