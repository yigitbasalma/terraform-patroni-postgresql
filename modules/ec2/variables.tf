variable "ami_id" {
  type = string
}

variable "vpc_id" {
  type  = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "instance_type" {
  type  = string
}

variable "ssh_key_name" {
  type = string
}

variable "permitted_ssh_ips" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "application" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "ssh_private_key_path" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "hostname_prefix" {
  type = string
}

variable "env_suffix" {
  type = string
}

variable "dns_zone_id" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "user_data" {
  type = string
}

variable "extra_storages" {
  type = list(object({
    device_name: string,
    size: number,
    mount_point: string
  }))
  default = []
}

variable "create_nlb" {
  type    = list(object({
    internal: bool,
    protected: bool
  }))
  default = []
}