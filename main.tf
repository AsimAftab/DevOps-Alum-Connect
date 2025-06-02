terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
 
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "devops-rg"
  location = "East US"
}

# Create Linux-based App Service Plan
resource "azurerm_service_plan" "plan" {
  name                = "devops-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Create Linux Web App using Docker
resource "azurerm_linux_web_app" "app" {
  name                = "devops-alum-connect"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
  application_stack {
    docker_image_name = "asimaftab47/devops-alum-connect"
    docker_image_tag  = "latest"
  }
  always_on = true
}
  app_settings = {
    WEBSITES_PORT = "3000" # Update this if your container exposes a different port
  }
}
