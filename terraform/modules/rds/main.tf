resource "aws_db_subnet_group" "main" {
    name       = "medusa-db-subnet"
    subnet_ids = var.private_subnet_ids
  
}
resource "aws_db_instance" "medusa" {
    identifier = "medusa-db"
    engine     = "postgres"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    username   = "postgres"
    password   = "jatin1234"        
    db_name    = "medusa-medusa"
    db_subnet_group_name = aws_db_subnet_group.main.name
    skip_final_snapshot = true
    vpc_security_group_ids = var.vpc_security_group_ids

  
}
