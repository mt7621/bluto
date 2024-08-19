output "bastion" {
  value = aws_instance.bastion_ec2.public_ip
}

output "rds" {
  value = aws_db_instance.main.address
}
