resource "aws_lb" "instance" {
  count              = length(var.create_nlb) > 0 ? 1 : 0

  name               = "${var.application}-nlb"
  internal           = var.create_nlb.0.internal
  load_balancer_type = "network"
  subnets            = var.subnet_ids

  enable_deletion_protection = var.create_nlb.0.protected

  tags = local.tags
}

resource "aws_lb_target_group" "read_write" {
  count    = length(var.create_nlb) > 0 ? 1 : 0

  name     = "${var.application}-ro"
  port     = 5001
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "read_only" {
  count    = length(var.create_nlb) > 0 ? 1 : 0

  name     = "${var.application}-rw"
  port     = 5000
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "read_write" {
  count            = length(var.create_nlb) > 0 ? length(aws_instance.instance) : 0

  target_group_arn = aws_lb_target_group.read_write.0.arn
  target_id        = aws_instance.instance[count.index].id
  port             = 5001
}

resource "aws_lb_target_group_attachment" "read_only" {
  count            = length(var.create_nlb) > 0 ? length(aws_instance.instance) : 0

  target_group_arn = aws_lb_target_group.read_only.0.arn
  target_id        = aws_instance.instance[count.index].id
  port             = 5000
}

resource "aws_lb_listener" "read_write" {
  count             = length(aws_lb.instance) > 0 ? 1 : 0

  load_balancer_arn = aws_lb.instance.0.arn
  port              = "5001"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.read_write.0.arn
  }
}

resource "aws_lb_listener" "read_only" {
  count             = length(aws_lb.instance) > 0 ? 1 : 0

  load_balancer_arn = aws_lb.instance.0.arn
  port              = "5000"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.read_only.0.arn
  }
}