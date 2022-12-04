output "private_ip_addresses" {
  value = aws_instance.instance[*].private_ip
}

output "extra_storages" {
  value = local.extra_storages
}

output "network_lb" {
  value = length(var.create_nlb) > 0 ? aws_lb.instance.0.dns_name : "None"
}