resource "aws_ebs_volume" "instance" {
  count = length(local.extra_storages)

  availability_zone = local.extra_storages[count.index].availability_zone
  size              = local.extra_storages[count.index].size

  tags = {
    FileSystem  = local.extra_storages[count.index].mount_point,
    Application = title(var.application),
    InstanceID  = local.extra_storages[count.index].instance_id,
    DeviceNAme  = local.extra_storages[count.index].device_name
  }
}

resource "aws_volume_attachment" "instance" {
  count = length(aws_ebs_volume.instance)

  device_name = aws_ebs_volume.instance[count.index].tags.DeviceNAme
  volume_id   = aws_ebs_volume.instance[count.index].id
  instance_id = aws_ebs_volume.instance[count.index].tags.InstanceID
}