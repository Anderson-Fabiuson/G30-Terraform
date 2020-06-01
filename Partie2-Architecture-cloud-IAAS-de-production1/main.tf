#Variables
provider "azurerm" {
    features  {}
}

variable "address_id" {}
variable "subnet_id" {}
variable "subnet_id2" {}
variable "subnet_id3" {}
variable "subnet_id4" {}
variable "subnet_id5" {}
variable "subnet_id6" {}
variable "user_id" {}
variable "password_id" {}
variable "ressource_id" {}
#variable "availability-zones" {}



locals {
  zones = toset(["1", "2", "3"])
}

locals {
  backend_address_pool_name      = "${azurerm_virtual_network.FirstVirtualNetwork.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.FirstVirtualNetwork.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.FirstVirtualNetwork.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.FirstVirtualNetwork.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.FirstVirtualNetwork.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.FirstVirtualNetwork.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.FirstVirtualNetwork.name}-rdrcfg"
}
##############################################################################################

############################## Création d'un groupe de ressources #############################

resource "azurerm_resource_group" "RGMonoVM" {
  name     = "${var.ressource_id}"
  location = "West Europe"

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

resource "azurerm_virtual_network" "FifthVirtualNetwork" {
    name                = "VirtualNetwork5"
    address_space       = "${var.address_id}"
    location            = "West Europe"
    resource_group_name = "${var.ressource_id}"

} 

resource "azurerm_virtual_network" "SixtVirtualNetwork" {
    name                = "VirtualNetwork6"
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

resource "azurerm_subnet" "AppGatewaySubnet" {
    name                 = "Subnet2"
    resource_group_name  = "${var.ressource_id}"
    virtual_network_name = "VirtualNetwork2"
    address_prefix       = "${var.subnet_id2}"

}

resource "azurerm_subnet" "WebTierSubnet" {
    name                 = "Subnet3"
    resource_group_name  = "${var.ressource_id}"
    virtual_network_name = "VirtualNetwork3"
    address_prefix       = "${var.subnet_id3}"

}

resource "azurerm_subnet" "BusinessTierSubnet" {
    name                 = "Subnet4"
    resource_group_name  = "${var.ressource_id}"
    virtual_network_name = "VirtualNetwork4"
    address_prefix       = "${var.subnet_id4}"

}

resource "azurerm_subnet" "DataTierSubnet" {
    name                 = "Subnet5"
    resource_group_name  = "${var.ressource_id}"
    virtual_network_name = "VirtualNetwork5"
    address_prefix       = "${var.subnet_id5}"

}

resource "azurerm_subnet" "ActiveDirectorySubnet" {
    name                 = "Subnet6"
    resource_group_name  = "${var.ressource_id}"
    virtual_network_name = "VirtualNetwork6"
    address_prefix       = "${var.subnet_id6}"

}

#####################################################################################

############################## Création des IP publique #############################

resource "azurerm_public_ip" "FirstIP" {
    name                         = "PublicIP"
    location                     = "West Europe"
    resource_group_name          = "${var.ressource_id}"
        allocation_method            = "Dynamic"
}
 
resource "azurerm_public_ip" "SecondIP" {
    name                         = "PublicIP2"
    location                     = "West Europe"
    resource_group_name          = "${var.ressource_id}"
        allocation_method            = "Dynamic"
}

resource "azurerm_public_ip" "ThirdIP" {
    name                         = "PublicIP3"
    location                     = "West Europe"
    resource_group_name          = "${var.ressource_id}"
        allocation_method            = "Dynamic"
}
############################# Création d'une application gateway #############################

resource "azurerm_application_gateway" "network" {
  name                = "appgateway"
  resource_group_name = "${var.ressource_id}"
  location            = "West Europe"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = "${azurerm_subnet.AppGatewaySubnet.id}"
  }  

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.FirstIP.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}

#####################################################################################

############################# Création des carte réseau #############################

resource "azurerm_network_interface" "FirstNIC" {
    name                      = "NIC"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.WebTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
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
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
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
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
    }
}

