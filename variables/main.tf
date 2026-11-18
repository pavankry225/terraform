provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "pkr-app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_pair
}
