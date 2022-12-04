resource "aws_network_interface" "instance" {
  count                = var.instance_count

  subnet_id            = random_shuffle.subnet.result[0]
  security_groups      = [aws_security_group.instance.id]

  tags = merge(
      local.tags,
      {
          Name = "${var.application}_primary_network_interface"
      }
  )
}

resource "aws_instance" "instance" {
  count                       = var.instance_count

  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_name
  monitoring                  = true

  network_interface {
    network_interface_id = aws_network_interface.instance[count.index].id
    device_index         = 0
  }

  root_block_device {
    volume_size = 100
  }

  metadata_options {
    http_endpoint          = "enabled"
    instance_metadata_tags = "enabled"
  }

  user_data = var.user_data

  tags = merge(
    local.tags,
    {
      "Name" = "${var.hostname_prefix}${count.index + 1}${var.env_suffix}"
    }
  )
}