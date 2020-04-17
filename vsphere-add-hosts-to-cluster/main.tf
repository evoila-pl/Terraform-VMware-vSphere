provider "vsphere" {
  user = var.vsphere_user
  password = var.vsphere_pass
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

resource "vsphere_datacenter" "dc" {
  name = var.dc_name
}

resource "vsphere_compute_cluster" "cluster" {
  name = var.cluster_name
  datacenter_id = vsphere_datacenter.dc.moid

  drs_enabled = false
  drs_automation_level = "fullyAutomated"

  ha_enabled = false
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

resource "vsphere_host" "hosts" {
  count = length(var.hosts)

  hostname = var.hosts[count.index]
  username = "root"
  password = var.esx_pass
  cluster = vsphere_compute_cluster.cluster.id
  thumbprint = var.thumbprints[count.index]
}
