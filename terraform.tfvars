# ======================== #
# VMware VMs configuration #
# ======================== #

cpu = 4
cores-per-socket = 1
ram = 4096
disksize = 30 # in GB
vm-guest_id = "ubuntu64Guest"
vsphere-unverified-ssl = "true"
vsphere_user = "administrator@vsphere.local"
vsphere_password = "Asdf-1234"
vsphere_vcenter = "192.168.1.120"
vsphere-datacenter = "Datacenter-LAB-01"
vsphere_cluster = "New Cluster"
vm-datastore = "datastor-02"
vm-network = "VM Network"
vm-domian = "home"
dns_server_list = ["8.8.8.8","8.8.4.4."]
name = "Kub-Master-01"
ipv4_address = "192.168.1.140"
ipv4_gateway = "192.168.1.99"
ipv4_netmask = "24"
vm-template-name = "ubuntu22.4-template"

