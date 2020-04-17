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

variable "dc_name" {
  type = string
  description = "Name of your DC."
}

variable "cluster_name" {
  type = string
  description = "Name of your Cluster."
}

variable "esx_pass" {
  type = string
  description = "Password of root user."
}

variable "hosts" {
  default = [
      "esx",
  ]
}

variable "thumbprints" {
  default = [
      "4F:6D:22:38:97:CA:25:04:D8:16:D4:87:CF:D8:80:B8:94:53:CC:FF",
  ]
}

variable "rp_name" {
  type = string
  description = "Name of your RP"
}
