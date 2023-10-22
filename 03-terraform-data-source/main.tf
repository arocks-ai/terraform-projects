# AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Set env variabels for  
#        AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION
provider "aws" { }


# Create EC2 instance T2 micro
resource "aws_instance" "ec2_example" {
    ami           = "ami-0b0ea68c435eb488d" # region specific
    instance_type =  "t2.micro"

    tags = {
      Name = "Terraform EC2"
    }
}

# data configuration to fetch EC2 configuration
data "aws_instance" "myawsinstance" {
    # filter - which ec2 info to retrive
    #     in this case, Tag name
    filter {  
        name = "tag:Name"
        values = ["Terraform EC2"]
    }

    # depends_on - which resource to use for 
    #    in this case, ec2 instance
    depends_on = [
      aws_instance.ec2_example
    ]
}

# dispay Public IP form data configuration
output "fetched_info_from_aws" {
  value = data.aws_instance.myawsinstance.public_ip
}
