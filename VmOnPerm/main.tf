resource "vsphere_virtual_machine" "vm_01" {
  name             = "centos8-tf"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = 2
  memory   = 2048
  guest_id = "centos8_64Guest"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 40
    thin_provisioned = true
  }

  cdrom {
    datastore_id = data.vsphere_datastore.ds.id
    path         = "MesISO/CentOS-8.4.2105-x86_64-dvd1.iso"
  }

  extra_config = {
    "bios.bootDelay" = "5000"
  }

  wait_for_guest_net_timeout = 0
}
