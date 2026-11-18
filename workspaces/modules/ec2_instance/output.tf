output "public_ip" {
  value = aws_instance.pkr-webapp.public_ip
}
output "private_ip" {
  value = aws_instance.pkr-webapp.private_ip
}
output "instance_type" {
  value = aws_instance.pkr-webapp.instance_type
}
output "instance_id" {
  value = aws_instance.pkr-webapp.id
}
output "ami_id" {
  value = aws_instance.pkr-webapp.ami
}