resource "azurerm_network_interface" "FourthNIC" {
    name                      = "NIC4"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.BusinessTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
    }
}

resource "azurerm_network_interface" "FifthNIC" {
    name                      = "NIC5"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.BusinessTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
    }
}

resource "azurerm_network_interface" "SixtNIC" {
    name                      = "NIC6"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "NICConfig"
        subnet_id                     = "${azurerm_subnet.BusinessTierSubnet.id}"
        private_ip_address_allocation = "dynamic"
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
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
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
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
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
    }
}

##############################################################################################

############################# Création des carte réseau AD ###################################

resource "azurerm_network_interface" "FirstADNIC" {
    name                      = "ADNIC"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "ADNICConfig"
        subnet_id                     = "${azurerm_subnet.ActiveDirectorySubnet.id}"
        private_ip_address_allocation = "dynamic"
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
    }
}
resource "azurerm_network_interface" "SecondADNIC" {
    name                      = "ADNIC2"
    location                  = "West Europe"
    resource_group_name       = "${var.ressource_id}"

    ip_configuration {
        name                          = "ADNICConfig2"
        subnet_id                     = "${azurerm_subnet.ActiveDirectorySubnet.id}"
        private_ip_address_allocation = "dynamic"
        #public_ip_address_id          = "${azurerm_public_ip.FirstIP.id}"
    }
}

##############################################################################################

############################## Création des virtual machine ##################################

resource "azurerm_virtual_machine" "FirstVM" {
    name                  = "VMAZ"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id}"
    zones                 = [1]
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
    resource_group_name   = "${var.ressource_id}"
    zones                 = [1]
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
    resource_group_name   = "${var.ressource_id}"
    zones                 = [2]
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
    resource_group_name   = "${var.ressource_id}"
    zones                 = [2]
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
    resource_group_name   = "${var.ressource_id}"
    zones                 = [3]
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
    resource_group_name   = "${var.ressource_id}"
    zones                 = [3]
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

##############################################################################################

############################## Creation des virtual machines SQL #############################

resource "azurerm_virtual_machine" "FirstSQLVM" {
    name                  = "VMSQL_1"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id}"
    zones                 = [1]
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
    resource_group_name   = "${var.ressource_id}"
    zones                 = [3]
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

###########################################################################################################

############################## Creation des virtual machines Active Directory #############################

resource "azurerm_virtual_machine" "FirstADVM" {
    name                  = "VMADDS_1"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id}"
    zones                 = [1]
    network_interface_ids = ["${azurerm_network_interface.FirstADNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-ad-os"
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
        computer_name  = "ADVM"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

resource "azurerm_virtual_machine" "SecondADVM" {
    name                  = "VMADDS_2"
    location              = "West Europe"
    resource_group_name   = "${var.ressource_id}"
    zones                 = [3]
    network_interface_ids = ["${azurerm_network_interface.SecondADNIC.id}"]
    vm_size               = "Standard_B1s"
 
    storage_os_disk {
        name              = "server-ad-os2"
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
        computer_name  = "ADVM2"
        admin_username = "${var.user_id}"
        admin_password = "${var.password_id}"
    }
 
    os_profile_windows_config {
        provision_vm_agent        = true
        enable_automatic_upgrades = true
    }

}

##############################################################################################

############################## Création LoadBalancer #########################################

resource "azurerm_lb" "LoadBalancer" {
  name                = "TestLoadBalancer"
  location            = "West Europe"
  resource_group_name = "${var.ressource_id}"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    #public_ip_address_id = azurerm_public_ip.SecondIP.id
    subnet_id            = "${azurerm_subnet.WebTierSubnet.id}"
  }
}

resource "azurerm_lb" "LoadBalancer2" {
  name                = "TestLoadBalancer2"
  location            = "West Europe"
  resource_group_name = "${var.ressource_id}"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress2"
    #public_ip_address_id = azurerm_public_ip.ThirdIP.id
    subnet_id             = "${azurerm_subnet.BusinessTierSubnet.id}"

  }
}

##############################################################################################
