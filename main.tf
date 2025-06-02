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
  sku_name            = "B1"      # ✅ Replace old 'sku' block with this
}

resource "azurerm_app_service" "app" {
  name                = "devops-alum-connect"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_service_plan.plan.id

  site_config {
    linux_fx_version = "DOCKER|asimaftab47/devops-alum-connect:latest"
    always_on        = true
  }
}
