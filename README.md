# multi-cloud-deployment

## Overview

This repository contains the deployment code for a sample serverless application designed to run on AWS, Azure, and GCP. The project leverages Terraform for Infrastructure as Code (IaC) to manage deployments across multiple cloud environments, ensuring modular and reusable infrastructure components. The deployment includes secure and authenticated networking, Kubernetes clusters for request routing, and integration with cloud-native SQL solutions.

## Repository Structure

- `terraform/` - Contains Terraform modules for setting up infrastructure on AWS, Azure, and GCP.
  - `aws/` - AWS-specific modules for networking, Kubernetes (EKS), and serverless infrastructure (AWS Lambda).
  - `azure/` - Azure-specific modules for networking, Kubernetes (AKS), and serverless infrastructure (Azure Functions).
  - `gcp/` - GCP-specific modules for networking, Kubernetes (GKE), and serverless infrastructure (Google Cloud Functions).
- `manifests/` - Kubernetes manifests for deploying resources in each cloud environment.
- `functions/` - Python code for serverless functions compatible with AWS Lambda, Azure Functions, and Google Cloud Functions.
- `sql/` - SQL scripts for setting up the database schema and sample data on cloud-native SQL solutions.
- `digrams/` - Documentation and architecture diagrams illustrating the system design and deployment flow.

## Prerequisites

- Terraform v1.0+
- kubectl and access to Kubernetes clusters (EKS, AKS, GKE)
- AWS CLI, Azure CLI, GCP SDK
- Python 3.7+
- Cloud provider accounts (AWS, Azure, GCP)
- Git

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/multi-cloud-deployment.git
cd multi-cloud-deployment
```

### 2. Authenticate with Cloud Providers

Before deploying infrastructure, ensure you are authenticated with each cloud provider and have the necessary permissions:

    AWS: Configure your AWS credentials using aws configure or authenticate via SSO or another method.

   
 ```bash
aws configure
```

Azure: Login using the Azure CLI:

```bash
az login
```

GCP: Authenticate using the Google Cloud SDK:

```bash
gcloud auth login
gcloud config set project [PROJECT_ID]
```

### 3. Initialize Terraform Modules

Navigate to the appropriate cloud provider directory (e.g., terraform/aws/) and initialize Terraform:

```bash

cd terraform/aws
terraform init
```

Repeat the above steps for the Azure and GCP directories.

### 4. Deploy Infrastructure

To deploy the infrastructure and apply the Kubernetes ingress controller manifests automatically, navigate to the respective directory and run:

```bash

terraform apply -var="ingress_manifest_path=manifest/aws/ingress-controller.yaml"
```

The ingress_manifest_path variable will change depending on the cloud provider. For example:

    AWS: -var="ingress_manifest_path=manifest/aws/ingress-controller.yaml"
    Azure: -var="ingress_manifest_path=manifest/azure/ingress-controller.yaml"
    GCP: -var="ingress_manifest_path=manifest/gcp/ingress-controller.yaml"

The local-exec provisioner within the Terraform configuration uses this variable to run the following command:

```bash

provisioner "local-exec" {
  command = "kubectl apply -f ${var.ingress_manifest_path}"
}
```

This applies the ingress controller manifest during the Terraform apply process.