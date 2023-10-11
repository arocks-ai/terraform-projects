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
0. Configure Terrafrom to use Azure account
Get details from SP creation output and assign to the following variables
```bash
 $vi .connection.env
  export ARM_CLIENT_ID="xxx" <appID>
  export ARM_CLIENT_SECRET="xxx" <Password>
  export ARM_SUBSCRIPTION_ID="xxx" <SubscriptionID>
  export ARM_TENANT_ID="xxx" <TenantID>

 $source .connection.env
```
1. Initialize terraform first
  ```bash
  terraform init
  ```
2.Plan the terraform deployment.
  ```bash
  terraform plan
  terraform plan -out z-plan-aks-create   # save plan into a file
  terraform show z-plan-aks-create -no-color  > z-plan-aks-create.txt # dump plan into plain text file
  
  ```
3. Apply terraform configuration
  ```bash
    terraform apply
    terraform apply -var aks_service_principal_app_id="$ARM_CLIENT_ID" -var aks_service_principal_client_secret="$ARM_CLIENT_SECRET"
  ```
4. After some time (6-7 mins.) Terraform will create AKS. Get the kubeconfig with
  ```bash
  terraform output -raw kube_config > aks_kubeconfig
  ```
5. Export the kubeconfig with
  ```bash
  export KUBECONFIG=aks_kubeconfig  
  kubectl config view --kubeconfig=aks_kubeconfig  # Usage example if export is not used
  ```
6. After getting the kubeconfig check the cluster status with
  ```bash
  kubectl get nodes  # if kubeconfig file exported 
  kubectl get nodes --kubeconfig=aks_kubeconfig  # using custom kube-config file
  ```