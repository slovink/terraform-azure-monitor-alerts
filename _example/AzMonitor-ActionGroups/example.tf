provider "azurerm" {
  features {}
}


module "resource_group" {
  source = "git::git@github.com:slovink/terraform-azure-resource-group.git?ref=1.0.0"

  name        = "app"
  environment = "example"
  label_order = ["name", "environment"]
  location    = "Canada Central"
}


module "azmonitor-action-groups" {
  source = "../../."
  actionGroups = {
    "group1" = {
      actionGroupName      = "AlertEscalationGroup"
      actionGroupShortName = "alertesc"
      actionGroupRGName    = module.resource_group.resource_group_name
      actionGroupEnabled   = true
      actionGroupEmailReceiver = [
        {
          name                    = "example"
          email_address           = "thexxxxxxxxx@gmail.com"
          use_common_alert_schema = true
        },

      ]
    }
  }
}
