
# AWS Provider
provider "aws" {
  region = "ap-southeast-2"
}

# Variables
variable "cidr" {
  default = "10.0.0.0/16"
}

variable "ami_id" {
  description = "Ubuntu AMI ID for ap-southeast-2"
  type        = string
}

variable "key_pair" {
  type = string
}

variable "instance_type" {
  default = "t2.micro"
}

# VPC
resource "aws_vpc" "pkr_vpc" {
  cidr_block = var.cidr

  tags = {
    Name = "pkr-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "pkr_subnet" {
  vpc_id                  = aws_vpc.pkr_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pkr-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "pkr_igw" {
  vpc_id = aws_vpc.pkr_vpc.id

  tags = {
    Name = "pkr-igw"
  }
}

# Route Table
resource "aws_route_table" "pkr_rt" {
  vpc_id = aws_vpc.pkr_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pkr_igw.id
  }

  tags = {
    Name = "pkr-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "pkr_rta" {
  subnet_id      = aws_subnet.pkr_subnet.id
  route_table_id = aws_route_table.pkr_rt.id
}

# Security Group
resource "aws_security_group" "pkr_sg" {
  name   = "PKRSG"
  vpc_id = aws_vpc.pkr_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_PUBLIC_IP/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "pkr-sg"
  }
}

# EC2 Instance
resource "aws_instance" "pkr_webapp" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "pavan-key"

  subnet_id                   = aws_subnet.pkr_subnet.id
  vpc_security_group_ids      = [aws_security_group.pkr_sg.id]
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/Users/pavan.reddy/Downloads/pavan-terraform.pem")
    host        = self.public_ip
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",                  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip", # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }

  tags = {
    Name = "pkr-webapp"
  }
}
