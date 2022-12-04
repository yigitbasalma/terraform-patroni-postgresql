resource "aws_security_group" "instance" {
  name_prefix = "${title(var.application)} Servers SG"
  description = "${title(var.application)} Server Security Rules"
  vpc_id      = var.vpc_id

  tags = merge(
    local.tags,
    {
      Name = "${title(var.application)} Server"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "instance_allow_ssh_restricted" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.permitted_ssh_ips
  security_group_id = aws_security_group.instance.id
}

resource "aws_security_group_rule" "instance_allow_custom_restricted" {
  type              = "ingress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.permitted_ssh_ips
  security_group_id = aws_security_group.instance.id
}

resource "aws_security_group_rule" "instance_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance.id
}