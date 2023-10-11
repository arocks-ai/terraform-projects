# Terraform Create Kubernetes Cluster on Azure (AKS)

This terraform code will provision an AKS service on Azure like detailed below:
* Node count is currently 3
* Node size is currently Standard_D2_v2
* Network plugin is currently kubenet

## Prerequisites

* Terraform 1.0.0
* Setting required variables such as:
  - cluster_name
  - dns_prefix
  - resource_group_name
  - agent_count
  - admin_username
* Setting variables in terraform.tfvars file
  - aks_service_principal_app_id
  - aks_service_principal_client_secret
* kubectl CLI package to test connection


## Usage

1. Initialize terraform first
  ```bash
  terraform init
  ```
1. After initialization, you can plan your terraform deployment.
  ```bash
  terraform plan
  ```
1. Apply your terraform configuration
  ```bash
    terraform apply
  ```
1. After some time (6-7 mins.) Terraform will create AKS. Get the kubeconfig with
  ```bash
  terraform output -raw kubeconfig > aks_kubeconfig
  ```
1. Export the kubeconfig with
  ```bash
  export KUBECONFIG=aks_kubeconfig
  ```
1. After getting the kubeconfig check the cluster status with
  ```bash
  kubectl get nodes
  ```