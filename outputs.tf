output "haproxy_private_ip_addresses" {
  value = module.haproxy.private_ip_addresses
}

output "extra_storages" {
  value = module.postgres.extra_storages
}