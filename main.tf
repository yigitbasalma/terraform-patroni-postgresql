module "haproxy" {
  source = "./modules/ec2"

  # Variables
  ami_id                = var.ami_id
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  application           = "haproxy"
  instance_type         = var.haproxy_instance_type
  instance_count        = var.haproxy_instance_count
  user_data             = data.template_cloudinit_config.haproxy.rendered
  ssh_key_name          = var.ssh_key_name
  ssh_username          = var.ssh_username
  ssh_private_key_path  = var.ssh_private_key_path
  permitted_ssh_ips     = distinct(concat(var.permitted_ssh_ips, ["${trim(data.http.source_ip.body, "\n")}/32"]))
  hostname_prefix       = local.haproxy_hostname_prefix
  env_suffix            = local.env_suffix[var.environment]
  dns_zone_id           = data.aws_route53_zone.zone.zone_id
  dns_zone_name         = data.aws_route53_zone.zone.name
  create_nlb            = [{internal: true, protected: false}]
  tags                  = local.tags
}

module "etcd" {
  source = "./modules/ec2"

  # Variables
  ami_id                = var.ami_id
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  application           = "etcd"
  instance_type         = var.etcd_instance_type
  instance_count        = var.etcd_instance_count
  user_data             = data.template_cloudinit_config.etcd.rendered
  ssh_key_name          = var.ssh_key_name
  ssh_username          = var.ssh_username
  ssh_private_key_path  = var.ssh_private_key_path
  permitted_ssh_ips     = distinct(concat(var.permitted_ssh_ips, ["${trim(data.http.source_ip.body, "\n")}/32"]))
  hostname_prefix       = local.etcd_hostname_prefix
  env_suffix            = local.env_suffix[var.environment]
  dns_zone_id           = data.aws_route53_zone.zone.zone_id
  dns_zone_name         = data.aws_route53_zone.zone.name
  tags                  = local.tags
}

module "postgres" {
  source = "./modules/ec2"

  # Variables
  ami_id                = var.ami_id
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  application           = "postgresql"
  instance_type         = var.postgres_instance_type
  instance_count        = var.postgres_instance_count
  user_data             = data.template_cloudinit_config.postgres.rendered
  ssh_key_name          = var.ssh_key_name
  ssh_username          = var.ssh_username
  ssh_private_key_path  = var.ssh_private_key_path
  permitted_ssh_ips     = distinct(concat(var.permitted_ssh_ips, ["${trim(data.http.source_ip.body, "\n")}/32"]))
  hostname_prefix       = local.postgres_hostname_prefix
  env_suffix            = local.env_suffix[var.environment]
  dns_zone_id           = data.aws_route53_zone.zone.zone_id
  dns_zone_name         = data.aws_route53_zone.zone.name
  extra_storages        = var.postgres_storages
  tags                  = local.tags
}

module "ansible" {
  source = "./modules/ansible"

  etcd_private_ips      = module.etcd.private_ip_addresses
  haproxy_private_ips   = module.haproxy.private_ip_addresses
  postgres_private_ips  = module.postgres.private_ip_addresses
  ssh_username          = var.ssh_username
  ssh_private_key_path  = var.ssh_private_key_path


  depends_on = [
    module.etcd,
    module.haproxy,
    module.postgres
  ]
}