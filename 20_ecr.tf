resource "aws_ecr_repository" "token" {
  name = "token"
  force_delete = true
}

resource "aws_ecr_repository" "employee" {
  name = "employee"
  force_delete = true
}