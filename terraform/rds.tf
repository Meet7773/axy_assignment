resource "aws_db_subnet_group" "db" {
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_db_instance" "postgres" {
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  multi_az             = true

  db_subnet_group_name = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.db.id]

  username = "axyuser"
  password = "example-password"

  backup_retention_period = 7
  publicly_accessible     = false
  skip_final_snapshot     = true
}
