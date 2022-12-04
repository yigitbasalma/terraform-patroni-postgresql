# Get all available zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Get source IP
data "http" "source_ip" {
  url = "https://ifconfig.io"
}

# Get zone info
data "aws_route53_zone" "zone" {
  name         = "${var.domain}."
  private_zone = true
}

# HAProxy user data
data "template_file" "haproxy" {
  template = file("${path.module}/templates/user_data/haproxy.sh")
}

data "template_cloudinit_config" "haproxy" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.haproxy.rendered
  }
}

# ETCD user data
data "template_file" "etcd" {
  template = file("${path.module}/templates/user_data/etcd.sh")
}

data "template_cloudinit_config" "etcd" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.etcd.rendered
  }
}

# Postgres user data
data "template_file" "postgres" {
  template = file("${path.module}/templates/user_data/postgres.sh")
}

data "template_cloudinit_config" "postgres" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.postgres.rendered
  }
}