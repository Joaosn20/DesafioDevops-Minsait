# Criação de um resource_group 
resource "azurerm_resource_group" "default" {
  name = "rg-desafio-devops"
  location = var.location
  tags = {
      "env": "staging"
      "project": "desafio-devops"
  }
}

# Criação da Virtual Network
resource "azurerm_virtual_network" "default" {
  name = "vnet-desafio-devops"
  location = var.location
  resource_group_name = azurerm_resource_group.default.name
  address_space = ["10.0.0.0/16"]
    tags = {
      "env": "staging"
      "project": "desafio-devops"
  }
}
# Sub-net
resource "azurerm_subnet" "interna" {
  name = "interna"
  virtual_network_name = azurerm_virtual_network.default.name
  resource_group_name = azurerm_resource_group.default.name
  address_prefixes = ["10.0.1.0/24"]

  depends_on = [azurerm_virtual_network.default]
}

resource "azurerm_subnet" "staging" {
  name = "staging"
  virtual_network_name = azurerm_virtual_network.default.name
  resource_group_name = azurerm_resource_group.default.name
  address_prefixes = ["10.0.2.0/24"]

  depends_on = [azurerm_virtual_network.default]
}

# Definição de IP publico
resource "azurerm_public_ip" "default" {
  name = "${var.vm}-pi"
  location = var.location
  resource_group_name = azurerm_resource_group.default.name
  allocation_method = "Static"
}

# Interface de rede

resource "azurerm_network_interface" "default" {
  name = "${var.vm}-nic"
  location = var.location
  resource_group_name = azurerm_resource_group.default.name

  ip_configuration {
    name = "${var.vm}-ipconfig"
    subnet_id = azurerm_subnet.interna.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.default.id

  } 
}

# Criação do Security_Group e Security_Rule.

resource "azurerm_network_security_group" "default" {
  name = "${var.vm}-nsg"
  location = var.location
  resource_group_name = azurerm_resource_group.default.name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Conexão do Security_Group e a Interface de rede.

resource "azurerm_network_interface_security_group_association" "default"{
  network_interface_id = azurerm_network_interface.default.id
  network_security_group_id = azurerm_network_security_group.default.id
}
# Carregar o conteúdo do docker-compose.yml

# Carregar o conteúdo do docker-compose.yml
data "local_file" "docker_compose" {
  filename = "${path.module}/docker-compose.yml"
}

# Script de inicialização
data "template_file" "init_script" {
  template = file("${path.module}/init-script.sh")

  vars = {
    username               = var.username
    docker_compose_content = data.local_file.docker_compose.content
  }
}
# Cria a virtual machine

resource "azurerm_virtual_machine" "main" {
  name = "vm-desafio-devops"
  location = var.location
  resource_group_name = azurerm_resource_group.default.name
  network_interface_ids = [azurerm_network_interface.default.id]
  vm_size = "Standard_B1s"

  storage_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }
  storage_os_disk {
    name = "${var.vm}-osdisk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name = var.vm
    admin_username = var.username
    admin_password = var.password
    custom_data = data.template_file.init_script.rendered
    }
  os_profile_linux_config {
    disable_password_authentication = false

  }
    depends_on = [
    azurerm_network_interface.default,
    azurerm_network_security_group.default
    ]
}