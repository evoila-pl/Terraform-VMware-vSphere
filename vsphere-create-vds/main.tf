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

resource "vsphere_distributed_virtual_switch" "vds" {
  count = length(var.hosts)

  name = "vds-test"
  datacenter_id = vsphere_datacenter.dc.moid
  
  uplinks         = ["uplink1", "uplink2", "uplink3", "uplink4"]
  active_uplinks  = ["uplink1", "uplink2"]
  standby_uplinks = ["uplink3", "uplink4"]

  host {    
    host_system_id = vsphere_host.hosts[count.index].id
    devices = [
      "vmnic1",
    ]
  }
}

resource "vsphere_distributed_port_group" "pg" {
  count = length(vsphere_distributed_virtual_switch.vds)

  name = "frontend"
  distributed_virtual_switch_uuid = vsphere_distributed_virtual_switch.vds[count.index].id
  vlan_id = 0
}
