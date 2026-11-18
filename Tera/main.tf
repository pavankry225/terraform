provider "aws" {
  region = "ap-southeast-2"
}

module "ec2_instance" {
  source = "./modules/ec2"

  ami_id        = "ami-0035703403a170bf1"
  instance_type = "t3.micro"
  subnet_id     = "subnet-077be822a707c1b15"
  key_pair      = "pkr-terraform"
}
