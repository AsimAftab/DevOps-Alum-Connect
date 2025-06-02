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

resource "azurerm_resource_group" "rg" {
  name     = "devops-rg"
  location = "East US"
}

resource "azurerm_service_plan" "plan" {
  name                = "devops-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

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
}

  app_settings = {
    WEBSITES_PORT = "3000" # Change if your app runs on another port
  }
}
