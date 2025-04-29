output "vm_name" {
  description = "Nom de la VM créée"
  value       = vsphere_virtual_machine.vm_01.name
}
