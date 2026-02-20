<h1> DevOps Infrastructure Automation Project </h1>

Project Overview

This project demonstrates Infrastructure as Code (IaC) and Configuration Management using:

**Terraform** → Provision AWS infrastructure

**Ansible** → Configure servers and deploy application

**AWS EC2** → Compute instances

**Nginx** → Web server hosting a simple website

The infrastructure is fully reproducible and can be created and destroyed using Terraform.

<h3>Architecture</h3>
##Components Created via Terraform:

    - VPC (10.0.0.0/16)

    - Public Subnet (10.0.1.0/24)

    - Internet Gateway

    - Route Table + Association

    - Security Group (HTTP + SSH)

    - 2 EC2 Instances:

        * Control Node
        * Managed Node
**Backend S3 bucket must be created before running terraform init for state file locking**

##Configuration via Ansible:

- Install Nginx on Managed Node

- Deploy custom index.html

- Ensure Nginx service is started and enabled


##Workflow

1. Terraform provisions infrastructure.

2. SSH into Control Node.

3. Ansible runs playbook against Managed Node.

4. Nginx serves the deployed website.

5. Website accessible via Managed Node Public IP


##Project Structure
```bash
devops-project/
│
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   ├── backend.tf
│   └── variables.tf
│
├── ansible/
│   ├── ansible.cfg
│   ├── hosts
│   ├── first-pla.yml
│   └── index.html
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

##Security Notes

    * SSH access enabled via key pair

    * Security group allows:

    *  Port 22 (SSH)

    * Port 80 (HTTP)

**For production, SSH should be restricted to trusted IP ranges**


##Key Learning Outcomes

1. Designed and provisioned AWS infrastructure using Terraform
2. Understood VPC networking (subnets, route tables, IGW)
3. Managed configuration using Ansible
4. Ensured idempotent playbook execution
5. Automated web server deployment

##Conclusion

This project demonstrates end-to-end infrastructure provisioning and server configuration using industry-standard DevOps tools.


