# =================== #
# Deploying VMware VM #
# =================== #

# Connect to VMware vSphere vCenter
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_vcenter

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

locals {
  templatevars = {
   name              = var.name,
   ipv4_address      = var.ipv4_address,
   ipv4_gateway      = var.ipv4_gateway,
   dns_server_1      = var.dns_server_list[0],
   dns_server_2      = var.dns_server_list[1],
   public_ley        = var.public_key,
   ssh_username      = var.ssh_username
  }
}

# Define VMware vSphere 
data "vsphere_datacenter" "dc" {
  name = var.vsphere-datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vm-datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "${var.vm-network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "/${var.vsphere-datacenter}/vm/${var.vm-template-name}"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Create VMs
resource "vsphere_virtual_machine" "vm" {
  name             = var.name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.cpu
  memory   = var.ram
  guest_id = var.vm-guest_id

  

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label              = "${var.name}-disk"
    thin_provisioned   = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
    eagerly_scrub      = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    size               = var.disksize== "" ?data.vsphere_virtual_machine.template.disks.0.size : var.disksize
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
  extra_config = {
    "guestinfo.metadata"            = templatefile("${path.module}/metadata.yaml", local.templatevars)
    "guesrinfo.metadata.encoding"   = "base64"
    "guestinfo.userdata"            = templatefile("${path.module}/userdata.yaml", local.templatevars)
    "guesrinfo.userdata.encoding"   = "base64"
  }
  lifecycle {
    ignore_changes = [ 
      annotation,
      clone[0].template_uuid,
      clone[0].customize[0].dns_server_list,
      clone[0].customize[0].network_interface[0]
    ]
  }   
}
