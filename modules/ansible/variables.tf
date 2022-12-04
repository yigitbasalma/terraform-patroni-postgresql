variable "ssh_private_key_path" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "haproxy_private_ips" {
  type = list(string)
}

variable "etcd_private_ips" {
  type = list(string)
}

variable "postgres_private_ips" {
  type = list(string)
}