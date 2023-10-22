## Create data reource for AWS EC2 instance

#### 1. AWS setup
```
Specify the following env variables AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION
usage inside .tf file
  provider aws {} 
```

#### 2. Create AWS EC2 resource
Make sure AMI machine ID is supported on the selected region
Usage:
  resource "aws_instance" "ec2_example"  {...}


#### 3. Create data resource
```
data "aws_instance" "myawsinstance" {...}
depends_on - what resource to refer for .. example: ec2 instance
filter - which ec2 to refer, example: Tag name "Terraform EC2"v
```

##### 4. Run
```
$ terraform init
$ terraform plan
$ terraform apply   

# cleanup
$ terraform destroy 
```
