
variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = map(string)

  default = {
    qa    = t3.micro
    stage = t3.micro
    prod  = t3.small

  }
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "key_pair" {
  type = string
}

variable "instance_name" {
  type = string
}
