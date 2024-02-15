#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = "slovink"
  description = "ManagedBy, eg 'slovink'."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}
variable "repository" {
  type        = string
  default     = "https://github.com/slovink/terraform-azure-monitor-alerts"
  description = "Terraform current module repo"
}

variable "actionGroups" {
  type = map(object({
    actionGroupName          = string
    actionGroupShortName     = string
    actionGroupRGName        = string
    actionGroupEnabled       = string
    actionGroupEmailReceiver = list(map(string))
  }))
  default = {}
}

variable "metricAlerts" {
  type = map(object({
    alertName                  = string
    alertResourceGroupName     = string
    alertScopes                = list(string)
    alertDescription           = string
    alertEnabled               = bool
    alertAutoMitigate          = bool
    alertFrequency             = string
    alertTargetResourceType    = string
    alertTargetResourceLoc     = string
    dynCriteriaMetricNamespace = string
    dynCriteriaMetricName      = string
    dynCriteriaAggregation     = string
    dynCriteriaOperator        = string
    dynCriteriathreshold       = string
    actionGroupID              = string
  }))
  default = {}
}

variable "activity_log_alert" {
  type = map(object({
    alertname      = string
    alertrg        = string
    alertscopes    = list(string)
    description    = string
    operation_name = string
    actionGroupID  = string
    category       = string
  }))

  default = {}
}

