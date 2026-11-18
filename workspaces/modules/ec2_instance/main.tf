
provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "pkr-webapp" {
  ami                         = var.ami_id
  subnet_id                   = var.subnet_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_pair
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
