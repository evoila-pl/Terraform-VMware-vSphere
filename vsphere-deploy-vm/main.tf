provider "vsphere" {
  user = var.vsphere_user
  password = var.vsphere_pass
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.dc_name
}

data "vsphere_datastore" "datastore" {
  name = "esxi1-7-ds1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "rp" {
  name = var.rp_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_distributed_virtual_switch" "vds" {
  name = "vds"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name = "frontend"
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.vds.id
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name = "Test-VM"
  resource_pool_id = data.vsphere_resource_pool.rp.id
  datastore_id = data.vsphere_datastore.datastore.id

  num_cpus = 1
  memory = 1024
  guest_id = "other3xLinux64Guest"

  wait_for_guest_net_timeout = 0

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 5
  }
}
