variable "ami_id" {
  description = "AMI Id for EC2"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_id" {
  type = string
}

variable "key_pair" {
  type    = string
  default = "pkr-terraform"
}
