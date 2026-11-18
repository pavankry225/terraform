
provider "aws" {
  region = "ap-southeast-2"
}

module "ec2_instance" {
  source             = "./modules/ec2_instance"
  ami_id             = var.ami_id
  instance_type      = var.instance_type[terraform.workspace]
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  key_pair           = var.key_pair
  instance_name      = "${terraform.workspace}-${lookup(instance_type, terraform.workspace, "default")}"
}
