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

  ha_enabled = true
}

