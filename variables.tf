variable "region" {
  description = "Target region"
  type        = string
}

variable "profile" {
  description = "Profile name for aws resources"
  type        = string
}

variable "domain" {
  description = "Domain name for hostname"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_code" {
  description = "Project code"
  type        = string
}

variable "vpc_id" {
  description = "Target VPC ID"
  type        = string
}

variable "ami_id" {
  description = "General ami-id"
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "base_tags" {
  description = "Default tags for all resources"
  type        = map(string)
}

variable "subnet_ids" {
  description = "Subnet IDS"
  type        = list(string)
}

variable "permitted_ssh_ips" {
  description = "Allowed IPs for SSH"
  type        = list(string)
}

variable "ssh_key_name" {
  description = "SSH key name for connection"
  type        = string
}

variable "ssh_private_key_path" {
  description = "SSH key path for Ansible"
  type        = string
}

variable "ssh_username" {
  description = "SSH username for connection"
  type        = string
}

# HAProxy Config
variable "haproxy_instance_type" {
  description = "HAProxy instance type for resource"
  type        = string
  default     = "t2.micro"
}

variable "haproxy_instance_count" {
  description = "HAProxy instance count for resource"
  type        = number
  default     = 3
}

# ETCD Config
variable "etcd_instance_type" {
  description = "ETCD instance type for resource"
  type        = string
  default     = "t2.micro"
}

variable "etcd_instance_count" {
  description = "ETCD instance count for resource"
  type        = number
  default     = 3
}

# PostgreSQL Config
variable "postgres_instance_type" {
  description = "PostgreSQL instance type for resource"
  type        = string
  default     = "r6g.medium"
}

variable "postgres_instance_count" {
  description = "PostgreSQL instance count for resource"
  type        = number
  default     = 3
}

variable "postgres_storages" {
  description = "Extra mount storages configurations"
  type        = list(object({
    device_name: string,
    size: number,
    mount_point: string
  }))
  default     = []
}
