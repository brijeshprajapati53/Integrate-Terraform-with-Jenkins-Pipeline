provider "azurerm" {
  features {}
  subscription_id = "c1ff822a-8d32-49f1-b97a-89c2b2a1b55e"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-jenkins"
  location = var.location
}

resource "azurerm_service_plan" "this" {
  name                = "appserviceplanBrijesh11"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"

  sku_name = "B1"

}

resource "azurerm_linux_web_app" "this" {
  name                = "webapijenkinsBrijesh111"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id  # Updated attribute

  site_config {
    always_on = true
    
    application_stack {
      dotnet_version = "8.0"
}
}
}