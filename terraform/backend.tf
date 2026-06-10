terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devops-project"
    storage_account_name = "teerraformtfstate"
    container_name       = "cont-tfstate"
    key                  = "terraform.tfstate"
  }
}