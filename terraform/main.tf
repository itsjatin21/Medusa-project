provider "aws" {
  region = "us-east-1" 
  
}

resource "aws_s3_bucket" "S3_bucket" {
    bucket = "jatin-backend-1234-xyz"  
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.S3_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-lock" {
  name         = "terraform-lock1"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

module "vpc" {
  source = "./modules/vpc"
  
}
module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id

}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source             = "./modules/ECS"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  public_subnet_ids  = module.vpc.public_subnets
  db_endpoint        = module.rds.db_endpoint
  redis_endpoint     = module.redis.redis_endpoint
  task_exec_role_arn  = module.iam.task_exec_role_arn
  task_role_arn      = module.iam.task_role_arn
  security_groups    = module.security.ecs_sg_ids
  
}


module "rds" {
  source = "./modules/rds"
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnets
  db_password             = "jatin1234"
  vpc_security_group_ids  = module.security.rds_sg_ids
}

module "redis" {
  source = "./modules/redis"
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  
}

module "nat_gateway" {
  source              = "./modules/nat"
  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = module.vpc.public_subnets[0]  
  private_subnet_ids  = module.vpc.private_subnets
}


