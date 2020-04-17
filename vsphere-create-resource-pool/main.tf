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

  drs_enabled = true
  drs_automation_level = "fullyAutomated"

  ha_enabled = false
}

resource "vsphere_host" "hosts" {
  count = length(var.hosts)

  hostname = var.hosts[count.index]
  username = "root"
  password = var.esx_pass
  cluster = vsphere_compute_cluster.cluster.id
  thumbprint = var.thumbprints[count.index]
}

resource "vsphere_resource_pool" "rp" {
  name = var.rp_name
  parent_resource_pool_id = vsphere_compute_cluster.cluster.resource_pool_id
}
