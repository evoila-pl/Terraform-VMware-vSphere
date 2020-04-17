# Provider

variable "vsphere_user" {
  type = string
  description = "Username of admin/root account."
}

variable "vsphere_pass" {
  type = string
  description = "Password of admin/root user."
}

variable "vsphere_server" {
  type = string
  description = "Name/IP for point of mgmt (ESXi/vCenter)."
}
