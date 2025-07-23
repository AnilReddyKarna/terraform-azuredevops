variable "subscription_id" {
  type = string
}
variable "prefix" {
  type = string
}

variable "location" {
  type = string
}
variable "hostname" {
  type = string
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type = string
}
variable "environment" {
  type = string
}
variable "vnet_address_space" {
  type = list(string)
}
variable "subnet_address_prefixes" {
  type = list(string)
}
