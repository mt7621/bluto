resource "aws_security_group" "rds" {
  name = "wsi-rds-sg"
  vpc_id = aws_vpc.vpc.id
  ingress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = "3306"
    to_port = "3306"
  }
  egress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = "3306"
    to_port = "3306"
  }
  lifecycle {
    ignore_changes = [ingress, egress]
  }
}

resource "aws_db_subnet_group" "main" {
  name = "wsi-rds-subgrp"
  subnet_ids = [
    aws_subnet.app_subnet_a.id,
    aws_subnet.app_subnet_b.id,
  ]
  tags = {
    "Name" = "wsi-rds-subgrp"
  }
}

resource "aws_db_instance" "main" {
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name = aws_db_subnet_group.main.name
  publicly_accessible = false
  allocated_storage = 20
  identifier = "apdev-rds-instance"
  db_name = "dev"
  engine = "mysql"
  engine_version = "8.0.36"
  instance_class = "db.t3.micro"
  storage_type = "gp3"
  port = "3306"
  username = "admin"
  password = "Skill53##"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
}