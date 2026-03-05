




# Create a VPC
resource "aws_vpc" "first" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "first"
  }
}



# creation of subnet

resource "aws_subnet" "first_subnet" {
  vpc_id = aws_vpc.first.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a" 
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

# Create a security group
resource "aws_security_group" "first_sg" {
  vpc_id = aws_vpc.first.id
  tags = {
    Name = "first"
  }
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
  cidr_blocks = ["49.204.30.236/32"]

}

resource "aws_security_group_rule" "ssh_allow_per" {
  security_group_id = aws_security_group.first_sg.id
  from_port = 22
  protocol = "tcp"
  to_port = 22
  type =  "ingress"
  cidr_blocks = ["49.204.27.4/32"]

}


resource "aws_security_group_rule" "all" {
  security_group_id = aws_security_group.first_sg.id
  from_port = 0
  to_port = 0
  type = "egress"
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "ssh_ansible" {
  vpc_id = aws_vpc.first.id
  name = "tls"
  
}

resource "aws_security_group_rule" "ssh_ansible" {
  security_group_id = aws_security_group.ssh_ansible.id
  source_security_group_id = aws_security_group.first_sg.id
  from_port = 22
  to_port = 22
  protocol = "tcp"
  type = "ingress"
  
}

resource "aws_security_group_rule" "http" {
  security_group_id = aws_security_group.ssh_ansible.id
  from_port = 80
  to_port = 80
  protocol = "tcp"
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  
}

resource "aws_security_group_rule" "ssh_ansible_eg" {
  security_group_id = aws_security_group.ssh_ansible.id
  from_port = 0
  to_port = 0
  type = "egress"
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  
}


resource "aws_instance" "Control_node" {
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

resource "aws_instance" "Managed_Node" {
    ami = "ami-0b6c6ebed2801a5cb"
    instance_type = "t3.micro"
    vpc_security_group_ids =  [aws_security_group.ssh_ansible.id]
    subnet_id = aws_subnet.first_subnet.id
    associate_public_ip_address = true
    key_name = "Tarun"
    tags = {
      Name = "Managed_Node"
      Environment = "First"
      Project = "Test"
      
    }
}

resource "aws_instance" "managed_node_rh" {
  ami = "ami-0ad50334604831820"
  instance_type = "t3.micro"
  vpc_security_group_ids =  [aws_security_group.ssh_ansible.id]
  associate_public_ip_address =  true
  subnet_id = aws_subnet.first_subnet.id
  key_name = "redhat"
  tags = {
    Name = "Managed_Node"
    Environment = "Test"   
  }
}

resource "aws_instance" "managed_node_al" {
  ami= "ami-0f3caa1cf4417e51b"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ssh_ansible.id]
  subnet_id = aws_subnet.first_subnet.id
  key_name = "redhat"
  tags = {
    Name = "Managed_Node"
    Environment = "Test"
  }
}









