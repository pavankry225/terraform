variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "key_pair" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}

variable "instance_name" {
  description = "The name tag to apply to the instance"
  type        = string
}
