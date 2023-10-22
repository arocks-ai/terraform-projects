## Create data reource for AWS EC2 instance

#### 1. AWS setup
Specify the following env variables AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION</br>
usage inside .tf file</br>
  provider aws {} 


#### 2. Create AWS EC2 resource
Make sure AMI machine ID is supported on the selected region</br>
Usage:</br>
  resource "aws_instance" "ec2_example"  {...}


#### 3. Create data resource
Look for filter and depends_on</br>
```
data "aws_instance" "myawsinstance" {...}
depends_on - what resource to refer for .. example: ec2 instance
filter - which ec2 to refer, example: Tag name "Terraform EC2"
```

##### 4. Run
```
$ terraform init
$ terraform plan
$ terraform apply   

# cleanup
$ terraform destroy 
```
