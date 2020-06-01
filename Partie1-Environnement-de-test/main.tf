# Creer un groupe de ressources
resource "azurerm_resource_group" "RGMonoVM" {
  name     = "RGMonoVM"
  location = "West Europe"

}

provider "azurerm" {
    features  {}
}

# Creer un réseau virtuel
resource "azurerm_virtual_network" "FirstVirtualNetwork" {
    name                = "VirtualNetwork1"
    address_space       = ["192.168.0.0/16"]
    location            = "West Europe"
    resource_group_name = "RGMonoVM"

}
 
# Creer un subnet
resource "azurerm_subnet" "FirstSubnet" {
    name                 = "Subnet1"
    resource_group_name  = "RGMonoVM"
    virtual_network_name = "VirtualNetwork1"
    address_prefix       = "192.168.1.0/24"

}

# Créer une IP publique
resource "azurerm_public_ip" "FirstIP" {
    name                         = "testPublicIP"
    location                     = "West Europe"
    resource_group_name          = "RGMonoVM"
    allocation_method            = "Dynamic"
}
 
# Créer une carte réseau
resource "azurerm_network_interface" "FirstNIC" {
    name                      = "testNIC"
    location                  = "West Europe"
    resource_group_name       = "RGMonoVM"

    ip_configuration {
        name                          = "testNICConfig"
        subnet_id                     = "${azurerm_subnet.FirstSubnet.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
    }
}

# Create virtual machine
resource "azurerm_virtual_machine" "FirstVM" {
    name                  = "VMAZ"
    location              = "West Europe"
    resource_group_name   = "RGMonoVM"
    network_interface_ids = ["${azurerm_network_interface.FirstNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
 
    storage_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2016-Datacenter-Server-Core-smalldisk"
        version   = "latest"
    }
 
    os_profile {
        computer_name  = "testVM"
        admin_username = "lisa0504"
        admin_password = "Passw0rd1234"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}