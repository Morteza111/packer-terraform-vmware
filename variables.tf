#===========================#
# VMware vCenter connection #
#===========================#
variable "vsphere_user" {
    type       = string
  description  = "vsphere username"
  sensitive    = true
}

variable "vsphere_password" {
    type       = string
  description  = "vsphere password"
  sensitive    = true
}

variable "vsphere_vcenter" {
    type       = string
  description  = "vsphere FQON/ipaddress"
  sensitive    = true
}

variable "vsphere-unverified-ssl" {
    type       = string
  description  = "is the vmware vcenter useing a self sign cert (true/fales)"
  sensitive    = true
}

variable "vsphere-datacenter" {
    type       = string
  description  = "vmware vcenter datacenter"
}

variable "vsphere_cluster" {
    type       = string
  description  = "vmware vcenter cluster"
  default      = ""
}

#================================#
# VMware vSphere virtual machine #
#================================#

variable "name" {
  type       = string
  description = "the name fo the vsphere virtual machines and the hostname of the machine"
}

variable "vm-name-prefix" {
  type       = string
  description = "name of vm profix"
  default = "k3sup"
}

variable "vm-datastore" {
  type       = string
  description = " datasotre used for the vsphere virtual machine"
}

variable "vm-network" {
  type       = string
  description = " datasotre used for the vsphere virtual machine"
}

variable "vm-linked-clone" {
  type       = string
  description = " use linked clone to create the vsphere virtual machine from the template (true/fales)."
  default = "fales"
}

variable "cpu" {
  type       = string
  description = " number of cpu"
  default = 2
}

variable "cores-per-socket" {
  type       = string
  description = " number of core"
  default = 1
}

variable "ram" {
  type       = string
  description = " account of ram for the vsphere virtual machine(example: 2048)"
}

variable "disksize" {
  type       = string
  description = " disksize"
  default = ""
}

variable "vm-guest_id" {
  type       = string
  description = " the ID of virtual operating system"
}

variable "vm-template-name" {
  type       = string
  description = " the template to clone to create the VM"
}

variable "vm-domian" {
  type       = string
  description = " domain name for the machine"
  default = ""
}

variable "dns_server_list" {
  type       = list(string)
  description = " list of DNS servers"
  default = ["8.8.8.8", "8.8.4.4"]
}

variable "ipv4_address" {
  type       = string
  description = " ipv4 for vm"
}

variable "ipv4_gateway" {
  type       = string
  description = " gateway"
}

variable "ipv4_netmask" {
  type       = string
}

variable "ssh_username" {
  type       = string
  sensitive = true
  default = "sysadmin"
}

variable "public_key" {
  type       = string
  description = "public key use to ssh to machine"
  default = "SHA256:LpkMN+o3Y1zQzA1HaXqO174gN5Sd+pyFexgbhSqB2MM root@ubuntu-24-template"
}