terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "first" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "first"
  }
}

# Create a security group
resource "aws_security_group" "first_sg" {
  vpc_id = aws_vpc.first.id
  name = "allow_tls"
  tags = {
    Name = "first"
  }
}

# creation of subnet

resource "aws_subnet" "first_subnet" {
  vpc_id = aws_vpc.first.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "first"
  }
}

resource "aws_internet_gateway" "first_ig" {
  vpc_id = aws_vpc.first.id
  
  tags = {
    Name = "first"
  }
}

#resource "aws_internet_gateway_attachment" "first-igw" {
 # vpc_id = aws_vpc.first.id
 # internet_gateway_id = aws_internet_gateway.first_ig.id
  
#}

resource "aws_route_table" "first_rt" {
  vpc_id = aws_vpc.first.id

  tags = {
    Name = "first"
  }
}

resource "aws_route" "first-route" {
  route_table_id = aws_route_table.first_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.first_ig.id 
  }

resource "aws_route_table_association" "rt_assc" {
  subnet_id = aws_subnet.first_subnet.id
  route_table_id = aws_route_table.first_rt.id
  
}

resource "aws_security_group_rule" "Http_allow" {
  security_group_id = aws_security_group.first_sg.id
  from_port = 80
  to_port = 80
  protocol = "tcp"
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]


}

resource "aws_security_group_rule" "ssh_allow" {
  security_group_id = aws_security_group.first_sg.id
  from_port = 22
  protocol = "tcp"
  to_port = 22
  type =  "ingress"
  cidr_blocks = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "all" {
  security_group_id = aws_security_group.first_sg.id
  from_port = 0
  to_port = 65535
  type = "egress"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}



resource "aws_instance" "first" {
    ami = "ami-0b6c6ebed2801a5cb"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.first_sg.id]
    subnet_id = aws_subnet.first_subnet.id
    associate_public_ip_address = true
    key_name = "Tarun"
    tags = {
      Name = "Control_node"
      Environment = "first"
      Project = "test"    
    }

}

resource "aws_instance" "first1" {
    ami = "ami-0b6c6ebed2801a5cb"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.first_sg.id]
    subnet_id = aws_subnet.first_subnet.id
    associate_public_ip_address = true
    key_name = "Tarun"
    tags = {
      Name = "Managed-Node"
      Environment = "First"
      Project = "Test"
      
    }
}



output "public_ip" {
  value = [aws_instance.first.public_ip , aws_instance.first1.public_ip]
}





