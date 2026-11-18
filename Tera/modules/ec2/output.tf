output "public_ip" {
  value = aws_instance.pkr-app.public_ip
}

output "private_ip" {
  value = aws_instance.pkr-app.private_ip
}
