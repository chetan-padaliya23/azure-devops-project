# azure-devops-project
## Overview

This project demonstrates a fully automated Azure infrastructure 
deployment using modern DevOps practices. Instead of manually 
creating cloud resources through the Azure Portal, all infrastructure 
is defined as code using Terraform and deployed automatically via 
GitHub Actions CI/CD pipelines.

The project provisions a complete Azure environment including 
networking, security, and a Linux VM — which automatically 
bootstraps Docker and serves an Nginx web server on startup.

## Tech Stack

| Tool | Purpose |
|---|---|
| Terraform | Infrastructure as Code — provisions all Azure resources consistently, tracks state in remote backend, prevents duplication |
| Azure | Cloud provider — hosts all infrastructure including VNet, NSG, and Linux VM |
| GitHub Actions | CI/CD pipeline — automatically runs Terraform and deploys Docker on every push |
| Docker | Containerization — runs Nginx as a container on the VM |
| Nginx | Web server — serves as the deployed application to verify infrastructure is working |

## Infrastructure

All resources provisioned using Terraform on Azure:

| Resource | Name |
|---|---|
| Resource Group | rg-devops-project |
| Virtual Network | vnet-devops-project |
| Subnet | subnet-devops-project |
| Public IP | public-ip-devops-project |
| Network Interface | nic-devops-project |
| Network Security Group | nsg-devops-project |
| NSG Association | Links NSG to NIC |
| Linux Virtual Machine | vm-devops-project |


## CI/CD Pipeline

Three GitHub Actions workflows automate the entire lifecycle:

| Workflow | Trigger | Purpose |
|---|---|---|
| `terraform.yml` | Push to main | Checks out code, logs into Azure via OIDC, runs Terraform init/plan/apply, then deploys Docker container on VM via SSH |
| `terraform-destroy.yml` | Manual (workflow_dispatch) | Destroys all Azure resources — used for cleanup to avoid unnecessary cloud costs |
| `terraform-drift.yml` | Daily at 8:00 AM | Detects infrastructure drift — exit code 0 means no changes, 1 means error, 2 means drift detected |

## How to Deploy

### Prerequisites
- Azure account with an active subscription
- GitHub account
- Terraform installed locally
- SSH key pair generated

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/<your-username>/azure-devops-project.git
cd azure-devops-project
```

**2. Configure GitHub Secrets**

Go to GitHub repo → Settings → Secrets → Actions and add:

| Secret | Description |
|---|---|
| `AZURE_CLIENT_ID` | Azure Service Principal Client ID |
| `AZURE_TENANT_ID` | Azure Tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure Subscription ID |
| `SSH_PUBLIC_KEY` | Public key for VM access |
| `SSH_PRIVATE_KEY` | Private key for GitHub Actions SSH step |
| `VM_PUBLIC_IP` | Static public IP of the Azure VM |

**3. Configure OIDC Federated Identity**

Set up federated identity in Azure to allow GitHub Actions to 
authenticate via OIDC — no passwords or credentials stored.
Add `terraform/federated.json` to `.gitignore` to avoid 
exposing federation config.

**4. Deploy**

Push any change to `main` branch — GitHub Actions will 
automatically run Terraform and deploy Docker on the VM.


## Project Learnings

- **Terraform** — Learned to write Infrastructure as Code, manage 
  resources, and migrate Terraform state to Azure Blob Storage 
  as a remote backend

- **OIDC Authentication** — Configured federated identity between 
  GitHub Actions and Azure — no passwords or secrets needed for 
  authentication

- **CI/CD Pipelines** — Built three production-style GitHub Actions 
  workflows for deploy, destroy, and drift detection

- **SSH Key Pairs** — Generated and managed SSH keys for secure 
  VM access and automated pipeline connectivity

- **Git Hygiene** — Learned what to push and what to keep out of 
  version control using `.gitignore`

- **Docker** — Deployed and managed Nginx container on a live 
  Azure VM, with automated bootstrapping via cloud-init