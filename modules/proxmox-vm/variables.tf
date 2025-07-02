variable "vm_name" {
  type        = string
  description = "Name of the VM"
}

variable "target_node" {
  type        = string
  description = "Proxmox node to deploy"
}

variable "clone_template" {
  type        = string
  description = "Template to clone from"
}

variable "cpu_cores" {
  type        = number
  default     = 1
  description = "Number of CPU cores"
}

variable "memory_mb" {
  type        = number
  default     = 1024
  description = "Memory in MB"
}

variable "disk_size_gb" {
  type        = number
  default     = 10
  description = "Disk size in GB"
}

variable "storage_pool" {
  type        = string
  default     = "Fast500G"
  description = "Storage pool name"
}

variable "network_bridge" {
  type        = string
  default     = "vmbr1"
  description = "Network bridge"
}

variable "ip_address" {
  type        = string
  description = "The static IP address of the VM with CIDR suffix (e.g. 10.0.1.51/24)"
}

variable "gateway" {
  type    = string
  default = "Gateway IP"
}

variable "nameserver" {
  type        = string
  default     = "1.1.1.1,1.0.0.1"
  description = "DNS servers"
}

variable "ssh_public_key" {
  type        = string
  default     = ""
  description = "SSH public key"
}

variable "tags" {
  type        = string
  default     = ""
  description = "VM tags"
}

variable "description" {
  type        = string
  default     = ""
  description = "Server description"
}
