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

resource "vsphere_host" "hosts" {
  hostname = "esxi1-7.int.inleo.pl"
  username = "root"
  password = var.esx_pass
  cluster = vsphere_compute_cluster.cluster.id
  license = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
  thumbprint = "08:71:53:E1:38:BE:9B:D5:28:00:03:FD:24:84:8F:73:81:E9:E1:17"
}
