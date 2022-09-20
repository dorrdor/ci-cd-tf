resource "azurerm_subnet" "controller_sub" {
  name                 = "controller_sub"
  resource_group_name  = var.RG
  virtual_network_name = var.VN
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "controller_pip" {
  name                = "controller_pip"
  resource_group_name = var.RG
  location            = var.loc
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "controller_nic" {
  name                = "controller_nic"
  location            = var.loc
  resource_group_name = var.RG

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.controller_sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.controller_pip.id

  }
}

resource "azurerm_linux_virtual_machine" "controller-vm" {
  name                = "controller-vm"
  resource_group_name = var.RG
  location            = var.loc
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.controller_nic.id,
  ]

   # configure the app on the vm
  custom_data = filebase64("/Users/ross/Desktop/bootcamp/week6/scale_set/controller/controller_run.sh")
                            
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/controller.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}