project_name          = "generic"
project_code          = "gn"
domain                = "warewave.local"
region                = "us-east-1"
profile               = "warewave"
vpc_id                = "vpc-0kslmelskmf5e1f5c"
ami_id                = "ami-0be8373b2d2d56b72"  # Rocky Linux
environment           = "test"
base_tags             = {
  "Created-by" = "iac-terraform"
}
permitted_ssh_ips     = [
  "172.30.0.0/16"  # VPC CIDR
]
ssh_key_name          = "warewave-dev"  # The key must be exists on the AWS
ssh_username          = "rocky"  # Virtual machine user for ansible connection
ssh_private_key_path  = "/path/to/warewave-dev"  # Private key path for ansible connecton

# VPC
subnet_ids      = [
  "subnet-02f7c0a02f7c0a02f",
  "subnet-0b22ad2740b22ad27",
  "subnet-0f4d2f0f4d2f0f4d2"
]

# HAProxy
haproxy_instance_type         = "t2.micro"
haproxy_instance_count        = 3

# ETCD
etcd_instance_type         = "t2.micro"
etcd_instance_count        = 3

# Postgres
postgres_instance_type         = "r6i.large"
postgres_instance_count        = 3
postgres_storages              = [
  {
    device_name: "/dev/xvdb",
    mount_point: "/opt/data",
    size: 100
  }
]