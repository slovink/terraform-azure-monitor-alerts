# Terraform-azure-monitor-alerts

# Terraform Azure Cloud Monitor-Alerts Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Examples](#examples)
- [Author](#author)
- [License](#license)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Introduction
This module provides a Terraform configuration for deploying various Azure resources as part of your infrastructure. The configuration includes the deployment of resource groups, monitor-alerts.

## Usage
To use this module, you should have Terraform installed and configured for AZURE. This module provides the necessary Terraform configuration
for creating AZURE resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Examples

# Example: AzMonitor-ActionGroups

```hcl
module "azmonitor-action-groups" {
  source      = "../../"
  name        = "app"
  environment = "test"
  actionGroups = {
    "group1" = {
      actionGroupName      = "AlertEscalationGroup"
      actionGroupShortName = "alertesc"
      actionGroupRGName    = module.resource_group.resource_group_name
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "example"
          email_address           = "thexxxxxxxxxxxxxx@gmail.com"
          use_common_alert_schema = "true"
        },
        {
          name                    = "test"
          email_address           = "thedxxxxxxxxxxxxgmail.com"
          use_common_alert_schema = "true"
        }
      ]
    }
  }
}
```

# Example: AzMonitor-ActivityLogAlerts

```hcl
module "alerts" {
  depends_on  = [data.azurerm_monitor_action_group.example, ]
  source      = "./../../"
  name        = "app"
  environment = "test"
  activity_log_alert = {
    "test1" = {
      alertname      = "vm-restart"
      alertrg        = module.resource_group.resource_group_name
      alertscopes    = [module.resource_group.resource_group_id]
      description    = "Administrative alerts for vm"
      operation_name = "Microsoft.Compute/virtualMachines/restart/action"
      actionGroupID  = data.azurerm_monitor_action_group.example.id
      category       = "Administrative"
    },
    "test2" = {
      alertname      = "vm-powerOff"
      alertrg        = module.resource_group.resource_group_name
      alertscopes    = [module.resource_group.resource_group_id]
      description    = "Administrative alerts for vm"
      operation_name = "Microsoft.Compute/virtualMachines/powerOff/action"
      actionGroupID  = data.azurerm_monitor_action_group.example.id
      category       = "Administrative"
    }
  }
}
```

# Example: AzMonitor-MetricAlerts

```hcl
module "azmonitor-metric-alerts" {
  depends_on = [data.azurerm_monitor_action_group.example, data.azurerm_kubernetes_cluster.example]
  source     = "./../../"
  name        = "app"
  environment = "test"
  metricAlerts = {
    "alert1" = {
      alertName              = "testing-alert"
      alertResourceGroupName = module.resource_group.resource_group_name
      alertScopes = [
        data.azurerm_kubernetes_cluster.example.id
      ]
      alertDescription           = ""
      alertEnabled               = "true"
      dynCriteriaMetricNamespace = "Microsoft.ContainerService/managedClusters"
      dynCriteriaMetricName      = "node_cpu_usage_percentage"
      dynCriteriaAggregation     = "Average"
      dynCriteriaOperator        = "GreaterThan"
      dynCriteriathreshold       = "1"
      alertAutoMitigate          = "true"
      alertFrequency             = "PT1M"
      alertTargetResourceType    = "Microsoft.ContainerService/managedClusters"
      alertTargetResourceLoc     = data.azurerm_kubernetes_cluster.example.location
      actionGroupID              = data.azurerm_monitor_action_group.example.id
    },
    "alert2" = {
      alertName              = "testing-alert2"
      alertResourceGroupName = module.resource_group.resource_group_name
      alertScopes = [
        data.azurerm_kubernetes_cluster.example.id
      ]
      alertDescription           = ""
      alertEnabled               = "true"
      dynCriteriaMetricNamespace = "Microsoft.ContainerService/managedClusters"
      dynCriteriaMetricName      = "node_memory_working_set_percentage"
      dynCriteriaAggregation     = "Average"
      dynCriteriaOperator        = "GreaterThan"
      dynCriteriathreshold       = "1"
      alertAutoMitigate          = "true"
      alertFrequency             = "PT1M"
      alertTargetResourceType    = "Microsoft.ContainerService/managedClusters"
      alertTargetResourceLoc     = data.azurerm_kubernetes_cluster.example.location
      actionGroupID              = data.azurerm_monitor_action_group.example.id
    }

  }
}

```

This example demonstrates how to create various AZURE resources using the provided modules. Adjust the input values to suit your specific requirements.

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/slovink/terraform-azure-monitor-alerts/tree/master/_examples) directory within this repository.

## License
This Terraform module is provided under the **MIT** License. Please see the [LICENSE](https://github.com/slovink/terraform-azure-monitor-alerts/blob/master/LICENSE) file for more details.

## Author
Your Name
Replace **MIT** and **slovink** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.87.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git@github.com:slovink/terraform-azure-labels.git | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_action_group.group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_activity_log_alert.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert) | resource |
| [azurerm_monitor_metric_alert.alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actionGroups"></a> [actionGroups](#input\_actionGroups) | n/a | <pre>map(object({<br>    actionGroupName          = string<br>    actionGroupShortName     = string<br>    actionGroupRGName        = string<br>    actionGroupEnabled       = string<br>    actionGroupEmailReceiver = list(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_activity_log_alert"></a> [activity\_log\_alert](#input\_activity\_log\_alert) | n/a | <pre>map(object({<br>    alertname      = string<br>    alertrg        = string<br>    alertscopes    = list(string)<br>    description    = string<br>    operation_name = string<br>    actionGroupID  = string<br>    category       = string<br>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'slovink'. | `string` | `"slovink"` | no |
| <a name="input_metricAlerts"></a> [metricAlerts](#input\_metricAlerts) | n/a | <pre>map(object({<br>    alertName                  = string<br>    alertResourceGroupName     = string<br>    alertScopes                = list(string)<br>    alertDescription           = string<br>    alertEnabled               = bool<br>    alertAutoMitigate          = bool<br>    alertFrequency             = string<br>    alertTargetResourceType    = string<br>    alertTargetResourceLoc     = string<br>    dynCriteriaMetricNamespace = string<br>    dynCriteriaMetricName      = string<br>    dynCriteriaAggregation     = string<br>    dynCriteriaOperator        = string<br>    dynCriteriathreshold       = string<br>    actionGroupID              = string<br>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/slovink/terraform-azure-monitor-alerts"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ag"></a> [ag](#output\_ag) | n/a |
| <a name="output_metric-alerts"></a> [metric-alerts](#output\_metric-alerts) | n/a |
<!-- END_TF_DOCS -->