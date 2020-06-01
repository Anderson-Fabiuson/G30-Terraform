#Variables
provider "azurerm" {
    features  {}
}

variable "address_id" {}
variable "subnet_id" {}
variable "subnet_id2" {}
variable "subnet_id3" {}
variable "subnet_id4" {}
variable "user_id" {}
variable "password_id" {}
variable "ressource_id" {}
variable "ressource_id_1" {}
variable "ressource_id_2" {}


##############################################################################################

############################## Création d'un groupe de ressources #############################

resource "azurerm_resource_group" "RGMonoVM" {
  name     = "${var.ressource_id}"
  location = "Central Europe"

}

resource "azurerm_resource_group" "RGMonoVM-West" {
  name     = "${var.ressource_id_1}"
  location = "West Europe"
}

resource "azurerm_resource_group" "RGMonoVM-Europe" {
  name     = "${var.ressource_id_2}"
  location = "North Europe"
}
########################################################################################

############################## Création des réseau virtuel #############################

resource "azurerm_virtual_network" "FirstVirtualNetwork" {
    name                = "VirtualNetwork1"
    address_space       = "${var.address_id}"
    location            = "West Europe"
    resource_group_name = "${var.ressource_id}"

}

resource "azurerm_virtual_network" "SecondVirtualNetwork" {
    name                = "VirtualNetwork2"
    address_space       = "${var.address_id}"
    location            = "West Europe"
    resource_group_name = "${var.ressource_id}"

} 

resource "azurerm_virtual_network" "ThirdVirtualNetwork" {
    name                = "VirtualNetwork3"
    address_space       = "${var.address_id}"
    location            = "West Europe"
    resource_group_name = "${var.ressource_id}"

} 

resource "azurerm_virtual_network" "FourthVirtualNetwork" {
    name                = "VirtualNetwork4"
    address_space       = "${var.address_id}"
    location            = "West Europe"
    resource_group_name = "${var.ressource_id}"

} 

################################################################################

############################## Création des subnet #############################

resource "azurerm_subnet" "FirstSubnet" {
    name                 = "Subnet1"
    resource_group_name  = "${var.ressource_id}"
    virtual_network_name = "VirtualNetwork1"
    address_prefix       = "${var.subnet_id}"

}

resource "azurerm_subnet" "WebTierSubnet" {
    name                 = "Subnet2"
    resource_group_name  = "${var.ressource_id}"
    virtual_network_name = "VirtualNetwork2"
    address_prefix       = "${var.subnet_id2}"

}

resource "azurerm_subnet" "BusinessTierSubnet" {
    name                 = "Subnet3"
    resource_group_name  = "${var.ressource_id}"
    virtual_network_name = "VirtualNetwork3"
    address_prefix       = "${var.subnet_id3}"

}

resource "azurerm_subnet" "DataTierSubnet" {
    name                 = "Subnet4"
    resource_group_name  = "${var.ressource_id}"
    virtual_network_name = "VirtualNetwork4"
    address_prefix       = "${var.subnet_id4}"

}


#####################################################################################

############################## Création des IP publique #############################

resource "azurerm_public_ip" "FirstIP" {
    name                         = "PublicIP"
    location                     = "West Europe"
    resource_group_name          = "${var.ressource_id_1}"
        allocation_method            = "Dynamic"
}
 
resource "azurerm_public_ip" "SecondIP" {
    name                         = "PublicIP2"
    location                     = "North Europe"
    resource_group_name          = "${var.ressource_id_2}"
        allocation_method            = "Dynamic"
}
############################# Création des carte réseau #############################

