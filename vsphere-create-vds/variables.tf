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

variable "rp_name" {
  type = string
  description = "Name of your RP"
}

variable "hosts" {
  default = [
      "esxi1-7.int.inleo.pl",
      "esxi2-7.int.inleo.pl",
  ]
}
