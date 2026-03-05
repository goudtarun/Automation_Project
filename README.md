# DevOps Infrastructure Automation Project

## Project Overview

This project demonstrates **Infrastructure as Code (IaC)** and **Configuration Management** using modern DevOps tools.

Technologies used:

- **Terraform** → Provision AWS infrastructure
- **Ansible** → Configure servers and deploy applications
- **AWS EC2** → Compute instances
- **Nginx / Apache** → Web servers hosting a simple website

The infrastructure is **fully reproducible** and can be created or destroyed using Terraform.

---

# Project Implementations

This repository contains **two different implementations** of infrastructure automation.

## Basic Terraform + Ansible Setup

Location: basic-setup/

Features:

- Terraform provisions AWS infrastructure
- Ansible playbook configures managed nodes
- Nginx installed and configured
- Static website deployed

This setup demonstrates the **fundamental DevOps workflow using Terraform and Ansible**.

---
##  Role-Based Ansible Deployment

Location:


role-based-setup/


Features:

- Uses **Ansible roles for modular automation**
- Demonstrates **production-style Ansible architecture**
- Supports multiple services such as:

  - Nginx
  - Apache

- Infrastructure provisioned using Terraform
- Configuration managed through reusable roles

This setup demonstrates **advanced infrastructure automation using Ansible roles**.

---

# Architecture (Basic Setup)

## Components Created via Terraform

- VPC (10.0.0.0/16)
- Public Subnet (10.0.1.0/24)
- Internet Gateway
- Route Table + Association
- Security Group (HTTP + SSH)

### EC2 Instances

- Control Node
- Managed Node

**Note:**  
An **S3 backend bucket must be created before running `terraform init`** for Terraform state storage.

---

# Configuration via Ansible

- Install **Nginx** on Managed Node
- Deploy custom **index.html**
- Ensure Nginx service is **started and enabled**

---

# Workflow

1. Terraform provisions AWS infrastructure.
2. SSH into the Control Node.
3. Ansible runs playbooks against Managed Nodes.
4. Web server is configured automatically.
5. Website becomes accessible via Public IP.

---

# Repository Structure

```
Automation_Project
│
├── basic-setup/
│ ├── terraform/
│ │ ├── main.tf
│ │ ├── provider.tf
│ │ ├── backend.tf
│ │ └── variables.tf
│ │
│ └── ansible/
│ ├── ansible.cfg
│ ├── hosts
│ ├── first-pla.yml
│ └── index.html
│
├── role-based-setup/
│ ├── terraform/
│ ├── playbook.yml
│ └── roles/
│
├── .gitignore
└── README.md
```

##Terraform Usage:

Initialize Terraform

```bash
terraform init
```
Validate Configuration
```bash
terraform validate
```
Plan Infrastructure
```bash
terraform plan
```
Apply Infrastructure
```bash
terraform apply
```
Destroy Infrastructure
```bash
terraform destroy
```


##Ansible Usage

From the Control Node:

Test Connectivity
```bash
ansible -m ping prod
```
Run Playbook
```bash
ansible-playbook first-pla.yml
```
##Application Access

After successful deployment:
```bash
http://<Managed-Node-Public-IP>
```
You should see the deployed website.

## Security Notes

- SSH access is enabled using an EC2 key pair.
- AWS Security Groups allow the following inbound traffic:
  - Port **22 (SSH)** – for administrative access
  - Port **80 (HTTP)** – for web application access

**Production Recommendation**

- Restrict SSH access to trusted IP ranges instead of `0.0.0.0/0`.
- Consider using a **bastion host or AWS Systems Manager Session Manager** for secure administrative access.

---

## Key Learning Outcomes

Through this project the following DevOps concepts were implemented:

1. Designed and provisioned AWS infrastructure using **Terraform**
2. Implemented **VPC networking components** such as subnets, route tables, and internet gateways
3. Configured servers using **Ansible playbooks**
4. Implemented **modular automation using Ansible roles**
5. Ensured **idempotent configuration management**
6. Automated deployment of web servers (Nginx / Apache)
7. Structured infrastructure code following **real-world DevOps repository practices**

---

## Conclusion

This project demonstrates **end-to-end infrastructure provisioning and server configuration using Terraform and Ansible**.

It showcases two approaches to automation:

- **Basic setup** using Terraform and Ansible playbooks
- **Advanced setup** using modular **Ansible roles**

These approaches reflect common infrastructure automation patterns used in modern DevOps environments.

