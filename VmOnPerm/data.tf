data "vsphere_datacenter" "dc" {
  name = "MyEsxi"
}

data "vsphere_host" "esxi_host" {
  name          = "myesxi.kmea.local"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "ds" {
  name          = "DATABANK-3"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}
