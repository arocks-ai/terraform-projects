## create VMs in Azure with Terraform

#### 0. view file structure
Reference - https://medium.com/turknettech/how-to-create-vms-in-azure-with-terraform-32b85965a0af</br>
$ tree  
```
├── main.tf
├── outputs.tf
├── providers.tf
└── variables.tf
```
File details are below:
```
providers.tf - azurerm provider setup
variables.tf - resource group location.
outputs.tf   - Get VM’s resource group name, public IP and private key of the SSH-key.
main.tf      - Create VNet >> Subnet >> Public IP >> NSG Rule >> Network Interface >> Connect NSG to NI 
               NSG Rule for allowing SSH Traffic on port 22 
             - Create VM with OS Disk and admin SSH Keys
```
#### 1. Create Azure resources as per main.tf 
```
$ terraform init

$ terraform validate 

$ terraform plan
$ terraform plan -out azure-vm-creation-plan
$ terraform show azure-vm-creation -no-color > azure-vm-creation.txt

$ terraform apply
$ terraform apply azure-vm-creation-plan
```
##### 1.1 View following output as per outputs.tf file.
```
Resource Group Name
Public IP of the VM
Private key of the SSH key
```
##### 1.2 Get private key of the VM created 
```
terraform output -raw tls_private_key > secureadmin_id_rsa
ssh -i secureadmin_id_rsa secureadmin@<public_ip_of_VM>
exit  # exist from VM
```
#### 2. Removing the created Resources
```
$ terraform plan -destroy
$ terraform destroy 
$ terraform apply -destory 
```
