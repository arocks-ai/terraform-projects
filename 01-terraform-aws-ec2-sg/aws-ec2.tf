provider "aws" {
   region     = "us-east-1"
#   access_key = "AKIA4QUT6AFHXIDWA5KT"
#   secret_key = "RW2m9Rz60yYaT21gYl1ZEU3dn1g0yvYPabgLF4c4"
}


# AWS EC2 resource 
resource "aws_instance" "ec2_t2micro_example" {
   ami            = "ami-0e8a34246278c21e4"
   instance_type  =  var.instance_type
   count          = var.instance_count
   key_name       = aws_key_pair.ssh_key.key_name
   security_groups = ["ec2-sg-allow-incoming-traffic"]
   associate_public_ip_address = var.enable_public_ip
   
  user_data = <<-EOF
    #!/bin/bash
    echo "Installing sample webserver"
    sudo yum update -y
    sudo yum install -y amazon-linux-extras
    sudo amazon-linux-extras enable httpd_modules
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
    EOF

   tags = {
       Name = "Terraform EC2"
   }
}

output "instance_public_ip" {
   value = [aws_instance.ec2_t2micro_example.*.public_ip]
}
output "ec2-connect-usage" {
   value = "ssh -i private-key ec2-user@publicip"
}


# Access EC2: ssh -i {private-key} ec2-user@public-ip
# Use custom provided Key pair from development system
resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = file("~/work/terraform-projects/.ssh/id_rsa.pub")
}

resource "aws_security_group" "ec2_sg_traffic" {
  name = "ec2-sg-allow-incoming-traffic"
  description = "Inbound outbound rules for the EC2"

  #Incoming traffic
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #replace it with your ip address
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #replace it with your ip address
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #replace it with your ip address
  }


  #Outgoing traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# AMI Type 
variable "instance_type" {
   description = "Instance type t2.micro"
   type        = string
   default     = "t2.micro"
}

# Number of EC2 instances
variable "instance_count" {
  description = "EC2 instance count"
  type        = number
  default     = 2
}

# Expose public IP or not (this seems optional)
variable "enable_public_ip" {
  description = "Enable public IP address"
  type        = bool
  default     = true
}