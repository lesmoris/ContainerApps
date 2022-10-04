# GLOBAL VARIABLES

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
  default     = "EastUS"
}

variable "resource_group_name" {
   description = "(Required) Name of the resource group where the resources will be created. Must exist beforehand"
   type        = string
}

variable "tags" {
  description = "(Optional) Specifies the tags of the log analytics workspace"
  type        = map(any)
  default     = {}
}

# LOG ANALYTICS WORKSPACE

variable "log_analytics_workspace_name" {
  description = "(Required) Specifies the name of the log analytics workspace"
  type        = string
}

variable "log_analytics_retention_days" {
  description = "(Optional) Specifies the number of days of the retention policy for the log analytics workspace."
  type        = number
  default     = 60
}

# APPLICATION INSIGHTS

variable "application_insights_name" {
  description = "(Required) Specifies the name of the application insights resource."
  type        = string
}

variable "application_insights_application_type" {
  description = "(Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created."
  type        = string
}

# STORAGE ACCOUNT

variable "storage_account_name" {
  description = "(Required) Specifies the name of the storage account"
  type        = string
}

variable "storage_account_replication_type" {
  description = "(Optional) Specifies the replication type of the storage account"
  default     = "LRS"
  type        = string

  validation {
    condition = contains(["LRS", "ZRS", "GRS", "GZRS", "RA-GRS", "RA-GZRS"], var.storage_account_replication_type)
    error_message = "The replication type of the storage account is invalid."
  }
}

variable "storage_account_kind" {
  description = "(Optional) Specifies the account kind of the storage account"
  default     = "StorageV2"
  type        = string

   validation {
    condition = contains(["Storage", "StorageV2"], var.storage_account_kind)
    error_message = "The account kind of the storage account is invalid."
  }
}

variable "storage_account_tier" {
  description = "(Optional) Specifies the account tier of the storage account"
  default     = "Standard"
  type        = string

   validation {
    condition = contains(["Standard", "Premium"], var.storage_account_tier)
    error_message = "The account tier of the storage account is invalid."
  }
}

variable "storage_account_container_name" {
  description = "(Required) Specifies the name of the container in the storage account."
  type        = string
}

variable "storage_account_container_access_type" {
  description = "(Optional) Specifies the access type of the container in the storage account."
  type        = string
  default     = "private"
}

# CONTAINER APPS MANAGED ENVIRONMENT

variable "managed_environment_name" {
  description = "(Required) Specifies the name of the managed environment."
  type        = string
}

variable "managed_environment_subnet_id" {
  description = "(Required) Specifies the subnet to use for the managed environment."
  type        = string
}

# POSTGRESQL 

variable "postgresql_server_name" {
  description = "(Required) Specifies the name of the PostgreSQL server"
  type        = string
}

variable "postgresql_server_zone" {
  description = "(Optional) Specifies the zone of the PostgreSQL server"
  type        = number
  default     = 1
}

variable "postgresql_server_administrator_login" {
  description = "(Required) Specifies the admin user of the PostgreSQL server"
  type        = string
}

variable "postgresql_server_administrator_password" {
  description = "(Required) Specifies the admin password of the PostgreSQL server"
  type        = string
}

variable "postgresql_server_sku" {
  description = "(Required) Specifies the PostgreSQL server SKU"
  type        = string
}

variable "postgresql_server_version" {
  description = "(Optional) Specifies the PostgreSQL server version"
  type        = number
  default     = 13
}

variable "postgresql_server_storage" {
  description = "(Optional) Specifies the PostgreSQL server storage"
  type        = number
  default     = 32768
}

variable "postgresql_server_delegated_subnet_id" {
  description = "(Required) Specifies the subnet to use for the PostgreSQL server"
  type        = string
}

variable "postgresql_server_private_dns_zone_id" {
  description = "(Required) Specifies the private dns zone id to use for the PostgreSQL server"
  type        = string
}

# CONTAINER REGISTRY

variable "container_registry_name" {
  description = "(Required) Specifies the Container Registry name"
  type        = string
}

variable "container_registry_sku" {
  description = "(Required) Specifies the Container Registry SKU"
  type        = string
}

variable "container_registry_admin_enabled" {
  description = "(Required) Specifies if the Container Registry has to have the admin user enabled"
  type        = bool
}
