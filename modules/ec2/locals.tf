locals {
  tags  = merge(
    var.tags,
    {
      Module = "ec2"
    }
  )

  extra_storages = flatten([
    for instance in aws_instance.instance: [
      for s_config in var.extra_storages: merge(s_config, { availability_zone = instance.availability_zone, instance_id=instance.id })
    ]
  ])
}