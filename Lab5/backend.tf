terraform {
  backend "azurerm" {
resource_group_name  = "Terra-rg"
storage_account_name = "remotesa02"
container_name       = "tfstate"
key                  = "Lab5.tfstate"

  }
}