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

data "vsphere_host" "host" {
  name          = "esxi1-7.int.inleo.pl"
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
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vmFromRemoteOvf" {
  name = "ghost-ova"
  resource_pool_id = data.vsphere_resource_pool.rp.id
  datastore_id = data.vsphere_datastore.datastore.id
  host_system_id = data.vsphere_host.host.id
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0
  datacenter_id = data.vsphere_datacenter.dc.id
  ovf_deploy {
    remote_ovf_url = "https://tf-ghost.s3.eu-central-1.amazonaws.com/ghost.ova"
    disk_provisioning = "thin"
    ovf_network_map = {
      "VM Network" = data.vsphere_network.network.id
    }
  }
}
