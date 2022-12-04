resource "aws_route53_record" "a" {
  count   = var.instance_count

  zone_id = var.dns_zone_id
  name    = "${var.hostname_prefix}${count.index + 1}${var.env_suffix}.${var.dns_zone_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.instance[count.index].private_ip]
}