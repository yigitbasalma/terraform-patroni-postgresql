#!/bin/env bash

set -euo pipefail
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user data..."

# Disable selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

# Set hostname
curl http://169.254.169.254/latest/meta-data/tags/instance/Name \
  -H "X-aws-ec2-metadata-token: $(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")" >> /etc/.hostname-ec2
curl http://169.254.169.254/latest/meta-data/tags/instance/Domain \
  -H "X-aws-ec2-metadata-token: $(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")" >> /etc/.domain-ec2
hostnamectl set-hostname "$(cat /etc/.hostname-ec2).$(cat /etc/.domain-ec2)"

touch /home/rocky/success
echo "All done"