variable "resource_group_name" {
  description = "(Required) The name of the Resource Group."
  type        = string
}

variable "location" {
  description = "(Required) The location of the Azure resources (e.g. westeurope)."
  type        = string
}

variable "location_abbreviation" {
  description = "(Required) The location abbreviation (e.g. weu)."
  type        = string
}

variable "environment" {
  description = "(Required) The environment name (e.g. test)."
  type        = string
}

variable "dns_prefix" {
  description = "(Required) DNS prefix specified when creating the managed cluster."
  type        = string
}

variable "vnet_subnet_id" {
  description = "(Required) The ID of a Subnet where the Kubernetes Node Pool should exist."
  type        = string
}

variable "authorized_ip_ranges" {
  description = "(Required) Authorized IP address ranges to allow access to API server."
  type        = list(string)
}

variable "storage_account_id" {
  description = "(Required) The ID of the Storage Account."
  type        = string
}

variable "subscription_id" {
  description = "(Required) The Subscription ID."
  type        = string
}

variable "tags" {
  description = "(Optional) The Tags for the Azure resources."
  type        = map(string)
  default     = {}
}