resource "azurerm_network_interface" "FirstNIC" {
    name                      = "NIC"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.WebTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "SecondNIC" {
    name                      = "NIC2"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.WebTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "ThirdNIC" {
    name                      = "NIC3"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.WebTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "FourthNIC" {
    name                      = "NIC4"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.WebTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "FifthNIC" {
    name                      = "NIC5"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.WebTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "SixtNIC" {
    name                      = "NIC6"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.WebTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "SevenNIC" {
    name                      = "NIC7"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.BusinessTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "EightNIC" {
    name                      = "NIC8"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.BusinessTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "NineNIC" {
    name                      = "NIC9"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.BusinessTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "TenNIC" {
    name                      = "NIC10"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.BusinessTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "ElevenNIC" {
    name                      = "NIC11"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.BusinessTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "TwelveNIC" {
    name                      = "NIC12"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.BusinessTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}
##############################################################################################

############################# Création des carte réseau SQL ##################################

resource "azurerm_network_interface" "FirstSQLNIC" {
    name                      = "SQLNIC"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "SQLNICConfig"
        subnet_id                     = "${azurerm_subnet.DataTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}
resource "azurerm_network_interface" "SecondSQLNIC" {
    name                      = "SQLNIC2"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "SQLNICConfig2"
        subnet_id                     = "${azurerm_subnet.DataTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_network_interface" "ThirdSQLNIC" {
    name                      = "SQLNIC3"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "SQLNICConfig3"
        subnet_id                     = "${azurerm_subnet.DataTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}
resource "azurerm_network_interface" "FourthSQLNIC" {
    name                      = "SQLNIC4"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "SQLNICConfig4"
        subnet_id                     = "${azurerm_subnet.DataTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}
##############################################################################################

############################## Création des virtual machine ##################################

resource "azurerm_virtual_machine" "FirstVM" {
    name                  = "VMAZ"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id_1}"
    #zones                 = [1]
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
        computer_name  = "VM"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}


resource "azurerm_virtual_machine" "SecondVM" {
    name                  = "VMAZ2"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id_1}"
    #zones                 = [1]
    network_interface_ids = ["${azurerm_network_interface.SecondNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os2"
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
        computer_name  = "VM2"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "ThirdVM" {
    name                  = "VMAZ3"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id_1}"
    #zones                 = [2]
    network_interface_ids = ["${azurerm_network_interface.ThirdNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os3"
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
        computer_name  = "VM3"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "FourthVM" {
    name                  = "VMAZ4"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id_1}"
    #zones                 = [2]
    network_interface_ids = ["${azurerm_network_interface.FourthNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os4"
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
        computer_name  = "VM4"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "FifthVM" {
    name                  = "VMAZ5"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id_1}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.FifthNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os5"
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
        computer_name  = "VM5"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "SixtVM" {
    name                  = "VMAZ6"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id_1}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.SixtNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os6"
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
        computer_name  = "VM6"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "SevenVM" {
    name                  = "VMAZ7"
    location              = "North Europe"
    resource_group_name   = "${var.ressource_id_2}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.SevenNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os7"
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
        computer_name  = "VM7"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "EightVM" {
    name                  = "VMAZ8"
    location              = "North Europe"
    resource_group_name   = "${var.ressource_id_2}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.EightNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os8"
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
        computer_name  = "VM8"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "NineVM" {
    name                  = "VMAZ9"
    location              = "North Europe"
    resource_group_name   = "${var.ressource_id_2}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.NineNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os9"
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
        computer_name  = "VM9"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}
resource "azurerm_virtual_machine" "TenVM" {
    name                  = "VMAZ10"
    location              = "North Europe"
    resource_group_name   = "${var.ressource_id_2}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.TenNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os10"
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
        computer_name  = "VM10"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "ElevenVM" {
    name                  = "VMAZ11"
    location              = "North Europe"
    resource_group_name   = "${var.ressource_id_2}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.ElevenNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os11"
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
        computer_name  = "VM11"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "TwelveVM" {
    name                  = "VMAZ12"
    location              = "North Europe"
    resource_group_name   = "${var.ressource_id_2}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.TwelveNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-os12"
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
        computer_name  = "VM12"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

##############################################################################################

############################## Creation des virtual machines SQL #############################

resource "azurerm_virtual_machine" "FirstSQLVM" {
    name                  = "VMSQL_1"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id_1}"
    #zones                 = [1]
    network_interface_ids = ["${azurerm_network_interface.FirstSQLNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-sql-os"
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
        computer_name  = "SQLVM"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "SecondSQLVM" {
    name                  = "VMSQL_2"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id_1}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.SecondSQLNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-sql-os2"
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
        computer_name  = "SQLVM2"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "ThirdSQLVM" {
    name                  = "VMSQL_3"
    location              = "North Europe"
    resource_group_name   = "${var.ressource_id_2}"
    #zones                 = [1]
    network_interface_ids = ["${azurerm_network_interface.ThirdSQLNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-sql-os3"
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
        computer_name  = "SQLVM3"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "FourthSQLVM" {
    name                  = "VMSQL_4"
    location              = "North Europe"
    resource_group_name   = "${var.ressource_id_2}"
    #zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.FourthSQLNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-sql-os4"
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
        computer_name  = "SQLVM4"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

###########################################################################################################

############################## Création LoadBalancer #########################################

resource "azurerm_lb" "LoadBalancer" {
  name                = "TestLoadBalancer"
  location            = "West Europe"
  resource_group_name = "${var.ressource_id_1}"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    subnet_id            = "${azurerm_subnet.WebTierSubnet.id}"
    #public_ip_address_id = azurerm_public_ip.FirstIP.id
  }
}

resource "azurerm_lb" "LoadBalancer2" {
  name                = "TestLoadBalancer2"
  location            = "West Europe"
  resource_group_name = "${var.ressource_id_1}"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress2"
    subnet_id            = "${azurerm_subnet.BusinessTierSubnet.id}"
   #public_ip_address_id = azurerm_public_ip.FirstIP.id
  }
}

resource "azurerm_lb" "LoadBalancer3" {
  name                = "TestLoadBalancer3"
  location            = "West Europe"
  resource_group_name = "${var.ressource_id_1}"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress3"
    subnet_id            = "${azurerm_subnet.DataTierSubnet.id}"
   #public_ip_address_id = azurerm_public_ip.FirstIP.id
  }
}

resource "azurerm_lb" "LoadBalancer4" {
  name                = "TestLoadBalancer4"
  location            = "North Europe"
  resource_group_name = "${var.ressource_id_2}"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress4"
    subnet_id             = "${azurerm_subnet.WebTierSubnet.id}"
   #public_ip_address_id = azurerm_public_ip.SecondIP.id
  }
}

resource "azurerm_lb" "LoadBalancer5" {
  name                = "TestLoadBalancer5"
  location            = "North Europe"
  resource_group_name = "${var.ressource_id_2}"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress5"
    subnet_id             = "${azurerm_subnet.BusinessTierSubnet.id}"
    #public_ip_address_id = azurerm_public_ip.SecondIP.id
  }
}

resource "azurerm_lb" "LoadBalancer6" {
  name                = "TestLoadBalancer6"
  location            = "North Europe"
  resource_group_name = "${var.ressource_id_2}"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress6"
    subnet_id             = "${azurerm_subnet.DataTierSubnet.id}"
   # public_ip_address_id = azurerm_public_ip.SecondIP.id
  }
}

##############################################################################################

############################## Création Traffic Manager ##################################

resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_traffic_manager_profile" "TrafficManager" {
  name                = random_id.server.hex
  resource_group_name = "${var.ressource_id}"

  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = random_id.server.hex
    ttl           = 100
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_traffic_manager_endpoint" "Europe" {
    name                = "${var.ressource_id_1}"
    resource_group_name = "${var.ressource_id}"
    profile_name        = "${azurerm_traffic_manager_profile.TrafficManager.name}"

    target              = "${var.ressource_id_1}"
    type                = "externalEndpoints"
}

resource "azurerm_traffic_manager_endpoint" "west" {
    
    name                = "${var.ressource_id_2}"
    resource_group_name = "${var.ressource_id}"
    profile_name        = "${azurerm_traffic_manager_profile.TrafficManager.name}"

    target              = "${var.ressource_id_2}"
    type                = "externalEndpoints"
  #  weight              = "${var.west_endpoint_weight}"
}