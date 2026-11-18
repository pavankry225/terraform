variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "ami_id" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "key_pair" {
  type    = string
  default = "pkr-terraform"
}
