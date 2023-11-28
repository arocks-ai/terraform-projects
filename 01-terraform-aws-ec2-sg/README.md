## Create data reource for AWS EC2 instance
Create EC2 Instance </br>
 - Configure Security groups to allow the certain in bound traffic
 - use the pub/private keys which are already created on the system
 - Install tha apache websever using the boot strap script
 - output the public IP 

#### 1. AWS configuration setup
Export AWS access key and secret key as variables AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION</br>
usage inside .tf file</br>
  provider aws {} 


#### 2. Setup -  Create AWS EC2 resource
Make sure AMI machine ID is supported on the selected region</br>
Usage:</br>
  resource "aws_instance" "ec2_example"  {...}


#### 3. EC2 supported data 
Set up the following </br>
```
variable instance_count           # value 2 for creating two  EC2 instances
variable instance_type            # value t2.micro for EC2 instance type
output "instance_public_ip"       # Display public IP of the EC2 on the console
resource "aws_key_pair" "ssh_key" # upload the private key which is already present on the system
user_data inside aws_instance {}  # Boot strap commands to install the webserver 
tags {}                           # Specify the Tag name

resource "aws_security_group" "ec2_sg_traffic" # Create Security group to allow in-bound traffic on ports 80, 443 and 22
```

##### 4. Run
```
$ terraform init
$ terraform plan
$ terraform apply   

# cleanup
$ terraform destroy 
```

##### 5. Check the web server on EC2
```
# Get the public ip using the output variable 
# iplist.txt: File with ip address in plain text after parsing the output
# tr for remove unwanted char set, sed for remove empty lines
terraform output instance_public_ip | tr -d "\",[] " | sed '/^$/d' > iplist.txt

# Send request to each server
while read ip1; do curl $ip1; done < iplist.txt

curl {public-ip-here}  # it should print the message rendered by the server.
```


##### 6. Diagram view
```
# Generate the diagram based on the terraform files
terraform graph | dot -Tsvg > graph.svg
```