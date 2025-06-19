variable "container_registry_name" {
  description = "(Required) The name of the Container Registry."
  type        = string
}

variable "container_registry_login_server" {
  description = "(Required) The login server of the Container Registry."
  type        = string
}

variable "subscription_id" {
  description = "(Required) The Subscription ID."
  type        = string
}
