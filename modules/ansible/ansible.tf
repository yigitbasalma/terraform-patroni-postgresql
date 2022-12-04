resource "local_file" "inventory" {
  filename              = "${path.module}/../../ansible/inventories/hosts"
  file_permission       = "0755"
  directory_permission  = "0755"
  content               = <<-EOT
[haproxy]
%{ for ip in var.haproxy_private_ips ~}
${ip}
%{ endfor ~}

[etcd]
%{ for ip in var.etcd_private_ips ~}
${ip}
%{ endfor ~}

[postgres]
%{ for ip in var.postgres_private_ips ~}
${ip}
%{ endfor ~}
  EOT
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${path.module}/../../ansible/inventories/hosts --private-key ${var.ssh_private_key_path} -e ansible_user='${var.ssh_username}' -e ansible_remote_tmp='/tmp/.ansible/tmp' ${path.module}/../../ansible/playbooks/cluster.yaml"
  }

  depends_on = [
    local_file.inventory
  ]
}