provider "vsphere" {
  user = var.vsphere_user
  password = var.vsphere_pass
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.dc_name
}

data "vsphere_host" "host" {
  count = length(var.hosts)
  name = var.hosts[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_distributed_virtual_switch" "vds" {
  name = "vds"
  datacenter_id = data.vsphere_datacenter.dc.id
  
  uplinks         = ["uplink1", "uplink2", "uplink3", "uplink4"]
  active_uplinks  = ["uplink1", "uplink2"]
  standby_uplinks = ["uplink3", "uplink4"]

  host {
    host_system_id = data.vsphere_host.host.0.id
    devices = [
      "vmnic1",
    ]
  }

  host {
    host_system_id = data.vsphere_host.host.1.id
    devices = [
      "vmnic1",
    ]
  }

}

resource "vsphere_distributed_port_group" "pg" {
  name = "frontend"
  distributed_virtual_switch_uuid = vsphere_distributed_virtual_switch.vds.id
  vlan_id = 0
}
