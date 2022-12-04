output "haproxy_private_ip_addresses" {
  value = module.haproxy.private_ip_addresses
}

output "ro_lb_addr" {
  value = "${module.haproxy.network_lb}:5001"
}

output "rw_lb_addr" {
  value = "${module.haproxy.network_lb}:5000"
}