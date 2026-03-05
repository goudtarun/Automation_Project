# Basic Terraform + Ansible Setup

This implementation demonstrates simple infrastructure provisioning
using Terraform and configuration using an Ansible playbook.

Components:
- Terraform provisions VPC, subnet, EC2 instances
- Ansible installs Nginx on managed node
- Static website deployed

Usage:

terraform init
terraform apply

ansible-playbook first-pla.yml
